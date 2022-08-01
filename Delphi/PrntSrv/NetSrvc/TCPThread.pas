unit TCPThread;

interface

uses SysUtils, Classes, WinSock, NetGlobal;

type
  TTCPServer = class(TThread)
  private
    FSocket: TSocket;
    MyAddr: TSockAddr;
    ClientAddr: TSockAddr;
    FMsg: TServerMsg;
  public
    FormParent: THandle;
    procedure Execute; override;
    procedure OnTerminateTCPServer(Sender: TObject);
    procedure OnCommand;
  end;

implementation

uses Windows, GlPrSrv;

{ TTCPServer }

procedure TTCPServer.Execute;
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
      if FMsg.Cmd <> 11 then continue;
      for i := 0 to count - 1 do
      begin
        pinf := ThreadList.GetInfo(i);
        pninf.ID := pinf.ID;
        pninf.PName := pinf.PName;
        len := sizeof(pninf);
        ret := Send(ClientSocket,pninf,len,0);    // отправка данных
      end;
    end;           

    if FMsg.Cmd = 20 then
    begin
      FindFirst('..\' +LimitDBName,faAnyFile,F);
      if F.Name = '' then Continue;
      len := sizeof(F.Size);
      ret := Send(ClientSocket,F.Size,len,0);
      if ret <= 0 then Continue;
      fl := FileOpen('..\' +LimitDBName,fmOpenRead or fmShareDenyNone);
      len := FileRead(fl,buf,1024);
      while len > 0 do
      begin
        ret :=  Send(ClientSocket,buf,len,0);
        if ret <= 0 then break;
        len := FileRead(fl,buf,1024);
      end;
      FileClose(fl);
    end;
  end;
end;

procedure TTCPServer.OnCommand;
begin

end;

procedure TTCPServer.OnTerminateTCPServer(Sender: TObject);
begin
  ShutDown(FSocket,0);
  CloseSocket(FSocket);
end;

end.
