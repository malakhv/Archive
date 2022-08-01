unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnCtrls, Menus, ActnPopup, ToolWin, ActnMan, ActnMenus,
  XPStyleActnCtrls, ActnList, ExtCtrls, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    ActionManager: TActionManager;
    MainMenuBar: TActionMainMenuBar;
    PopupActionBar: TPopupActionBar;
    MainToolBar: TActionToolBar;
    StatusBar: TStatusBar;
    TreeView1: TTreeView;
    Msg: TMemo;
    Splitter: TSplitter;
    Open: TAction;
    Save: TAction;
    SaveAs: TAction;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses Global;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  NetSend('Misha','Привет)))','');
end;

initialization
begin
  AppDir := ExtractFilePath(Application.ExeName);
end;

end.
