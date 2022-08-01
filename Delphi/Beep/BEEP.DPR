program Beep;

uses
  Forms,
  UBeep in 'UBeep.pas' {FormIOPortDemo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormIOPortDemo, FormIOPortDemo);
  Application.Run;
end.
