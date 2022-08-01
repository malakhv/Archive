unit TCPThread;

interface

uses SysUtils, Classes, WinSock, NetGlobal;

type
  TTCPSrvr = class(TThread)
  private
    FSocket: TSocket;
    MyAddr: TSockAddr;
    ClientAddr: TSockAddr;
    FMsg: TServerMsg;
    FFormParent: THandle;
  public
    procedure Execute; override;
    procedure OnTerminateTCPServer(Sender: TObject);
    procedure OnCommand;
    constructor Create(AFormParent: THandle);
  end;

implementation

uses Windows, GlPrSrv, Global, RegUnit, MainUnit, MsgPrSrv;

var
  Reg: TMyReg;

{ TTCPServer }


constructor TTCPSrvr.Create(AFormParent: THandle);
begin
  inherited Create(true);
  Self.Priority := tpLowest;
  Self.FFormParent := AFormParent;
  Self.Resume;
end;

procedure TTCPSrvr.Execute;
var len, ret, count, i, fl : integer;
    ClientSocket: TSocket;
    pninf: TNetPrinterInfo;
    pinf: TPrinterInfo;
    buf : array[0..1023] of byte;
    F: TSearchRec;
begin
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnTerminateTCPServer;

  MyAddr.sin_family := AF_INET;
  MyAddr.sin_addr.S_addr := INADDR_ANY;
  MyAddr.sin_port := HtoNS(Def_Port);
  FSocket := socket(AF_INET,SOCK_STREAM,0);
  if FSocket = INVALID_SOCKET then Exit;
  if bind(FSocket,MyAddr,sizeof(MyAddr)) = SOCKET_ERROR then
  begin
    CloseSocket(FSocket);    
    Exit;
  end;
  if Listen(FSocket,50) = SOCKET_ERROR then Exit;

  while not Self.Terminated do
  begin
    len := sizeof(ClientAddr);
    ClientSocket := Accept(FSocket,@ClientAddr,@len);
    ret := recv(ClientSocket,FMsg,sizeof(FMsg),0);
    if ret = 0 then  Continue;

    // Команды серверу
    if FMsg.Cmd = 10 then
    begin
      count := ThreadList.Count;
      len := sizeof(count);
      ret := Send(ClientSocket,count,len,0); // отправка длинны массива данных
      if ret <= 0 then Continue;
      len := sizeof(FMsg);
      ret := recv(ClientSocket,FMsg,len,0);
      if ret <= 0 then continue;
      if FMsg.Cmd <> 11 then continue;
      for i := 0 to count - 1 do
      begin
        pinf := ThreadList.GetInfo(i);
        pninf.ID := pinf.ID;
        pninf.PName := pinf.PName;
        len := sizeof(pninf);
        Send(ClientSocket,pninf,len,0);    // отправка данных
      end;
    end;           

    // Передача файла базы данных
    if FMsg.Cmd = 20 then
    begin
      // Узнае размер файла
      FindFirst(Reg.DBFileName,faAnyFile,F);
      if F.Name = '' then Continue;
      len := sizeof(F.Size);
      // Отправляем размер файла клиенту
      ret := Send(ClientSocket,F.Size,len,0);
      if ret <= 0 then Continue;
      // Открываем файл для чтения
      fl := FileOpen(Reg.DBFileName,fmOpenRead or fmShareDenyNone);
      // Читаем по 1 килобайту 
      len := FileRead(fl,buf,1024);
      while len > 0 do
      begin
        ret :=  Send(ClientSocket,buf,len,0);
        if ret <= 0 then break;
        len := FileRead(fl,buf,1024);
      end;
      FileClose(fl);
    end;

    // Очистка БД
    if FMsg.Cmd = 50 then
    begin
      PostMessage(FFormParent,DM_DBCLEAR,0,0);
    end;

  end;
end;

procedure TTCPSrvr.OnCommand;
begin

end;

procedure TTCPSrvr.OnTerminateTCPServer(Sender: TObject);
begin
  ShutDown(FSocket,0);
  CloseSocket(FSocket);
end;

initialization
begin
  Reg := TMyReg.Create(rmRead);
end;

finalization
begin
  Reg.Free;
end;

end.
