unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TMtrx, ActnCtrls, ToolWin, ActnMan, ActnMenus, ExtActns,
  StdActns, ActnList, PlatformDefaultStyleActnCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    Memo1: TMemo;
    ActionManager: TActionManager;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    HelpContents1: THelpContents;
    HelpTopicSearch1: THelpTopicSearch;
    HelpOnHelp1: THelpOnHelp;
    HelpContextAction1: THelpContextAction;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FilePrintSetup1: TFilePrintSetup;
    FilePageSetup1: TFilePageSetup;
    FileExit1: TFileExit;
    ListControlCopySelection1: TListControlCopySelection;
    ListControlDeleteSelection1: TListControlDeleteSelection;
    ListControlMoveSelection1: TListControlMoveSelection;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    StatusBar1: TStatusBar;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileOpen1BeforeExecute(Sender: TObject);
  private
    procedure OnMatrixLoad(Sender: TObject);
    procedure OnAddItem(Sender: TObject; ItemIndex: integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Matrix: TMatrixFile;

implementation

{$R *.dfm}

procedure TForm1.FileOpen1BeforeExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    Matrix.FileName := OpenDialog.FileName;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Matrix := TMatrixFile.Create;
  Matrix.AutoLoad := true;
  Matrix.OnLoad := OnMatrixLoad;
  Matrix.TestList.OnAfterAddItem := OnAddItem;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Matrix <> nil then Matrix.Free;
end;

procedure TForm1.OnAddItem(Sender: TObject; ItemIndex: integer);
begin
  //ListBox.Items.Add(Matrix.TestList[ItemIndex].Name);
end;

procedure TForm1.OnMatrixLoad(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.AddStrings(Matrix.Strings);
end;

end.
