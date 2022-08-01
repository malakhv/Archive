unit DioMngrUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ActnMan, ActnCtrls, ActnMenus, PlatformDefaultStyleActnCtrls, ActnList,
  StdCtrls;

type
  TForm1 = class(TForm)
    DioTree: TTreeView;
    StatusBar: TStatusBar;
    ActionManager: TActionManager;
    MainMenu: TActionMainMenuBar;
    Edit1: TEdit;
    btnAddDio: TButton;
    btnDelete: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    btnFind: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DioTreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnAddDioClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
  private
    FDioMask: string;
    procedure SetFileName(const Value: TFileName);
    function GetAppDir: TFileName;
    function GetDataDir: TFileName;
    procedure SetDioMask(const Value: string);
  public
    property AppDir: TFileName read GetAppDir;
    property DataDir: TFileName read GetDataDir;
    property FileName: TFileName write SetFileName;
    property DioMask: string read FDioMask write SetDioMask;
    function ImportDioInfoFile(AFileName: TFileName): boolean;
    function ImportDataFile(AFileName: TFileName): boolean;
    procedure UpdateDioList;
    procedure UpdateDioText;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  XMLIntf, MyXMLUtils, XMLDioList, DioInfoLib, DioDataLib;

const
  DioFileExt = '.info';
  DataFileExt = '.d9m';

const
  DefMask = 'n - o';


var
  IDioList: IXMLDioList;

{ TForm1 }

procedure TForm1.btnAddDioClick(Sender: TObject);
var i: integer;
begin
  if OpenDialog.Execute then
    for i := 0 to OpenDialog.Files.Count - 1 do
    begin
      if ExtractFileExt(OpenDialog.Files[i]) = DioFileExt then
        ImportDioInfoFile(OpenDialog.Files[i]);
      if ExtractFileExt(OpenDialog.Files[i]) = DataFileExt then
        ImportDataFile(OpenDialog.Files[i]);
    end;
  UpdateDioList;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  if DeleteXMLNode(IXMLNode(DioTree.Selected.Data)) then
    DioTree.Items.Delete(DioTree.Selected);
end;

procedure TForm1.btnFindClick(Sender: TObject);
begin
  if FindChildByAttr(IDioList,'Number',Edit1.Text) <> nil then
    ShowMessage('Find is OK');
end;

procedure TForm1.DioTreeChange(Sender: TObject; Node: TTreeNode);
begin
  Edit1.Clear;
  if Node = nil then Exit;
  case Node.Level of
    0: Edit1.Text := IXMLDioInfo(Node.Data).Address;
    1: Edit1.Text := IXMLDataFile(Node.Data).FileName;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
const
  DefDioList = 'DioList.xml';
begin
  FDioMask := DefMask;
  IDioList := LoadDioList(AppDir + DefDioList);
  UpdateDioList;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeDioList(IDioList);
end;

function TForm1.GetAppDir: TFileName;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

function TForm1.GetDataDir: TFileName;
begin
  Result := AppDir + 'DioData\';
end;

function TForm1.ImportDataFile(AFileName: TFileName): boolean;

  function GetDateTimeStr(ADateTime: TDateTime): string;
  var i: integer;
  begin
    Result := DateTimeToStr(ADateTime);
    for i := 1 to Length(Result) do
      if (Result[i] = '.') or (Result[i] = ':') then Result[i] := '-';
  end;

var 
  DioData: TDioData;
  XMLNode: IXMLNode;
  XMLDataFile: IXMLDataFile;
  
begin
  if not FileExists(AFileName) then Exit;
  DioData := TDioData.Create;
  try
    DioData.WorkData := false;
    DioData.FileName := AFileName;
    XMLNode := IDioList.GetDioInfoByNumber(DioData.CSData.SNum);
    if XMLNode = nil then
    begin
      XMLNode := IDioList.Add(DioData.CSData.SNum,'Адрес','Владелец');
      if not DirectoryExists(DataDir + IntToStr(DioData.CSData.SNum) + '\') then
        ForceDirectories(DataDir + IntToStr(DioData.CSData.SNum) + '\');
    end;
    XMLDataFile := (XMLNode as IXMLDioInfo).Add;
    XMLDataFile.FileName := IntToStr(DioData.CSData.SNum) + ' ' + GetDateTimeStr(DioData.CSData.Date);
    XMLDataFile.DioDate := DioData.CSData.Date;
    XMLDataFile.DioType := DioData.CSData.DioType;
    XMLDataFile.ArcType := byte(DioData.ArcType);
    CopyFile(PChar(AFileName),PChar(DataDir + IntToStr(DioData.CSData.SNum) + '\' + XMLDataFile.FileName),false);
  finally
    DioData.Free;
  end;
end;

function TForm1.ImportDioInfoFile(AFileName: TFileName): boolean;
begin
  with TDioInfo.Create(AFileName) do
  begin
    Result := IDioList.Add(Number,Address,Owner,Res01,Res02) <> nil;
    if Result and not DirectoryExists(DataDir + IntToStr(Number) + '\') then
      ForceDirectories(DataDir + IntToStr(Number) + '\');
    Free;
  end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  if (Sender as TRadioButton).Checked  then
    DioMask := (Sender as TRadioButton).Caption;
end;

procedure TForm1.SetDioMask(const Value: string);
begin
  if FDioMask <> Value then
  begin
    FDioMask := Value;
    UpdateDioText;
  end;
end;

procedure TForm1.SetFileName(const Value: TFileName);
begin

end;

procedure TForm1.UpdateDioText;
var Node: TTreeNode;
begin
  Node := DioTree.Items.GetFirstNode;
  while Node <> nil do
  begin
    if Node.Data <> nil then
      Node.Text := IXMLDioInfo(Node.Data).GetCaption(DioMask);
    Node := Node.getNextSibling;
  end;
end;

procedure TForm1.UpdateDioList;
var
  i,j: integer;
  Node: TTreeNode;
begin
  if DioTree.Items.Count > 0 then
  begin
    DioTree.ClearSelection;
    DioTree.Items.Clear;
  end;

  for i := 0 to IDioList.Count - 1 do
  begin
    Node := DioTree.Items.Add(nil,IDioList[i].GetCaption(DioMask));
    Node.Data := Pointer(IDioList[i]);
    for j := 0 to IDioList[i].Count - 1 do
      with DioTree.Items.AddChild(Node,DateToStr(IDioList[i][j].DioDate)) do
        Data := Pointer(IDioList[i][j]);
  end;
end;

end.
