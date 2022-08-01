unit TServerUnit;
interface
uses WinSock, Global, Drives, SysUtils, Files;

type TServerStat = (ssNone = 0, ssDisConnect = 1, ssConnect = 2);

type TServer = record
       Socket: TSocket;
       Status: TServerStat;
       ServerAddr: TSockAddr;
       LastMessage: TMesg;
     end;

type TBuf = array of byte;
type TName = string[200];

var Server: TServer;
    MyAddr: TSockAddr;
    Mesg: TMesg;
    Buf: TBuf;


function Connection(SAddr: string): boolean;
procedure DisConnection();
function SendMessageServer(sMesg:TMesg): integer;

function GetDriveList(var DList: TArrayDrive): integer;
function GetFileList(FName: TName): integer;
function DelFile(FName: TName): boolean;
function DelFolder(FName: TName): boolean;

function LoadFile(FInfo: TFileInfo; Dir: TName): boolean;

implementation

function Connection(SAddr: string): boolean;
var lnAddr,ret: integer;
begin
  Result := false;
  if not WSAEnabled then Exit;
  Server.Socket := socket(AF_INET,SOCK_STREAM,0);
  Server.Status := ssNone;

  Server.ServerAddr.sin_family := AF_INET;
  Server.ServerAddr.sin_port := HtoNS(Def_Port);
  Server.ServerAddr.sin_addr.S_addr := Inet_addr(PAnsiChar(SAddr));

  if Server.Socket = INVALID_SOCKET then Exit;
  Server.Status := ssDisConnect;
  Server.ServerAddr.sin_port := HtoNS(Def_Port);
  lnAddr := sizeof(Server.ServerAddr);
  ret := connect(Server.Socket,Server.ServerAddr,lnAddr);
  if ret = 0 then
  begin
    Server.Status := ssConnect;
    Result := true;
  end;
end;

procedure DisConnection();
var len,ret: integer;
begin
  if Server.Status = ssConnect then
  begin
    Server.Status := ssDisConnect;
    Mesg.FNum := 0;
    Mesg.Param := '';
    len := sizeof(Mesg);
    ret := Send(Server.Socket,Mesg,len,0);
    CloseSocket(Server.Socket);
  end;
end;

function GetDriveList(var DList: TArrayDrive): integer;
var ret, len, i, count: integer;  inf: TDriveInfo;
begin
  Result := 0;
  Mesg.FNum := 10;
  Mesg.Param := '';
  ret := SendMessageServer(Mesg);
  if ret > 0 then
  begin
    FreeDriveList;
    len := sizeof(count);
    ret := recv(Server.Socket,count,len,0); // количество элементов
    if ret <= 0 then Exit;
    Mesg.FNum := 11;
    Mesg.Param := '';
    ret := SendMessageServer(Mesg);
    if ret <= 0 then Exit;           // отправка запроса на получение данных
    len := sizeof(inf);
    for i := 0 to Count - 1 do
    begin
      ret := recv(Server.Socket,inf,len,0);
      if ret = len then
      begin
        AddDriveInfo(inf);
        FreeDriveInfo(inf);
        Result := Result + 1;
      end;
    end;
  end;
end;

function GetFileList(FName: TName): integer;
var ret, len, i, cn: integer;  inf: TFileInfo;
begin
  Result := 0;
  Mesg.FNum := 20;
  Mesg.Param := FName;
  ret := SendMessageServer(Mesg);
  if ret > 0 then
  begin
    ResetArrayResult;
    len := sizeof(cn);
    ret := recv(Server.Socket,cn,len,0); // количество элементов
    if ret <= 0 then Exit;
    if cn = 0 then Exit;
    Mesg.FNum := 21;
    Mesg.Param := '';
    ret := SendMessageServer(Mesg);
    if ret <= 0 then Exit;           // отправка запроса на получение данных

    len := sizeof(inf);
    for i := 0 to cn - 1 do
    begin
      ret := recv(Server.Socket,inf,len,0);
      if ret = len then
      begin
        AddFileInfo(inf);
        Result := Result + 1;
      end;
    end;
  end;
end;

function DelFile(FName: TName): boolean;
var ret, len, dl: integer;
begin
  Result := false;
  dl := 0;
  Mesg.FNum := 5;
  Mesg.Param := FName;
  ret :=  SendMessageServer(Mesg); // запрос на удаление
  if ret <= 0 then Exit;
  len := sizeof(dl);
  ret := recv(Server.Socket,dl,len,0);
  if ret <= 0 then Exit;
  if dl = 1 then Result := true;
end;

function DelFolder(FName: TName): boolean;
var ret, len, dl: integer;
begin
  Result := false;
  dl := 0;
  Mesg.FNum := 6;
  Mesg.Param := FName;
  ret :=  SendMessageServer(Mesg); // запрос на удаление
  if ret <= 0 then Exit;
  len := sizeof(dl);
  ret := recv(Server.Socket,dl,len,0);
  if ret <= 0 then Exit;
  if dl = 1 then Result := true;
end;

function LoadFile(FInfo: TFileInfo; Dir: TName): boolean;
var ret, len, fl, ln, sz: integer; buf: array[0..1023] of byte;
begin
  Mesg.FNum := 30;
  Mesg.Param := FInfo.FullName;
  if Dir[Length(Dir)]<>'\'then Dir := Dir + '\';
  Result := false;
  fl := FileCreate(Dir + FInfo.Name);
  if fl = -1 then Exit;
  FileClose(fl);
  fl := FileOpen(Dir + FInfo.Name,fmOpenWrite);
  ln := 0;
  sz := FInfo.FileSize;
  len := sizeof(buf);
  ret :=  SendMessageServer(Mesg);
  if ret <= 0 then Exit;
  while sz <> ln do
  begin
    ret := recv(Server.Socket,buf,len,0);
    if ret <= 0 then break;
    ln := ln + ret;
    FileWrite(fl,buf,ret);
  end;
  FileClose(fl);
end;

function SendMessageServer(sMesg:TMesg): integer;
var len: integer;
begin
  Result := -1;
  if Server.Status = ssConnect then
  begin
    len := sizeof(sMesg);
    Result := Send(Server.Socket,sMesg,len,0);
  end;
end;

end.
