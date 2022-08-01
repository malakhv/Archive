unit TServerArrayUnit;
interface
uses WinSock,Global,ComCtrls;

type TServerStat = (ssNone = 0, ssDel = 1, ssDisConnect =2, ssConnect = 3);

type TServer = record
       Socket: TSocket;
       Status: TServerStat;
       ServerAddr: TSockAddr;
       LastMessage: TMes;
     end;

type TServerArray = array of TServer;

var Servers: TServerArray;
    ServerCount: integer = 0;
    MyAddr: TSockAddr;

procedure DeleteServer(index:integer = -1);
function AddServer(Addr: TSockAddr): integer;
procedure SendMessageServer(Mes:TMes;Index: integer);

implementation

uses tcpSendThreadUnit;

procedure DeleteServer(index: integer = -1);
var i: integer; snd: TSendMesThread;
begin
  if index <> -1 then
  begin
    snd := TSendMesThread.Create(true);
    snd.tcpSock := Servers[index].Socket;
    snd.Msg.Cmd := 5555;
    snd.Resume;
    Servers[index].Status := ssDel;
    Dec(ServerCount);
    if ServerCount = 0 then SetLength(Servers,0);
  end;
  if index = -1 then
  begin
    for i := 0 to Length(Servers) - 1 do
    begin
      snd := TSendMesThread.Create(true);
      snd.tcpSock := Servers[i].Socket;
      snd.Msg.Cmd := 5555;
      snd.Resume;
      Servers[i].Status := ssDel;
    end;
    SetLength(Servers,0);
    ServerCount := 0;
  end;
end;

function AddServer(Addr: TSockAddr): integer;
var i,lnAddr,ret: integer;
begin
  Result := -1;
  SetLength(Servers,Length(Servers)+1);
  i := Length(Servers) - 1;
  Servers[i].Status := ssNone;

  Servers[i].Socket := socket(AF_INET,SOCK_STREAM,0);
  if Servers[i].Socket = INVALID_SOCKET then
  begin
    DeleteServer(i);
    Exit;
  end;
  Servers[i].Status := ssDisConnect;
  Addr.sin_port := HtoNS(Def_Port+2);
  lnAddr := sizeof(Addr);
  ret := connect(Servers[i].Socket,Addr,lnAddr);
  if ret = 0 then
  begin
    Servers[i].ServerAddr := Addr;
    Servers[i].LastMessage.Cmd := -1;
    Servers[i].LastMessage.Param := '';
    Servers[i].Status := ssConnect;
    inc(ServerCount);
    Result := i;
  end;
end;

procedure SendMessageServer(Mes:TMes;Index: integer);
var ret: integer; snd: TSendMesThread;
begin
  if Servers[Index].Status = ssConnect then
  begin
    snd := TSendMesThread.Create(true);
    snd.Msg := Mes;
    snd.tcpSock := Servers[Index].Socket;
    snd.Resume;
    Servers[Index].LastMessage := Mes;
    if (Mes.Cmd = 1111)or(Mes.Cmd = 1200)or(Mes.Cmd = 1201) then
    begin
      Servers[Index].Status := ssDisConnect;
      CloseSocket(Servers[Index].Socket);
      Servers[Index].Status := ssDel;
    end;
  end;
end;

end.
