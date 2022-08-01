program BrdDemo;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {frmBoardDemo},
  BoardControl in 'BoardControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBoardDemo, frmBoardDemo);
  Application.Run;
end.
