program osmpscn;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  OSMPLog in 'OSMPLog.pas',
  OSMPUpdt in 'OSMPUpdt.pas',
  ProgOptions in 'ProgOptions.pas',
  OSMPInt in 'OSMPInt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
