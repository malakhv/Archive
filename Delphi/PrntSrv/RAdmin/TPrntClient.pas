unit TPrntClient;

interface

uses SysUtils, WinSock, NetGlobal;

type
  TClientStatus = (csNone = 0, csConnect = 1, csDisConnect = 2);

type
  TServer = record
    Socket: TSocket;
    ServerAddr: TSockAddr;
  end;

type
  TPrinterArray = array of TNetPrinterInfo;

type
  TPrinterCollection = class(TObject)
  private
    function GetCount: integer;
  public
    Item: TPrinterArray;
    property Count: integer read GetCount;
    procedure Add(PrInf: TNetPrinterInfo);
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TPClient = class(TObject)
  private
    FConnected: boolean;
    FStatus: TClientStatus;
    FMsg: TServerMsg;
    FIP: TIPStr;
  protected
    function SendMsgServer(Msg: TServerMsg): integer;
  public
    Server: TServer;
    Addr: TSockAddr;
    PArray: TPrinterCollection;
    property Status: TClientStatus read FStatus;
    property Connected: boolean read FConnected;
    property IP: TIPStr read FIP;
    function Connection(SAddr: string): boolean;
    procedure DisConnection;
    procedure LoadPrinterList;
    function LoadDBFile(SaveFileName: TFileName): boolean;
    procedure BDClear;
    constructor Create;
    destructor Destroy; override;
  end;



implementation

uses Dialogs;

{ TPrinterCollection }

procedure TPrinterCollection.Add(PrInf: TNetPrinterInfo);
begin
  SetLength(Item,Length(Item)+1);
  Item[Length(Item)-1] := PrInf;  
end;

procedure TPrinterCollection.Clear;
begin
  SetLength(Item,0);
end;

constructor TPrinterCollection.Create;
begin
  inherited Create;
  SetLength(Item,0);
end;

destructor TPrinterCollection.Destroy;
begin
  Clear;
  inherited;
end;

function TPrinterCollection.GetCount: integer;
begin
  Result := Length(Item);
end;

{ TPClient }

constructor TPClient.Create;
begin
  inherited Create;
  PArray := TPrinterCollection.Create;
  FConnected := false;
  FStatus := csNone;
end;

destructor TPClient.Destroy;
begin
  DisConnection;
  inherited;
end;

function TPClient.Connection(SAddr: string): boolean;
var lnAddr,ret: integer;
begin
  Result := false;
  if not WSAEnabled then Exit;
  Server.Socket := socket(AF_INET,SOCK_STREAM,0);
  FStatus := csNone;

  Server.ServerAddr.sin_family := AF_INET;
  Server.ServerAddr.sin_port := HtoNS(Def_Port);
  Server.ServerAddr.sin_addr.S_addr := Inet_addr(PAnsiChar(SAddr));

  if Server.Socket = INVALID_SOCKET then Exit;
  FStatus := csDisConnect;
  Server.ServerAddr.sin_port := HtoNS(Def_Port);
  lnAddr := sizeof(Server.ServerAddr);
  ret := connect(Server.Socket,Server.ServerAddr,lnAddr);
  if ret = 0 then
  begin
    FStatus := csConnect;
    FIP := SAddr;
    PArray.Clear;
    Result := true;
  end;
end;

procedure TPClient.DisConnection;
var len: integer;
begin
  if FStatus = csConnect then
  begin
    FStatus := csDisConnect;
    FMsg.Cmd := 0;
    FMsg.Param := '';
    len := sizeof(FMsg);
    Send(Server.Socket,FMsg,len,0);
    CloseSocket(Server.Socket);
  end;
end;

function TPClient.SendMsgServer(Msg: TServerMsg): integer;
var len: integer;
begin
  Result := -1;
  if FStatus = csConnect then
  begin
    len := sizeof(Msg);
    Result := Send(Server.Socket,Msg,len,0);
  end;
end;

procedure TPClient.LoadPrinterList;
var ret,len, count, i: integer;
    inf: TNetPrinterInfo;
begin
  PArray.Clear;
  if FStatus <> csConnect then Exit;
  FMsg.Cmd := 10; // Запрос на загрузку списка принтеров;
  FMsg.Param := '';
  ret := SendMsgServer(FMsg);
  if ret > 0 then
  begin
    len := sizeof(count);
    ret := recv(Server.Socket,count,len,0);
    if ret <= 0 then Exit;
    FMsg.Cmd := 11;
    ret := SendMsgServer(FMsg); // запрос на получение данных;
    if ret <= 0 then Exit;
    len := sizeof(inf);
    for i := 0 to count - 1 do
    begin
      ret := recv(Server.Socket,inf,len,0);
      if ret = len then
      begin
        PArray.Add(inf);
      end;
    end;
  end;
end;

function TPClient.LoadDBFile(SaveFileName: TFileName): boolean;
var ret, len, fsz, fln: integer;
    fl: integer;
    buf: array[0..1023] of byte;
begin
  Result := false;
  if FStatus <> csConnect then Exit;
  FMsg.Cmd := 20; // Запрос на загрузку БД;
  FMsg.Param := '';
  ret := SendMsgServer(FMsg);
  if ret > 0 then
  begin
    FMsg.Cmd := 21; // получение размера файла
    ret :=  SendMsgServer(FMsg);
    if ret <= 0 then Exit;
    len := sizeof(fsz);
    ret := recv(Server.Socket,fsz,len,0);
    if ret <= 0 then Exit;

    fl := FileCreate(SaveFileName);
    if fl = -1 then Exit;
    FileClose(fl);
    fl := FileOpen(SaveFileName,fmOpenWrite);
    len := sizeof(buf);
    fln := 0;
    //ret := recv(Server.Socket,buf,len,0);
    //fln := fln + ret;
    while fln <> fsz  do
    begin
      if fln > fsz then break;
      ret := recv(Server.Socket,buf,len,0);
      if ret <= 0 then break;
      FileWrite(fl,buf,ret);
      fln := fln + ret;
    end;
    FileClose(fl);
    Result := fln = fsz;
  end;
end;

procedure TPClient.BDClear;
begin
  FMsg.Cmd := 50;
  FMsg.Param := '';
  SendMsgServer(FMsg);
end;

end.
