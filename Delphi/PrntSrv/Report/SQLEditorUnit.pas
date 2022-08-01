unit SQLEditorUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Menus, ImgList, Clipbrd, ToolWin, CheckLst,
  ExtCtrls, ActnList, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TSQLEditorForm = class(TForm)
    StatusBar: TStatusBar;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SQLEditor: TMemo;
    ToolBar1: TToolBar;
    btnNew: TToolButton;
    btnOpen: TToolButton;
    btnSave: TToolButton;
    ToolButton1: TToolButton;
    btnUndo: TToolButton;
    btnCut: TToolButton;
    btnCopy: TToolButton;
    btnPaste: TToolButton;
    ToolButton6: TToolButton;
    btnSQLOp: TToolButton;
    btnSQLEx: TToolButton;
    btnDel: TToolButton;
    Image: TImageList;
    ImageH: TImageList;
    ImageD: TImageList;
    ListBox: TListBox;
    ShowListTimer: TTimer;
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    actNew: TAction;
    actOpen: TAction;
    actSave: TAction;
    actSaveAsFilter: TAction;
    actClose: TAction;
    actUndo: TAction;
    actCut: TAction;
    actCopy: TAction;
    actPaste: TAction;
    actDelete: TAction;
    actSelAll: TAction;
    actWrap: TAction;
    actInsTableName: TAction;
    actInsID: TAction;
    actInsUName: TAction;
    actInsMachine: TAction;
    actInsPName: TAction;
    actInsDoc: TAction;
    actInsPage: TAction;
    actInsDate: TAction;
    actSQLView: TAction;
    actSQLExecute: TAction;
    actCodeCmp: TAction;
    procedure ToolButton1Click(Sender: TObject);
    procedure SQLEditorChange(Sender: TObject);
    procedure mnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SQLEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SQLEditorKeyPress(Sender: TObject; var Key: Char);
    procedure SQLEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowListTimerTimer(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveAsFilterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actWrapExecute(Sender: TObject);
    procedure actInsTableNameExecute(Sender: TObject);
    procedure actSQLViewExecute(Sender: TObject);
    procedure actSQLExecuteExecute(Sender: TObject);
    procedure actSelAllExecute(Sender: TObject);
    procedure actInsColumnName(Sender: TObject);
    procedure actCodeCmpExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure ToChange(AChange: boolean);
    procedure InsStrToCurPos(AStr: string);
    procedure ShowList(AShow: boolean);
    //procedure LoadCodeComplateList;
  public
    { Public declarations }
  end;

type
  TOp = 0..1;

var
  SQLEditorForm: TSQLEditorForm;
  OpCode: TOp;

implementation

uses CodeCmplEditUnit, NRepUnit, MainUnit, GlRprt;

{$R *.dfm}

const
  InsArray: array[0..7] of string = ('ID','UName','Machine','PName','Document',
   'PageCount', 'Date', 'Report');
  ShbArray: array[0..2] of string = ('Select * from Report', 'where',
    'Delete * from Report');

type
  TCharSet = set of Char;

var
  Change: boolean = false;
  ListShow: boolean = false;
  LastStr: string = '';
  PretStr: string = '';
  CharSet: TCharSet = ['A'..'z','À'..'ÿ','.'];
  AllStrings, ColStrings: TStringList;

procedure LoadStrLists;
begin
  AllStrings.Clear;
  ColStrings.Clear;
  if FileExists(AppDir + 'CdCmpl.lst') then
    AllStrings.LoadFromFile(AppDir + 'CdCmpl.lst')
  else AllStrings.AddStrings(SQLEditorForm.ListBox.Items);
  ColStrings.Add('ID');
  ColStrings.Add('UName');
  ColStrings.Add('Machine');
  ColStrings.Add('PName');
  ColStrings.Add('Document');
  ColStrings.Add('PageCount');
end;

procedure TSQLEditorForm.InsStrToCurPos(AStr: string);
var LineNum,CharNum: LongInt;
    CurStr: string;
begin
 LineNum := SQLEditor.Perform(EM_LINEFROMCHAR,SQLEditor.SelStart,0);
 CharNum := SQLEditor.Perform(EM_LINEINDEX,LineNum,0);
 CharNum := (SQLEditor.SelStart-CharNum) + 1;
 CurStr := SQLEditor.Lines.Strings[LineNum];
 Insert(AStr,CurStr,CharNum);
 SQLEditor.Lines.Strings[LineNum] := CurStr;
 LastStr := AStr; 
end;

procedure TSQLEditorForm.ToolButton1Click(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TSQLEditorForm.SQLEditorChange(Sender: TObject);
begin
  ToChange(true);
  mnEditClick(nil);
end;

procedure TSQLEditorForm.ToChange(AChange: boolean);
begin
  Change := AChange;
end;

procedure TSQLEditorForm.mnEditClick(Sender: TObject);
begin
  actCopy.Enabled := SQLEditor.SelText <> '';
  actCut.Enabled  := SQLEditor.SelText <> '';
  actDelete.Enabled  := SQLEditor.SelText <> '';
  btnCopy.Enabled := actCopy.Enabled;
  btnCut.Enabled  := actCut.Enabled;
  btnDel.Enabled  := actDelete.Enabled;
end;

procedure TSQLEditorForm.FormCreate(Sender: TObject);
begin
  AllStrings := TStringList.Create;
  ColStrings := TStringList.Create;
  LoadStrLists;
  ListBox.Parent := SQLEditor;
  mnEditClick(nil);
  OpCode := 0;
end;

procedure TSQLEditorForm.SQLEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowListTimer.Enabled := false;
  if ((key = Ord(' ')) and (Shift = [ssCtrl])) or (key = 190) then
  begin
    if Key = 190 then ShowListTimer.Enabled := true;
    if key = Ord(' ') then ShowList(true);
    key := 0;
  end else
    if ListBox.Visible then ShowList(false);

  if key = 8 then
  begin
    if LastStr = '' then begin LastStr := PretStr; PretStr := ''; end
    else Delete(LastStr,Length(LastStr),1);
  end;
end;

procedure TSQLEditorForm.ListBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if ListBox.ItemIndex <> -1 then
    begin
      InsStrToCurPos(ListBox.Items.Strings[ListBox.ItemIndex]);
    end;
    ShowList(false);
  end;

  if key = 8 then
  begin
    ShowList(false);
  end;
end;

procedure TSQLEditorForm.SQLEditorKeyPress(Sender: TObject; var Key: Char);
begin
  if ListShow then
  begin
    Key := Char(0);
    ListShow := false;
  end;
  if Key = Char(8) then Exit;
  if (Key in CharSet)then
  begin
    LastStr := LastStr + Key;
  end else
  begin
    PretStr := LastStr;
    LastStr := '';
  end;
end;

procedure TSQLEditorForm.SQLEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ListBox.Visible then ListBox.Visible := false;
end;

procedure TSQLEditorForm.ShowList(AShow: boolean);
var l,t: integer;
begin
  if AShow then
  begin
    ListShow := true;
    l := SQLEditor.CaretPos.X * 8;
    t := SQLEditor.CaretPos.Y * 16 + 15;
    if l + ListBox.Width  > SQLEditor.Width  then l := l - ListBox.Width;
    if t + ListBox.Height > SQLEditor.Height then t := t - ListBox.Height - 15;
    ListBox.Left := l;
    ListBox.Top  := t;
    ListBox.Items.Clear;
    if LastStr <> 'Report.' then ListBox.Items.AddStrings(AllStrings)
    else ListBox.Items.AddStrings(ColStrings);
    ListBox.Visible := true;
    ListBox.SetFocus;
  end else
  begin
    ListBox.Visible := false;
    ListBox.ItemIndex := -1;
    SQLEditor.SetFocus;
  end;
  SQLEditor.Repaint;
end;

procedure TSQLEditorForm.ShowListTimerTimer(Sender: TObject);
begin
  ShowList(true);
  ShowListTimer.Enabled := false;
end;

procedure TSQLEditorForm.actNewExecute(Sender: TObject);
begin
  SQLEditor.Clear;
end;

procedure TSQLEditorForm.actOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    SQLEditor.Lines.LoadFromFile(OpenDialog.FileName);
    ToChange(false);
  end;
end;

procedure TSQLEditorForm.actSaveExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    SQLEditor.Lines.SaveToFile(OpenDialog.FileName);
    ToChange(false);
  end;
end;

procedure TSQLEditorForm.actSaveAsFilterExecute(Sender: TObject);
begin
  if NRepForm.ShowModal = mrOk then
  begin
  MainForm.AddFilterToTreeView(NRepForm.FNameEdit.Text,
      MainForm.AddFilterToDB(NRepForm.FNameEdit.Text,SQLEditor.Text));
  end;
end;

procedure TSQLEditorForm.actCloseExecute(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TSQLEditorForm.actUndoExecute(Sender: TObject);
begin
  SQLEditor.Undo;
end;

procedure TSQLEditorForm.actCutExecute(Sender: TObject);
begin
  Clipboard.AsText := SQLEditor.SelText;
  SQLEditor.SelText := '';
end;

procedure TSQLEditorForm.actCopyExecute(Sender: TObject);
begin
  Clipboard.AsText := SQLEditor.SelText;
end;

procedure TSQLEditorForm.actPasteExecute(Sender: TObject);
begin
  if SQLEditor.SelText <> '' then SQLEditor.SelText := Clipboard.AsText
  else InsStrToCurPos(Clipboard.AsText);
end;

procedure TSQLEditorForm.actDeleteExecute(Sender: TObject);
begin
  SQLEditor.SelText := '';
end;

procedure TSQLEditorForm.actWrapExecute(Sender: TObject);
begin
  SQLEditor.WordWrap := actWrap.Checked;
  if SQLEditor.WordWrap then
    SQLEditor.ScrollBars := ssVertical
  else
    SQLEditor.ScrollBars := ssBoth;
end;

procedure TSQLEditorForm.actInsTableNameExecute(Sender: TObject);
begin
  InsStrToCurPos('Report');
end;

procedure TSQLEditorForm.actSQLViewExecute(Sender: TObject);
begin
  OpCode := 0;
  Self.ModalResult := mrOk;
end;

procedure TSQLEditorForm.actSQLExecuteExecute(Sender: TObject);
begin
  OpCode := 1;
  Self.ModalResult := mrOk;
end;

procedure TSQLEditorForm.actSelAllExecute(Sender: TObject);
begin
  SQLEditor.SelectAll;
end;

procedure TSQLEditorForm.actInsColumnName(Sender: TObject);
begin
  InsStrToCurPos(InsArray[(Sender as TAction).Tag]);
end;

procedure TSQLEditorForm.actCodeCmpExecute(Sender: TObject);
begin
  CdCmplForm.CodeComplList.Lines.LoadFromFile('CdCmpl.lst');
  if CdCmplForm.ShowModal = mrOk then
  begin
    LoadStrLists;
  end;  
end;

procedure TSQLEditorForm.FormDestroy(Sender: TObject);
begin
  AllStrings.Free;
  ColStrings.Free;
end;

end.
