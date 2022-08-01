program Send;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ProgresUnit in 'ProgresUnit.pas' {ProgresForm},
  OtchotUnit in 'OtchotUnit.pas' {OtchotForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TProgresForm, ProgresForm);
  Application.CreateForm(TOtchotForm, OtchotForm);
  Application.Run;
end.
