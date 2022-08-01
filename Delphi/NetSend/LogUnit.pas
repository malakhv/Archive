unit LogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ActnPopup, ActnCtrls, ToolWin, ActnMan, ActnMenus, XPStyleActnCtrls,
  ActnList;

type
  TLogForm = class(TForm)
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    StatusBar1: TStatusBar;
    LogList: TListView;
    actClose: TAction;
    actClear: TAction;
    procedure LogListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure actCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

procedure TLogForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TLogForm.LogListCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if Item.Index mod 2 = 0 then
      Sender.Canvas.Brush.Color := clCream;
end;

end.
