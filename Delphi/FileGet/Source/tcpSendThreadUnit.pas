unit tcpSendThreadUnit;
interface
uses Classes, WinSock, Global, ComCtrls, SysUtils;

type
  TSendMesThread = class(TThread)
  private
    tcpSock: TSocket;
    MyAddr: TSockAddr;

  protected
    procedure Execute; override;
    procedure OnSendTerminate(Sender: TObject);

  public
    ServerAddr: TSockAddr;
    Msg: TMes;
  end;

implementation

procedure TSendMesThread.Execute;
var ln: integer; retval: integer;
begin
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnSendTerminate;

  MyAddr.sin_family := AF_INET;
  MyAddr.sin_addr.S_addr := INADDR_ANY;
  MyAddr.sin_port := HtoNS(Def_Port+1);
  tcpSock := socket(AF_INET,SOCK_STREAM,0);
  if tcpSock = INVALID_SOCKET then Exit;

  if bind(tcpSock,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then Exit;

  ln := sizeof(ServerAddr);
  ServerAddr.sin_port := HtoNS(Def_Port+2);

  retval := connect(tcpSock,ServerAddr,ln);
  if retval = 0 then
  begin
    retval := send(tcpSock,Msg,sizeof(Msg),0);
    if retval > 0 then
    begin
      retval := 1;
    end;                 
  end;
end;

procedure TSendMesThread.OnSendTerminate(Sender: TObject);
begin
  ShutDown(tcpSock,0);
  CloseSocket(tcpSock);
end;

end.
