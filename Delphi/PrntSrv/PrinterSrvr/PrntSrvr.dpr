program PrntSrvr;



uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ThrClct in 'ThrClct.pas',
  PrntNtfcThr in 'PrntNtfcThr.pas',
  netapi32 in '..\netapi32.pas',
  Global in '..\Global.pas',
  GlPrSrv in 'GlPrSrv.pas',
  MsgPrSrv in 'MsgPrSrv.pas',
  MNameUnit in '..\MNameUnit.pas',
  RegUnit in '..\RegUnit.pas',
  NetGlobal in '..\NetGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
