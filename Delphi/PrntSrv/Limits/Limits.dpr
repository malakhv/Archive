program Limits;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Global in '..\Global.pas',
  netapi32 in '..\netapi32.pas',
  GlLimits in 'GlLimits.pas',
  EditTime in 'EditTime.pas' {TimeForm},
  AddUser in 'AddUser.pas' {AddUserForm},
  AddLimit in 'AddLimit.pas' {AddLimitForm},
  AboutUnit in 'AboutUnit.pas' {AboutBox},
  InfoUnit in 'InfoUnit.pas' {InfoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TTimeForm, TimeForm);
  Application.CreateForm(TAddUserForm, AddUserForm);
  Application.CreateForm(TAddLimitForm, AddLimitForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.Run;
end.
