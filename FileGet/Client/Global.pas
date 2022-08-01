unit Global;
interface
uses ComCtrls,SysUtils,WinSock, ShellAPI;

const Def_Port = 5320;

type TItemType = (itNone = 0, itDrive = 1, itFolder = 2, itFile = 3);

type TItemInfo = record
       Index: integer;
       ItemType: TItemType;
     end;
//------------------------------------------------------------------------------
// Сообщение содержащее номер функции и строковый параметр
type TMesg = record
      FNum : byte;
      Param: string[250];
     end;
//  0 - завершение соединения
//  1 - завершить работу сервера
//
//  5 - удалить файл;
//  10 - получить список дисков Param = '';
//  20 - Получить содержимое каталога Param = DirName;
//
//  30 - Копировать файл Param = FileName;
//  40 - Удалить файл в корзину Param = FileName;
//------------------------------------------------------------------------------

var   WSAData: TWSAData;
      WSAEnabled: boolean = false;
      HostEnt: PHostEnt;

procedure GetItemInfo(Item: TListItem; var Info: TItemInfo);
procedure SetItemInfo(Info: TItemInfo; var Item: TListItem);
procedure DelDataItem(var Item: TListItem);
procedure ClearListView(var ListView: TListView);
procedure NormalStr(var str:string);

//Сеть-
procedure StartWSA;
procedure StopWSA;
function GetLocalIP: String;                    // Получение своего IP
function IPAddrToName(IPAddr : string): string; // Получение имени по IP
//-----

//Файловые функции
function DelFolder(AHandle: THandle; ADirName: TFileName): integer;


implementation

procedure GetItemInfo(Item: TListItem; var Info: TItemInfo);
var inf: ^TItemInfo;
begin
  if Item.Data = nil then
  begin
    Info.Index := -1;
    Info.ItemType := itNone;
    Exit;
  end;
  inf := Item.Data;
  Info.Index := inf^.Index;
  Info.ItemType := inf^.ItemType;
end;

procedure SetItemInfo(Info: TItemInfo; var Item: TListItem);
var inf: ^TItemInfo;
begin
  New(inf);
  inf^.Index := Info.Index;
  inf^.ItemType := Info.ItemType;
  Item.Data := inf;
end;

procedure DelDataItem(var Item: TListItem);
var inf: ^TItemInfo;
begin
  if Item.Data = nil then Exit;
  inf := Item.Data;
  Dispose(inf);
  Item.Data := nil;
end;

procedure ClearListView(var ListView: TListView);
var i: integer; inf: ^TItemInfo;
begin
  for i := 0 to ListView.Items.Count - 1 do
  begin
    if ListView.Items.Item[i].Data <> nil then
    begin
      inf := ListView.Items.Item[i].Data;
      Dispose(inf);
      ListView.Items.Item[i].Data := nil;
    end;
  end;
  ListView.Items.Clear;
end;

procedure NormalStr(var str:string);
var i:integer;
begin
 for i := 1 to Length(str) do
   if(Ord(str[i]) >= 65)and(Ord(str[i]) <= 90)then
     str[i] := Chr(Ord(str[i]) + 32);
end;

//---------------------Сеть-----------------------------------------------------
procedure StartWSA;
begin
  WSAEnabled := WSAStartup($101,WSAData) <> -1;
end;

procedure StopWSA;
begin
  if not WSAEnabled then Exit;
  WSACleanup;
  WSAEnabled := false;
end;

function GetLocalIP: String;
var Buf: array [0..127] of Char;
begin
  Result := '';
  if not WSAEnabled then Exit;
  if GetHostName(@Buf, 128) = 0 then
  begin
    HostEnt := GetHostByName(@Buf);
    if HostEnt <> nil then Result := iNet_ntoa(PInAddr(HostEnt^.h_addr_list^)^);
  end;
end;

function IPAddrToName(IPAddr : string): string;
var SockAddrIn: TSockAddrIn;
begin
  Result := '';
  if not WSAEnabled then Exit;
  SockAddrIn.sin_addr.s_addr:= inet_addr(PChar(IPAddr));
  HostEnt:= gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
  if HostEnt <> nil then result := StrPas(Hostent^.h_name);
end;
//------------------------------------------------------------------------------

function DelFolder(AHandle: THandle; ADirName: TFileName): integer;
var SHFileOpStruct: TSHFileOpStruct;
    DirName: PChar; BufferSize: Cardinal;
begin
  BufferSize := Length(ADirName) + 1 + 1;
  GetMem(DirName, BufferSize);
  try
    FillChar(DirName^, BufferSize, 0);
    StrCopy(DirName, PChar(ADirName));
    with SHFileOpStruct do
    begin
      Wnd := AHandle;
      wFunc := FO_DELETE;
      pFrom := DirName;
      pTo := nil;
      fFlags := FOF_NOCONFIRMATION or FOF_SILENT;
      fAnyOperationsAborted := False;
      hNameMappings := nil;
      lpszProgressTitle := nil;
    end;
    if SHFileOperation(SHFileOpStruct) <> 0 then
      RaiseLastWin32Error;
  finally
    FreeMem(DirName, BufferSize);
  end;
end;

end.
