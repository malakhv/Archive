program ExlImprt;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  TimeWrk in '..\TimeWrk.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
