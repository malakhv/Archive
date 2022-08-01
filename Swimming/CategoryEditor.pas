unit CategoryEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ActnCtrls, ToolWin, ActnMan, ActnMenus, XPStyleActnCtrls, ActnList, DB, ADODB,
  Grids, DBGrids;

type
  TfrmCategory = class(TForm)
    StatusBar1: TStatusBar;
    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCategory: TfrmCategory;

implementation

{$R *.dfm}

end.
