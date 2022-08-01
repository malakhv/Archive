program Sound;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  WAVUnit in 'WAVUnit.pas',
  realfft in 'realfft.pas',
  Ap in 'Ap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
