program FileServer;

uses
  Forms,
  ServerUnit in 'ServerUnit.pas' {ServerForm},
  Drives in '..\Drives.pas',
  Files in '..\Files.pas',
  Global in '..\Client\Global.pas',
  tcpUnit in 'tcpUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
