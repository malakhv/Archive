program CreateLevel;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  LevelUnit in '..\LevelUnit.pas',
  TypeConstUnit in '..\TypeConstUnit.pas',
  SetTankUnit in 'SetTankUnit.pas' {STForm},
  ImTnUnit in 'ImTnUnit.pas' {ImTnForm},
  SetShtabUnit in 'SetShtabUnit.pas' {SetShtabForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSTForm, STForm);
  Application.CreateForm(TImTnForm, ImTnForm);
  Application.CreateForm(TSetShtabForm, SetShtabForm);
  Application.Run;
end.
