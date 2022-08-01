program PrntrStp;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CheckedScrollBox in 'CheckedScrollBox.pas',
  Global in '..\Global.pas',
  AddPrinter in 'AddPrinter.pas' {AddPrinterForm},
  MNameUnit in '..\MNameUnit.pas',
  netapi32 in '..\netapi32.pas',
  AboutUnit in 'AboutUnit.pas' {AboutBox},
  InfoUnit in 'InfoUnit.pas' {InfoForm},
  PInfUnit in 'PInfUnit.pas' {PInfoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddPrinterForm, AddPrinterForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TPInfoForm, PInfoForm);
  Application.Run;
end.
