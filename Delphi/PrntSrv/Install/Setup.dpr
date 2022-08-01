program Setup;

uses
  Forms,
  StpUnit in 'StpUnit.pas' {StpForm},
  RegUnit in '..\RegUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TStpForm, StpForm);
  Application.Run;
end.
