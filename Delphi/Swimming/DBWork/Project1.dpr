program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ADODBWork in 'ADODBWork.pas',
  SwimmingDB in 'SwimmingDB.pas',
  SQLUnit in '..\Swimming\SQLUnit.pas',
  NodeUnit in '..\Swimming\NodeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
