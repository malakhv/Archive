program FileGet;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Files in '..\Files.pas',
  Global in 'Global.pas',
  Drives in '..\Drives.pas',
  TServerUnit in 'TServerUnit.pas',
  GetDirUnit in '..\GetDirUnit.pas' {DirForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDirForm, DirForm);
  Application.Run;
end.
