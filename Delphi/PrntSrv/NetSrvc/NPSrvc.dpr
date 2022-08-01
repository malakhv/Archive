program NPSrvc;

uses
  SvcMgr,
  NtPrntSrvcUnit in 'NtPrntSrvcUnit.pas' {NetService: TService},
  TCPThread in 'TCPThread.pas',
  NetGlobal in '..\NetGlobal.pas',
  GlPrSrv in '..\PrinterSrvr\GlPrSrv.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TNetService, NetService);
  Application.Run;
end.
