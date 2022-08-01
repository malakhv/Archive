program SQLExp;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  TypeAndConstUnit in 'TypeAndConstUnit.pas',
  myClipboard in 'myClipboard.pas',
  NodeAndItemWork in 'NodeAndItemWork.pas',
  ConnectUnit in 'ConnectUnit.pas' {ConnectForm},
  AboutUnit in 'AboutUnit.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SQL Explorer';
  Application.HelpFile := 'C:\Program Files\Borland\Delphi7\Projects\Institute\SQLExplorer\Help\Help.doc';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConnectForm, ConnectForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
