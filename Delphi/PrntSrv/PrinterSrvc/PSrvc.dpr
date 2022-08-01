program PSrvc;

uses
  SvcMgr,
  SrvcUnit in 'SrvcUnit.pas' {MyService: TService},
  GlPrSrv in '..\PrinterSrvr\GlPrSrv.pas',
  MainUnit in '..\PrinterSrvr\MainUnit.pas' {MainForm},
  MsgPrSrv in '..\PrinterSrvr\MsgPrSrv.pas',
  PrntNtfcThr in '..\PrinterSrvr\PrntNtfcThr.pas',
  ThrClct in '..\PrinterSrvr\ThrClct.pas',
  Global in '..\Global.pas',
  MNameUnit in '..\MNameUnit.pas',
  netapi32 in '..\netapi32.pas',
  TCPThread in '..\TCPThread.pas',
  NetGlobal in '..\NetGlobal.pas',
  RegUnit in '..\RegUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMyService, MyService);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
