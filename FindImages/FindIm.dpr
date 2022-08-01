program FindIm;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Files in 'Res\Files.pas',
  DirUnit in 'Res\DirUnit.pas' {DirForm},
  ViewUnit in 'ViewUnit.pas' {ViewForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDirForm, DirForm);
  Application.CreateForm(TViewForm, ViewForm);
  Application.Run;
end.
