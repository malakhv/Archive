unit SrvcUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TMyService = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  MyService: TMyService;

implementation

uses MainUnit, MsgPrSrv, TCPThread;

{$R *.DFM}

var
  TCPServer: TTCPSrvr;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MyService.Controller(CtrlCode);
end;

function TMyService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMyService.ServiceExecute(Sender: TService);
begin
  TCPServer := TTCPSrvr.Create(MainForm.Handle);
  while not Terminated do
  begin
    Self.ServiceThread.ProcessRequests(false);
    sleep(1000);
  end;
end;

procedure TMyService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  SendMessage(MainForm.Handle,PM_STOPWAITPRNT,0,0);
  TCPServer.Terminate;
  Stopped := true;
end;

procedure TMyService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  //SendMessage(MainForm.Handle,PM_STRTWAITPRNT,0,0);
  Started := true;
end;

end.
