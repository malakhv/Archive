program Tanks;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StenaUnit in 'StenaUnit.pas',
  TanksUnit in 'TanksUnit.pas',
  TypeConstUnit in 'TypeConstUnit.pas',
  LevelUnit in 'LevelUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
