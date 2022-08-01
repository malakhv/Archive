unit udpClientWaitUnit;
interface
uses Classes, WinSock, Global, ComCtrls, SysUtils;

type
  TudpClienWait = class(TThread)
  private
    udpSock: TSocket;
    MyAddr: TSockAddr;
    ClientAddr: TSockAddr;

    LogStr: string;
    Napr  : string;
  protected
    procedure Execute; override;
    procedure AddLogInfo;
    procedure OnUDPTerminate(Sender: TObject);
  end;

implementation

uses ServerUnitUnit;

procedure TudpClienWait.Execute;
var retval:integer; dt,ln:integer;
begin
 Self.FreeOnTerminate := true;
 Self.OnTerminate := OnUDPTerminate;
 LogStr := '';
 MyAddr.sin_family := AF_INET;
 MyAddr.sin_addr.S_addr := INADDR_ANY;
 MyAddr.sin_port := HtoNS(Def_Port);
 udpSock := socket(AF_INET,SOCK_DGRAM,0);
 if udpSock = INVALID_SOCKET then Exit;
 if bind(udpSock,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then
 begin
   CloseSocket(udpSock);
   Exit;
 end;
 ln := sizeof(ClientAddr);

while not Self.Terminated do
begin
 retval := RecvFrom(udpSock,dt,sizeof(dt),0,ClientAddr,ln);
 if retval >0 then
 begin
   if dt = 1001 then
   begin
     Napr := 'I';
     LogStr := 'Запрос на соединение';
     Synchronize(AddLogInfo);
     dt := 2002;
     retval := SendTo(udpSock,dt,sizeof(dt),0,ClientAddr,sizeof(ClientAddr));
     if retval >0 then
     begin
       Napr := 'O';
       LogStr := 'Подтверждение соединения';
       Synchronize(AddLogInfo);
     end;
   end;
 end;
end;
end;

procedure TudpClienWait.AddLogInfo;
var itm: TListItem;
begin
  itm := ServerForm.LogList.Items.Add;
  itm.Caption := DateTimeToStr(Now);
  itm.SubItems.Add(Napr);
  itm.SubItems.Add(GetAddrString(ClientAddr));
  itm.SubItems.Add('UDP');
  itm.SubItems.Add(LogStr);
end;

procedure TudpClienWait.OnUDPTerminate(Sender: TObject);
begin
  CloseSocket(udpSock);
end;

end.
