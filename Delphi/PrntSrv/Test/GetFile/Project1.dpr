program Project1;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  NetGlobal in 'NetGlobal.pas',
  RegUnit in 'RegUnit.pas',
  TCPThread in 'TCPThread.pas',
  Global in 'Global.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
