program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MyClasses in '..\MyUnits\MyClasses.pas',
  TMtrx in 'TMtrx.pas',
  TestMatrix in 'TestMatrix.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
