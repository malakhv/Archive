unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, ImgList, Grids, DBGrids, DB, ADODB,
  OleServer, ExcelXP, StdCtrls, Buttons, Clipbrd;

type
  TMainForm = class(TForm)
    TreeViewPanel: TPanel;
    MainPanel: TPanel;
    StatusBar: TStatusBar;
    TreeView: TTreeView;
    MainMenu: TMainMenu;
    mnFile: TMenuItem;
    N2: TMenuItem;
    mnExit: TMenuItem;
    ImageList: TImageList;
    PageControl: TPageControl;
    tabView: TTabSheet;
    tabSQL: TTabSheet;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ViewGrid: TDBGrid;
    mnBD: TMenuItem;
    mnSelect: TMenuItem;
    N3: TMenuItem;
    mnConnect: TMenuItem;
    mnDisConnect: TMenuItem;
    ADOConnect: TADOConnection;
    ADOQuery: TADOQuery;
    DataSource: TDataSource;
    TreeViewMenu: TPopupMenu;
    N1: TMenuItem;
    SaveDialog: TSaveDialog;
    mnHelp: TMenuItem;
    mnAbout: TMenuItem;
    SQLPanel: TPanel;
    btnExeSQL: TSpeedButton;
    btnSaveSQL: TSpeedButton;
    btnLoadSQL: TSpeedButton;
    Bevel4: TBevel;
    SQLMemo: TMemo;
    ResultPanel: TPanel;
    ResultGrid: TDBGrid;
    mnView: TMenuItem;
    mnSQL: TMenuItem;
    mnResult: TMenuItem;
    OpenDialog: TOpenDialog;
    mnEdit: TMenuItem;
    mnUndo: TMenuItem;
    N5: TMenuItem;
    mnCut: TMenuItem;
    mnCopy: TMenuItem;
    mnPaste: TMenuItem;
    mnDelete: TMenuItem;
    mnSelectAll: TMenuItem;
    mnHelpSQL: TMenuItem;
    mnHelpApp: TMenuItem;
    N7: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure mnExitClick(Sender: TObject);
    procedure mnSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure mnConnectClick(Sender: TObject);
    procedure mnDisConnectClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnSQLClick(Sender: TObject);
    procedure btnExeSQLClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure mnAboutClick(Sender: TObject);
    procedure TreeViewDblClick(Sender: TObject);
    procedure mnUndoClick(Sender: TObject);
    procedure mnSelectAllClick(Sender: TObject);
    procedure mnCopyClick(Sender: TObject);
    procedure mnPasteClick(Sender: TObject);
    procedure mnCutClick(Sender: TObject);
    procedure mnDeleteClick(Sender: TObject);
    procedure mnEditClick(Sender: TObject);
    procedure btnSaveSQLClick(Sender: TObject);
    procedure btnLoadSQLClick(Sender: TObject);
    procedure mnResultClick(Sender: TObject);
  private
    procedure CreateFieldNodes(TableNode:TTreeNode);
    procedure CreateTableNodes(Parent:TTreeNode);

    procedure Connection(Sender:TObject);
    procedure DisConnection(Sender:TObject);
    
    procedure InsertStringCurPos(Str:string;var List:TMemo);
  public
    procedure BtnState;
  end;

var
  MainForm: TMainForm;
  Connect: boolean;
  Select : boolean;

implementation

uses ConnectUnit, TypeAndConstUnit, NodeAndItemWork, AboutUnit,
  myClipboard;

{$R *.dfm}


procedure TMainForm.Connection(Sender:TObject);
var item: TTreeNode; Data:TNodeData;
begin
 Connect := true;
 try
   if not Connect then ADOConnect.Open;
   item := TreeView.Items.Add(nil,BDInfo.FileName);
   item.ImageIndex := 2;
   item.SelectedIndex := 2;
   CreateTableNodes(item);
   Data.NodeType := ntBD;
   Data.ID := 0;
   SetDataNode(Data,item);

   StatusBar.Panels.Items[0].Text := 'Connection';
   StatusBar.Panels.Items[1].Text := BDInfo.FileName; 
 except
   Connect := false;
   ShowMessage('Error : Ошибка подключения к базе '+BDInfo.FileName);
 end;
end;

procedure TMainForm.DisConnection(Sender:TObject);
begin
 if Connect then
 begin
   ADOConnect.Close;
   Connect := false;
   ClearTreeView(TreeView);
   BtnState;
 end;
end;

procedure TMainForm.BtnState;
begin
  mnConnect.Enabled := (not Connect)and(Select);
  mnDisConnect.Enabled  := (Connect)and(Select);
end;

procedure TMainForm.CreateFieldNodes(TableNode:TTreeNode);
var i:integer; List:TStringList; item:TTreeNode; Data:TNodeData;
begin
 List := TStringList.Create;
 ADOConnect.GetFieldNames(TableNode.Text,List);
 for i := 0 to List.Count - 1 do
 begin
   item := TreeView.Items.AddChild(TableNode,List[i]);
   item.ImageIndex := 4;
   item.SelectedIndex := 4;
   Data.NodeType := ntField;
   Data.ID := 2;
   SetDataNode(Data,item);
 end;
 List.Free;
end;

procedure TMainForm.CreateTableNodes(Parent:TTreeNode);
var i:integer; List:TstringList; item: TTreeNode; Data:TNodeData;
begin
 List := TstringList.Create;
 ADOConnect.GetTableNames(List);
 for i := 0 to List.Count - 1 do
 begin
   item := TreeView.Items.AddChild(Parent,List[i]);
   item.ImageIndex := 5;
   item.SelectedIndex := 5;
   Data.NodeType := ntTable;
   Data.ID := 1;
   SetDataNode(Data,item);
   CreateFieldNodes(item);
 end;
end;

procedure TMainForm.InsertStringCurPos(Str:string;var List:TMemo);
var LineNum : LongInt; CharNum : LongInt;s:string;
begin
 LineNum := List.Perform(EM_LINEFROMCHAR,List.SelStart,0);
 CharNum := List.Perform(EM_LINEINDEX,LineNum,0);
 CharNum := (List.SelStart-CharNum) + 1;
 s := List.Lines.Strings[LineNum];
 Insert(str,s,CharNum);
 List.Lines.Strings[LineNum] := s;
end;

procedure TMainForm.mnExitClick(Sender: TObject);
begin
 Application.Terminate; 
end;

procedure TMainForm.mnSelectClick(Sender: TObject);
begin
 if ConnectForm.ShowModal = mrOK then
 begin
   if Connect then
   begin
     DisConnection(Sender);
   end;
   ADOConnect.ConnectionString := BDInfo.ConnectString;
   Select := true;
   Connection(Sender);
 end;
 BtnState;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Connect := false;
 Select := false;
 AppDir := ExtractFilePath(Application.ExeName);
 BinDir := AppDir + 'Bin\';
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
var Data:TNodeData;
begin
 if Node <> nil then
    StatusBar.Panels.Items[2].Text := Node.Text;
 if (PageControl.ActivePageIndex = 0)and Connect then
 begin
  GetDataNode(Node,Data);
  if Data.NodeType = ntTable then
  begin
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('select * from [' + Node.Text + ']');
    ADOQuery.Open;
  end;
 end;
end;

procedure TMainForm.mnConnectClick(Sender: TObject);
begin
 Connection(Sender);
end;

procedure TMainForm.mnDisConnectClick(Sender: TObject);
begin
 DisConnection(Sender);
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
 if SaveDialog.Execute then
 begin
   TreeView.SaveToFile(SaveDialog.FileName); 
 end;
end;
                            
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DisConnection(Sender);
end;

procedure TMainForm.mnSQLClick(Sender: TObject);
begin
 mnSQL.Checked := not mnSQL.Checked;
 SQLPanel.Visible := mnSQL.Checked;
end;

procedure TMainForm.btnExeSQLClick(Sender: TObject);
begin
 try
   ADOQuery.Close;
   ADOQuery.SQL.Clear;
   ADOQuery.SQL.AddStrings(SQLMemo.Lines);
   ADOQuery.Open;
 except
   ShowMessage('Error : Ошибка при выполнении запроса');
 end;
end;

procedure TMainForm.PageControlChange(Sender: TObject);
begin
 ADOQuery.Close;
 if PageControl.ActivePageIndex = 0 then
 begin
   TreeViewChange(Sender,TreeView.Selected); 
 end;
end;

procedure TMainForm.mnAboutClick(Sender: TObject);
begin
 AboutBox.ShowModal; 
end;

procedure TMainForm.TreeViewDblClick(Sender: TObject);
var InsertStr: string;
begin
 if (TreeView.Selected <> nil)and(PageControl.ActivePageIndex = 1) then
 begin
  InsertStr := ' [' + TreeView.Selected.Text + '] ';
  InsertStringCurPos(InsertStr,SQLMemo);
 end;
end;

procedure TMainForm.mnUndoClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   SQLMemo.Undo;
 end;
end;

procedure TMainForm.mnSelectAllClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   SQLMemo.SelectAll;
 end;
end;

procedure TMainForm.mnCopyClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   Clipboard.AsText := SQLMemo.SelText;
 end;
end;

procedure TMainForm.mnPasteClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   if SQLMemo.SelText <> '' then SQLMemo.SelText := LoadTextFromClipboard
   else InsertStringCurPos(LoadTextFromClipboard,SQLMemo);
 end;
end;

procedure TMainForm.mnCutClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   Clipboard.AsText := SQLMemo.SelText;
   SQLMemo.SelText := '';
 end;
end;

procedure TMainForm.mnDeleteClick(Sender: TObject);
begin
 if Screen.ActiveControl = SQLMemo then
 begin
   SQLMemo.SelText := '';
 end;
end;

procedure TMainForm.mnEditClick(Sender: TObject);
begin
  if Screen.ActiveControl <> SQLMemo then
  begin
    mnUndo.Enabled   := false;
    mnCut.Enabled    := false;
    mnCopy.Enabled   := false;
    mnPaste.Enabled  := false;
    mnDelete.Enabled := false;
    mnSelectAll.Enabled := false;
    Exit;
  end;
  mnPaste.Enabled := Clipboard.HasFormat(1);
  mnCopy.Enabled :=  SQLMemo.SelText <> '';
  mnCut.Enabled  :=  SQLMemo.SelText <> '';
  mnDelete.Enabled := SQLMemo.SelText <> '';
  mnSelectAll.Enabled := SQLMemo.Lines.Text <> '';
end;

procedure TMainForm.btnSaveSQLClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    SQLMemo.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.btnLoadSQLClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    SQLMemo.Lines.LoadFromFile(OpenDialog.FileName); 
  end;
end;

procedure TMainForm.mnResultClick(Sender: TObject);
begin
  mnResult.Checked := not mnResult.Checked;
  ResultPanel.Visible := mnResult.Checked;
end;

end.
