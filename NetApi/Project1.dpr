program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  netapi32 in 'netapi32.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
