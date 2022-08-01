program Fractal;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  OptionsUnit in 'OptionsUnit.pas' {OptionsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.Run;
end.
