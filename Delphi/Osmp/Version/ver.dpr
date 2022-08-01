program ver;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  VerUnit in 'VerUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
