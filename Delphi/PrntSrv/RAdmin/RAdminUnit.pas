unit RAdminUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ToolWin, ImgList, DB, ADODB, ActnList, ActnMan,
  ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TAddStat = (asError = 0, asOK = 1, asExists = 2);

type
  TViewStat = (vsNone = 0, vsComp = 1, vsPrint = 2);

type
  TRAdminForm = class(TForm)
    StatusBar: TStatusBar;
    ToolBar1: TToolBar;
    btnConnect: TToolButton;
    btnDisConnect: TToolButton;
    btnSnc: TToolButton;
    CompList: TListView;
    SmallImags: TImageList;
    LargeImages: TImageList;
    Images: TImageList;
    ImagesH: TImageList;
    ImagesD: TImageList;
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    ItemMenu: TPopupMenu;
    mnView: TMenuItem;
    mnGetDB: TMenuItem;
    ListMenu: TPopupMenu;
    mnAddComp: TMenuItem;
    SaveDialog: TSaveDialog;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ADOCnct: TADOConnection;
    ADOQ: TADOQuery;
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    actAdd: TAction;
    actChange: TAction;
    actDelete: TAction;
    actSmall: TAction;
    actList: TAction;
    actTable: TAction;
    ToolButton6: TToolButton;
    btnView: TToolButton;
    ViewMenu: TPopupMenu;
    mnSmallIcon: TMenuItem;
    mnList: TMenuItem;
    mnTable: TMenuItem;
    actExit: TAction;
    actConnect: TAction;
    actDisconnect: TAction;
    actRename: TAction;
    N1: TMenuItem;
    mnRename: TMenuItem;
    actGetDB: TAction;
    N2: TMenuItem;
    ConImages: TImageList;
    ToolButton1: TToolButton;
    btnAddComp: TToolButton;
    btnDelComp: TToolButton;
    btnRename: TToolButton;
    ToolButton7: TToolButton;
    actSnc: TAction;
    actInfo: TAction;
    actClear: TAction;
    btnChange: TToolButton;
    Action1: TAction;
    N3: TMenuItem;
    mnDel: TMenuItem;
    mnChange: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CompListDblClick(Sender: TObject);
    procedure CompListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CompListKeyPress(Sender: TObject; var Key: Char);
    procedure actSmallExecute(Sender: TObject);
    procedure actListExecute(Sender: TObject);
    procedure actTableExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure CompListEdited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure actRenameExecute(Sender: TObject);
    procedure actGetDBExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure actSncExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure CompListColumnClick(Sender: TObject; Column: TListColumn);
    procedure actChangeExecute(Sender: TObject);
  private
    FViewStat: TViewStat;
    function Connection: boolean;
    function ExecSQL(Query:TADOQuery;SQLStr: string; flag: byte = 0): boolean;
    procedure LoadCompList;
    procedure LoadPrinterList(CompItem: TListItem);
    procedure LoadPrinterListNet;
    procedure ClearList;
    procedure LoadAllDB;
    function AddComp(AName,AInfo: string): TAddStat;
    function DelComp(ID: integer): boolean; 
    function SaveCompInfo(ID: integer;AName,AInfo: string): boolean; overload;
    function SaveCompInfo(ID: integer;AName: string): boolean;       overload;
    procedure SetViewStat(const Value: TViewStat);

  public
    property ViewStat: TViewStat read FViewStat write SetViewStat;
  end;

var
  RAdminForm: TRAdminForm;

implementation

uses Global, GlRAdmin, TPrntClient, AddCompUnit, GetComp, InfoUnit,
  ProgressUnit;

{$R *.dfm}

type
  TStat = (stNone = 0, stComp = 1, stPrint = 2);

var
  Client: TPClient;
  AppDir: TFileName;
  bmp: TBitmap;
  CmpIndex: integer = -1;
  SortColumn: integer = 0;
  sp: SmallInt = 1;

function CompListCustomSort(Item1, Item2: TListItem;
  ParamSort: integer): integer; stdcall;
begin
  if SortColumn <> 0 then
  begin
    Result := sp * CompareText(Item1.SubItems.Strings[SortColumn-1],
      Item2.SubItems.Strings[SortColumn-1]);
    Exit;
  end;
  Result := sp * CompareText(Item1.Caption,Item2.Caption);
end;

function TRAdminForm.Connection: boolean;
begin
  Result := true;
  ADOConnection.ConnectionString :=
    ConnectionString + AppDir + '..\' +LimitDBName;
  try
    ADOConnection.Open;
  except
    ShowMessage('Неудалось подключиться к базе данных');
    Result := false;
  end;
end;

function TRAdminForm.ExecSQL(Query:TADOQuery;SQLStr: string; flag: byte): boolean;
begin
  Result := true;
  try
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add(SQLStr);
    case flag of
      0:  Query.Open;
      1:  Query.ExecSQL;
    end;
  except
    Result := false;
  end;
end;

procedure TRAdminForm.LoadCompList;
var item: TListItem; inf: TItemInfo;
begin
  ClearList;
  CompList.Columns.Items[0].Caption := 'Компьютер';
  CompList.Columns.Items[1].Caption := 'IP адрес';
  if not ADOConnection.Connected then Exit;
  if not ExecSQL(ADOQuery,'Select * from PServer ps  order by ps.Name') then
    Exit;
  while not ADOQuery.Eof do
  begin
    item := CompList.Items.Add;
    item.Caption := ADOQuery.FieldByName('Name').AsString;
    item.SubItems.Add(ADOQuery.FieldByName('IP').AsString);
    item.SubItems.Add(ADOQuery.FieldByName('Info').AsString);
    inf.ID := ADOQuery.FieldByName('ID').AsInteger;
    inf.IType := itComp;
    SetItemInfo(inf,item);
    item.ImageIndex := 0;
    item.StateIndex := 0;
    ADOQuery.Next;
  end;
  ViewStat := vsComp;
  if CmpIndex > CompList.Items.Count - 1 then CmpIndex := -1; 
end;

procedure TRAdminForm.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);
  if Connection then LoadCompList;
  Client := TPClient.Create;
end;

procedure TRAdminForm.LoadPrinterList(CompItem: TListItem);
var inf: TItemInfo; itm: TListItem; SQL: string;
    cmp: string;
begin
  inf := GetItemInfo(CompItem);
  if inf.IType <> itComp then Exit;
  cmp := CompItem.Caption;
  ClearList;
  CompList.Columns.Items[0].Caption := 'Принтер';
  CompList.Columns.Items[1].Caption := 'Компьютер';
  itm := CompList.Items.Add;
  itm.Caption := '..';
  itm.ImageIndex := 0;
  itm.StateIndex := 0;
  SetItemInfo(NilItem,itm);

  SQL := 'Select allp.ID, allp.PName, allp.Info from AllPrinters allp, PServer ps'+
    ' where allp.SID = ps.ID and ps.ID = '+ IntToStr(inf.ID);
  if not ExecSQL(ADOQuery,SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    itm := CompList.Items.Add;
    itm.Caption := ADOQuery.FieldByName('PName').AsString;
    itm.SubItems.Add(cmp);
    itm.SubItems.Add(ADOQuery.FieldByName('Info').AsString);
    itm.ImageIndex := 1;
    itm.StateIndex := 1;
    inf.ID := ADOQuery.FieldByName('ID').AsInteger;
    inf.IType := itPrinter;
    SetItemInfo(inf,itm);
    ADOQuery.Next;
  end;
  ViewStat := vsPrint;
end;

procedure TRAdminForm.CompListDblClick(Sender: TObject);
var inf: TItemInfo;
begin
  if CompList.Selected <> nil then
  begin
    if CompList.Selected.Caption = '..' then
    begin
      actDisConnect.Execute;
      Exit;
    end;
    inf := GetItemInfo(CompList.Selected);
    if inf.IType = itComp then
    begin
      actConnect.Execute;
    end;
  end;
end;

procedure TRAdminForm.LoadPrinterListNet;
var i: integer; itm: TListItem;
    cmp: string; inf: TItemInfo;
begin
  cmp := CompList.Selected.Caption;
  ClearList;
  CompList.Columns.Items[0].Caption := 'Принтер';
  CompList.Columns.Items[1].Caption := 'Компьютер';
  itm := CompList.Items.Add;
  itm.Caption := '..';
  itm.ImageIndex := 0;
  itm.StateIndex := 0;
  SetItemInfo(NilItem,itm);
  CompList.Selected := itm;
  CompList.ItemIndex := itm.Index;
  CompList.ItemFocused := itm;
  Client.LoadPrinterList;
  for i := 0 to Client.PArray.Count - 1 do
  begin
    itm := CompList.Items.Add;
    itm.Caption := Client.PArray.Item[i].PName;
    itm.SubItems.Add(cmp);
    itm.ImageIndex := 1;
    itm.StateIndex := 1;
    inf.ID := Client.PArray.Item[i].ID;
    inf.IType := itPrinter;
    SetItemInfo(inf,itm);
  end;
  ViewStat := vsPrint;
end;

procedure TRAdminForm.ClearList;
var i: integer;
begin
  ViewStat := vsNone;
  for i := 0 to CompList.Items.Count - 1 do
  begin
    ClearItem(CompList.Items.Item[i]);
  end;
  CompList.Items.Clear;
end;

procedure TRAdminForm.CompListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var inf: TItemInfo;
    itType: TItemType;
begin
  CompList.PopupMenu := nil;
  itType := itNone;
  if (not Selected) and (FViewStat = vsComp) then
  begin
    CompList.PopupMenu := ListMenu;
    StatusBar.Panels.Items[0].Text := 'Компьютер: ';
  end;

  if Selected then
  begin
    inf := GetItemInfo(Item);
    if inf.IType = itComp then
    begin
      CompList.PopupMenu := ItemMenu;
      itType := itComp;
      StatusBar.Panels.Items[0].Text := 'Компьютер: '+ Item.Caption;
      //actAdd.Enabled := true;
      //actDelete.Enabled := true;
    end;
  end;
  actConnect.Enabled    := Selected and (itType = itComp);
  actDisConnect.Enabled := FViewStat = vsPrint;//Client.Status = csConnect;
  actGetDB.Enabled      := Selected and (itType = itComp);
  actRename.Enabled     := Selected and (itType = itComp);
  actDelete.Enabled     := Selected and (itType = itComp);
  actChange.Enabled     := Selected and (itType = itComp);
end;

procedure TRAdminForm.LoadAllDB;
var ip, SQL: string; FName: TFileName;
    FileList: TStringList;
    i: integer;
begin
  if not ADOConnection.Connected then Exit;
  if not ExecSQL(ADOQuery,'Select * from PServer ps order by ps.Name') then Exit;

  ProgressForm.BorderStyle := bsDialog;
  ProgressForm.lblPr.Caption := 'Генерация списка компьютеров...';
  ProgressForm.Gauge.Progress := 0;
  ProgressForm.Gauge.MaxValue := ADOQuery.RecordCount;
  ProgressForm.Show;
  Application.ProcessMessages;

  FileList := TStringList.Create;
  while not ADOQuery.Eof do
  begin
    ProgressForm.lblPr.Caption := 'Загрузка с '+ ADOQuery.FieldByName('Name').AsString +'...';
    Application.ProcessMessages;
    FName := AppDir + 'TmpDB\' + ADOQuery.FieldByName('Name').AsString + '.mdb';
    Client.DisConnection;
    ip := ADOQuery.FieldByName('IP').AsString;
    Client.Connection(ip);
    if Client.LoadDBFile(FName) then
    begin
      FileList.Add(FName);
      Client.DisConnection;
      Client.Connection(ip);
      Client.BDClear;
    end;
    Client.DisConnection;
    ADOQuery.Next;
    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1; 
  end;

  SQL := 'Select * from Report';
  // обьединение данных;
  ProgressForm.lblPr.Caption := 'Обьединение данных...';
  if not ExecSQL(ADOQuery,SQL) then
  begin
    ProgressForm.Close;
    FileList.Free;
    Exit;
  end;
  for i := 0 to FileList.Count - 1 do
  begin
    ADOCnct.ConnectionString := ConnectionString + FileList.Strings[i];
    ProgressForm.Gauge.Progress := 0;
    try
      ADOCnct.Open;
      try
        if not ExecSQL(ADOQ,SQL) then Continue;
        ProgressForm.Gauge.MaxValue := ADOQ.RecordCount;
        Application.ProcessMessages;
        while not ADOQ.Eof do
        begin
          ADOQuery.Append;
          ADOQuery.FieldByName('UName').AsString :=
            ADOQ.FieldByName('UName').AsString;
          ADOQuery.FieldByName('PName').AsString :=
            ADOQ.FieldByName('PName').AsString;
          ADOQuery.FieldByName('Document').AsString :=
            ADOQ.FieldByName('Document').AsString;
          ADOQuery.FieldByName('Machine').AsString :=
            ADOQ.FieldByName('Machine').AsString;
          ADOQuery.FieldByName('PageCount').AsInteger :=
            ADOQ.FieldByName('PageCount').AsInteger;
          ADOQuery.FieldByName('Date').AsDateTime :=
            ADOQ.FieldByName('Date').AsDateTime;
          ADOQuery.Post;
          ADOQ.Next;
          ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
        end;
      except
        Continue;
      end
    finally
      ADOCnct.Close;
    end;
  end;
  ProgressForm.Close;
  FileList.Free;
end;

procedure TRAdminForm.CompListKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = 13 then  CompListDblClick(Sender);
end;

procedure TRAdminForm.actSmallExecute(Sender: TObject);
begin
  SortColumn := -1;
  CompListColumnClick(Sender,CompList.Column[0]);
  CompList.ViewStyle := vsIcon;
end;

procedure TRAdminForm.actListExecute(Sender: TObject);
begin
  SortColumn := -1;
  CompListColumnClick(Sender,CompList.Column[0]);
  CompList.ViewStyle := vsList;
end;

procedure TRAdminForm.actTableExecute(Sender: TObject);
begin
  CompList.ViewStyle := vsReport;
end;

procedure TRAdminForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TRAdminForm.actConnectExecute(Sender: TObject);
var inf: TItemInfo;
begin
  if CompList.Selected = nil then Exit;
  inf := GetItemInfo(CompList.Selected);
  if inf.IType = itComp then
  begin
    CmpIndex := CompList.Selected.Index;
    Client.DisConnection;
    Client.Connection(CompList.Selected.SubItems.Strings[0]);
    if Client.Status = csConnect then
    begin
      LoadPrinterListNet;
    end;
    Client.DisConnection;
    //LoadPrinterList(CompList.Selected);
  end;
end;

procedure TRAdminForm.actDisconnectExecute(Sender: TObject);
begin
  Client.DisConnection;
  LoadCompList;
  if CmpIndex <> - 1 then
  begin
    CompList.ItemFocused := CompList.Items[CmpIndex];
    CompList.ItemIndex := CmpIndex;
    CompList.SetFocus;
  end;
end;

procedure TRAdminForm.actAddExecute(Sender: TObject);
begin
  FindComputers;
  if Trim(Computers.Text) <> '' then
    AddCompForm.CompBox.Items := Computers;
  if AddCompForm.ShowModal = mrOK then
  begin
    case AddComp(AddCompForm.CompBox.Text,AddCompForm.Info.Text) of
      asExists: ShowMessage('Невозможно добавить компьютер. Информация о компьютере уже есть в базе данных.');
      asError : ShowMessage('Ошибка при добавлении компьютера в базу данных');
    end;
    if FViewStat = vsComp then LoadCompList;
  end;
  AddCompForm.CompBox.Text := '';
end;

function TRAdminForm.AddComp(AName, AInfo: string): TAddStat;
begin
  Result := asError;
  // Проверка на наличие компа в базе данных
  if not ExecSQL(ADOQuery,'Select * from PServer ps where ps.Name = '+
    '''' + AName + '''') then Exit;
  if not ADOQuery.Eof then
  begin
    Result := asExists;
    Exit;
  end;
  // Если такого компа нету, добавляем его
  if not ExecSQL(ADOQuery,'Select * from PServer') then
  begin
    Result := asExists;
    Exit;
  end;
  // Непосредственно добавление компа в базу
  Result := asOK;
  try
    ADOQuery.Append;
    ADOQuery.FieldByName('Name').AsString := AName;
    ADOQuery.FieldByName('Info').AsString := AInfo;
    ADOQuery.Post;
  except
    Result := asError;
  end;
end;

function TRAdminForm.DelComp(ID: integer): boolean;
begin
  Result := false;
  // Удаляем все прнтеры на этом компе
  if not ExecSQL(ADOQuery,'delete * from AllPrinters allp where allp.SID = ' +
    IntToStr(ID),1) then Exit;
  // Удаляем информацию о компьютере
  if ExecSQL(ADOQuery,'delete * from PServer ps where ps.ID = ' +
    IntToStr(ID),1) then Result := true;
end;

procedure TRAdminForm.CompListEdited(Sender: TObject; Item: TListItem;
  var S: String);
var inf: TItemInfo;
begin
  inf := GetItemInfo(Item);
  if inf.IType = itComp then
  begin
    S := Trim(S);
    // Если строка пустая, не меняем имя
    if S = '' then begin S := Item.Caption; exit; end;
    // Проверка на уникальность имени
    if ExecSQL(ADOQuery,'Select * from PServer ps where ps.Name = '+
      '''' + S + '''') then
      // Если нету компов с таким именем, то заносим изменения в базу
      if ADOQuery.Eof then SaveCompInfo(inf.ID,S)
    else
      S := Item.Caption;
  end;
end;

function TRAdminForm.SaveCompInfo(ID: integer; AName,
  AInfo: string): boolean;
begin
  Result := false;
  if not ExecSQL(ADOQuery,'Select * from PServer ps where ps.ID = ' +
    IntToStr(ID)) then Exit;
  if not ADOQuery.Eof then
  begin
    Result := true;
    try
      ADOQuery.Edit;
      ADOQuery.FieldByName('Name').AsString := AName;
      ADOQuery.FieldByName('Info').AsString := AInfo;
      ADOQuery.Post;
    except
      Result := false;
    end;
  end;
end;

function TRAdminForm.SaveCompInfo(ID: integer; AName: string): boolean;
begin
  Result := false;
  if not ExecSQL(ADOQuery,'Select * from PServer ps where ps.ID = ' +
    IntToStr(ID)) then Exit;
  if not ADOQuery.Eof then
  begin
    Result := true;
    try
      ADOQuery.Edit;
      ADOQuery.FieldByName('Name').AsString := AName;
      ADOQuery.Post;
    except
      Result := false;
    end;
  end;
end;

procedure TRAdminForm.actRenameExecute(Sender: TObject);
begin
  if CompList.Selected <> nil then
  begin
    CompList.Selected.EditCaption;
  end;
end;

procedure TRAdminForm.actGetDBExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    Client.DisConnection;
    Client.Connection(CompList.Selected.SubItems.Strings[0]);
    if Client.LoadDBFile(SaveDialog.FileName) then ShowMessage('Файл успешно получен');
    Client.DisConnection;
  end;  
end;

procedure TRAdminForm.actDeleteExecute(Sender: TObject);
var inf: TItemInfo;
    ms: string;
begin
  if CompList.Selected <> nil then
  begin
    ms := 'Удалить компьютер ' +
      CompList.Selected.Caption + ' из базы данных? ' +
      'При удалении компьютера из базы данных, будет удалена ' +
      'информация о подключенных к этому компьютеру принтерах.';
    if MessageDlg(ms,mtWarning,mbOKCancel,0) <> mrOk then Exit;
    inf := GetItemInfo(CompList.Selected);
    if inf.IType = itComp then
    begin
      DelComp(inf.ID);
      CompList.Items.Delete(CompList.Selected.Index);
      CompList.AlphaSort;
    end;
  end;
end;

procedure TRAdminForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  ConImages.GetBitmap(Integer(ViewStat) - 1,bmp);
  bmp.Transparent := true;
  StatusBar.Canvas.Draw(Rect.Left + 2,Rect.Top,bmp);
end;

procedure TRAdminForm.SetViewStat(const Value: TViewStat);
begin
  FViewStat := Value;
  actDisConnect.Enabled := FViewStat = vsPrint;
  StatusBar.Repaint;
end;

procedure TRAdminForm.actSncExecute(Sender: TObject);
begin
  LoadAllDB;
end;

procedure TRAdminForm.actInfoExecute(Sender: TObject);
begin
  InfoForm.ShowModal;  
end;

procedure TRAdminForm.CompListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if SortColumn = Column.Index then
  begin
    sp := sp * -1;
  end else sp := 1;
  SortColumn := Column.Index;
  CompList.CustomSort(@CompListCustomSort,0);
end;

procedure TRAdminForm.actChangeExecute(Sender: TObject);
var inf: TItemInfo;
begin
  FindComputers;
  if Trim(Computers.Text) <> '' then
    AddCompForm.CompBox.Items := Computers;
  inf := GetItemInfo(CompList.Selected);
  if inf.IType <> itComp then Exit;
  AddCompForm.CompBox.Text := CompList.Selected.Caption;
  AddCompForm.Info.Text    := CompList.Selected.SubItems.Strings[1];
  if AddCompForm.ShowModal = mrOK then
  begin
    // Проверка на уникальность имени
    if ExecSQL(ADOQuery,'Select * from PServer ps where ps.Name = '+
      '''' + Trim(AddCompForm.CompBox.Text) + '''') then
    // Если нету компов с таким именем, то заносим изменения в базу
    if ADOQuery.Eof then
      SaveCompInfo(inf.ID,AddCompForm.CompBox.Text,AddCompForm.Info.Text)
    else begin
      ShowMessage(msgNoNameComp);
      Exit;
    end;
    CompList.Selected.Caption := AddCompForm.CompBox.Text;
    CompList.Selected.SubItems.Strings[1] := AddCompForm.Info.Text;
  end;
  AddCompForm.CompBox.Text := '';
end;

initialization
begin
  bmp := TBitmap.Create;
end;

finalization
begin
  bmp.Free;
end;

end.
