program TrSnd;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ColorUnit in 'ColorUnit.pas',
  DlgUnit in 'DlgUnit.pas' {DlgForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDlgForm, DlgForm);
  Application.Run;
end.
