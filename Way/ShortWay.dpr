program ShortWay;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  GlobalUnit in 'GlobalUnit.pas',
  Node in '..\Component\TNode\Node.pas',
  NodePanel in '..\Component\TNode\NodePanel.pas',
  InfoWayUnit in 'InfoWayUnit.pas' {WayForm},
  AboutUnit in 'AboutUnit.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TWayForm, WayForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
