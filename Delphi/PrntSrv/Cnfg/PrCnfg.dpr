program PrCnfg;

uses
  Forms,
  CnfgUnit in 'CnfgUnit.pas' {CnfgForm},
  GlCnfg in 'GlCnfg.pas',
  WaitOpt in 'WaitOpt.pas' {WOptForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCnfgForm, CnfgForm);
  Application.CreateForm(TWOptForm, WOptForm);
  Application.Run;
end.
