unit tcpUnit;
interface
uses Classes, WinSock, Global, ComCtrls, SysUtils;

type
  TtcpClientWait = class(TThread)
  private
    tcpSock: TSocket;
    MyAddr: TSockAddr;
    ClientAddr: TSockAddr;
    Mes: TMesg;
    Cmd: integer;
    StopServer: boolean;
  protected
    procedure Execute; override;
    procedure OnTerminateTcpWait(Sender: TObject);
    procedure OnCommand;
  public
    procedure StopSocket;
  end;

implementation

uses Drives, Files, ServerUnit;

procedure TtcpClientWait.Execute;
var ln,i, fl: integer; retval, len: integer;
    clSock: TSocket; flag: boolean;
    buf : array[0..1023] of byte;
begin
  StopServer := false;
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnTerminateTcpWait;

  MyAddr.sin_family := AF_INET;
  MyAddr.sin_addr.S_addr := INADDR_ANY;
  MyAddr.sin_port := HtoNS(Def_Port);
  tcpSock := socket(AF_INET,SOCK_STREAM,0);
  if tcpSock = INVALID_SOCKET then Exit;
  if bind(tcpSock,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then
  begin
    CloseSocket(tcpSock);
    Exit;
  end;
  if Listen(tcpSock,50) = SOCKET_ERROR then Exit;

  while (not StopServer)and(not Self.Terminated) do
  begin
    ln := sizeof(ClientAddr);
    clSock := Accept(tcpSock,@ClientAddr,@ln);
    while not Self.Terminated  do
    begin
      retval := recv(clSock,Mes,sizeof(Mes),0);
      if retval = 0 then continue;
      // Команды серверу
      if Mes.FNum = 1 then     // отключение клиента и завершение работы сервера
      begin
        Synchronize(OnCommand);
        StopServer := true;
        break;
      end;
      if Mes.FNum = 0 then     // отключение клиента
      begin
        StopServer := false;
        break;
      end;
      // Файловые функции
      if Mes.FNum = 10 then   // отправка информации о дисках
      begin
        FreeDriveList;
        GetDrive;
        ln := DriveCount;
        len := sizeof(ln);
        retval := Send(clSock,ln,len,0); // отправка длинны массива данных
        if retval <= 0 then continue;
        retval := recv(clSock,Mes,sizeof(Mes),0);
        if Mes.FNum <> 11 then continue;
        len := Len_DriveInfo;
        for i := 0 to DriveCount - 1 do
        begin
          retval := Send(clSock,DriveList[i],len,0);    // отправка данных
        end;
      end;

      if Mes.FNum = 20 then // отправка структуры каталога
      begin
        ResetArrayResult;
        faFileType := faAnyFile - faVolumeID - faSysFile - faHidden;
        FindFile(Mes.Param,'*.*');
        ln := FileCount;
        len := sizeof(ln);
        retval := Send(clSock,ln,len,0); // отправка длинны массива данных
        if retval <= 0 then continue;
        retval := recv(clSock,Mes,sizeof(Mes),0); // ответ
        if Mes.FNum <> 21 then continue;
        for i := 0 to FileCount - 1 do
        begin
          len := sizeof(ArrayResult[i]);
          retval := Send(clSock,ArrayResult[i],len,0);    // отправка данных
        end;
      end;

      if Mes.FNum = 5 then  // удаление файла
      begin
        flag := DeleteFile(Mes.Param);
        if flag then ln := 1
        else ln := 0;
        len := sizeof(ln);
        retval := Send(clSock,ln,len,0); // отправка данных
      end;

      if Mes.FNum = 6 then // удаление папки
      begin
        ln := DelFolder(0,Mes.Param);
        len := sizeof(ln);
        retval := Send(clSock,ln,len,0); // отправка данных
      end;

      if Mes.FNum = 30 then     // передача файла
      begin
        fl := FileOpen(Mes.Param,fmOpenRead);
        ln := 1;
        ln := FileRead(fl,buf,1024);
        while ln > 0 do
        begin
          retval :=  Send(clSock,buf,ln,0);
          if retval <= 0 then break;
          ln := FileRead(fl,buf,1024);
        end;
        FileClose(fl);
      end;

    end;
  end;
end;

procedure TtcpClientWait.OnCommand;
begin
 Self.Terminate;  
 ServerUnit.ServerForm.Close;
end;

procedure TtcpClientWait.OnTerminateTcpWait(Sender: TObject);
begin
  ShutDown(tcpSock,0);
  CloseSocket(tcpSock);
end;

procedure TtcpClientWait.StopSocket;
begin
  OnTerminateTcpWait(nil);
end;

end.
