program RAdmin;

uses
  Forms,
  RAdminUnit in 'RAdminUnit.pas' {RAdminForm},
  Global in '..\Global.pas',
  netapi32 in '..\netapi32.pas',
  GlRAdmin in 'GlRAdmin.pas',
  TPrntClient in 'TPrntClient.pas',
  NetGlobal in '..\NetGlobal.pas',
  AddCompUnit in 'AddCompUnit.pas' {AddCompForm},
  GetComp in 'GetComp.pas',
  InfoUnit in 'InfoUnit.pas' {InfoForm},
  ProgressUnit in '..\Report\ProgressUnit.pas' {ProgressForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRAdminForm, RAdminForm);
  Application.CreateForm(TAddCompForm, AddCompForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.Run;
end.
