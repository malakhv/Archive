program Cripto;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  GetKeyUnit in 'GetKeyUnit.pas' {GetKeyForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TGetKeyForm, GetKeyForm);
  Application.Run;
end.
