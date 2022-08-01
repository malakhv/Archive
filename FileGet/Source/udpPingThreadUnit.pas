unit udpPingThreadUnit;
interface
uses Classes, WinSock, Global, ComCtrls, Windows, SysUtils;

type
  TudpPing = class(TThread)
  private
    udpSock: TSocket;
    MyAddr: TSockAddr;
    ServerAddr: TSockAddr;
    ServerIP: string;
    ServerIPEnabled: boolean;
    Index: integer;
  protected
    procedure Execute; override;
    procedure CreateConnect;
    procedure UpdateServerList;
    procedure OnUDPPingTerminate(Sender: TObject);
  public
    procedure SetServerIP(IP: string);

  end;

implementation

uses ClientUnit, TServerArrayUnit;

procedure TudpPing.Execute;
var retval: integer; dt,ln: integer;
    addr:TSockAddrIn; SockOpt: BOOL;

    StartPing  : integer;
    PingTime   : integer;
    CurrentTime: integer;
begin
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnUDPPingTerminate;

  if ServerIPEnabled then
  begin
    MyAddr.sin_family := AF_INET;
    MyAddr.sin_addr.S_addr := INADDR_ANY;
    MyAddr.sin_port := HtoNS(Def_Port-1);

    udpSock := socket(PF_INET,SOCK_DGRAM,0);
    if udpSock = INVALID_SOCKET then Exit;

    if bind(udpSock,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then
    begin
      CloseSocket(udpSock);
      Exit;
    end;

    addr.sin_family := AF_INET;
    addr.sin_port := HtoNS(Def_Port);

    addr.sin_addr.S_addr := Inet_addr(PAnsiChar(ServerIP));
  end  else
  begin
    udpSock := socket(PF_INET,SOCK_DGRAM,IPPROTO_UDP);
    if udpSock = INVALID_SOCKET then Exit;
    SockOpt := true;
    SetSockOpt(udpSock,SOL_SOCKET,SO_BROADCAST, PChar(@SockOpt),SizeOf(SockOpt));
    addr.sin_port:=htons(Def_Port); //номер порта
    addr.sin_addr.S_addr:=INADDR_BROADCAST;
    addr.sa_family:=AF_INET;
  end;

  dt := 1001;

  retval := SendTo(udpSock,dt,sizeof(dt),0,addr,sizeof(addr));

  StartPing   := GetTickCount;
  CurrentTime := GetTickCount;

  PingTime := 5*60*1000; // ожидание серверов 5 минут

  while (CurrentTime - StartPing)< PingTime do
  begin
    if retval <= 0 then Exit;
    ln := sizeof(ServerAddr);
    retval := RecvFrom(udpSock,dt,sizeof(dt),0,ServerAddr,ln);
    if retval <= 0 then Exit;
    Synchronize(CreateConnect);
    Synchronize(UpdateServerList);

    CurrentTime := GetTickCount;
  end;
end;

procedure TudpPing.UpdateServerList;
var itm: TListItem;
begin
  if Index = -1 then Exit;
  itm := ClientForm.ServerList.Items.Add;
  itm.Caption := GetAddrString(ServerAddr);
  itm.Caption := itm.Caption +'   '+ GetNameByAddress(ServerAddr);
  itm.Data := Pointer(Index);
end;

procedure TudpPing.CreateConnect;
begin
 Index := AddServer(ServerAddr);
end;

procedure TudpPing.OnUDPPingTerminate(Sender: TObject);
begin
  CloseSocket(udpSock);
end;

procedure TudpPing.SetServerIP(IP: string);
begin
  if IP = '' then Exit;
  ServerIP := IP;
  ServerIPEnabled := true;
end;



end.
