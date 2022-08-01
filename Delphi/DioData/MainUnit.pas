unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  PlatformDefaultStyleActnCtrls, ActnList, ActnMan, ActnCtrls, ActnMenus, ExtCtrls, ImgList, Menus,
  ActnPopup, ToolWin;

type
  TMainForm = class(TForm)
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
    StatusBar: TStatusBar;
    DioTree: TTreeView;
    Splitter: TSplitter;
    actOpen: TAction;
    actSave: TAction;
    actExit: TAction;
    actCopy: TAction;
    actNakop: TAction;
    actOptions: TAction;
    ActImageList: TImageList;
    TreeMenu: TPopupActionBar;
    PopupActionBar: TPopupActionBar;
    actDioInfo: TAction;
    actDioInfo1: TMenuItem;
    DioDataPanel: TPanel;
    DatePanel: TPanel;
    DateBox: TComboBox;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    actMax: TAction;
    actMin: TAction;
    actAver: TAction;
    actSum: TAction;
    DataList: TListView;
    DataListPopup: TPopupActionBar;
    actCopy1: TMenuItem;
    actExport: TAction;
    actSelectAll: TAction;
    N1: TMenuItem;
    OwnerPanel: TPanel;
    lblInfo: TLabel;
    lblAddress: TLabel;
    actFields: TAction;
    actDioDelete: TAction;
    actDioClear: TAction;
    TreeImages: TImageList;
    actAscSort: TAction;
    actDesSort: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    actViewNumber: TAction;
    actViewNumberAndOwner: TAction;
    procedure FormCreate(Sender: TObject);
    procedure DioTreeChange(Sender: TObject; Node: TTreeNode);
    procedure actDioInfoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DateBoxChange(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNakopExecute(Sender: TObject);
    procedure actMinExecute(Sender: TObject);
    procedure DataListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure actCopyExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actFieldsExecute(Sender: TObject);
    procedure actDioDeleteExecute(Sender: TObject);
    procedure DioTreeDeletion(Sender: TObject; Node: TTreeNode);
    procedure actDioClearExecute(Sender: TObject);
    procedure DioTreeCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: Integer;
      var Compare: Integer);
    procedure actAscSortExecute(Sender: TObject);
    procedure DioTreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure actViewNumberExecute(Sender: TObject);
  private
    EDioDataDir: TFileName;
    procedure UpdateDioTree;
    procedure UpdateColumns;
    procedure UpdateDioCaption;
    procedure SetDioDataDir(const Value: TFileName);
    procedure OnDataLoad(Sender: TObject);
    procedure OnDioTypeChange(Sender: TObject);
    procedure OnDioInfoLoad(Sender: TObject);
  public
    property DioDataDir: TFileName read EDioDataDir write SetDioDataDir;
    procedure DeleteDio(DioNode: TTreeNode; DeleteDio: boolean = true);
  end;

var
  MainForm: TMainForm;

implementation

uses
  Clipbrd, MyFiles, MyListViewUtils, DioInfoUnit, FieldInfoUnit, DataExport, DioTypes, DioDataLib,
    DioFieldInfo, Global, ItemsWork, uDioOpt, ReportUnit, DioFieldLib, DioTypeLib, DioUtils, MyProgOpt,
  XMLDioList;

{$R *.dfm}

var

  { Порядок сортировки }

  SortOrder: integer = 1;

procedure TMainForm.actAscSortExecute(Sender: TObject);
begin
 SortOrder := Integer(actAscSort.Checked) - Integer(actDesSort.Checked);
 DioTree.AlphaSort;
end;

procedure TMainForm.actCopyExecute(Sender: TObject);
begin
  Clipboard.AsText := ListViewToStr(DataList,true,true);
end;

procedure TMainForm.actDioClearExecute(Sender: TObject);
begin
  if DioTree.Selected.Level = 0 then
    DeleteDio(DioTree.Selected,false)
  else
    DeleteDio(DioTree.Selected.Parent,false)
end;

procedure TMainForm.actDioDeleteExecute(Sender: TObject);
begin
  DeleteDio(DioTree.Selected);
end;

procedure TMainForm.actDioInfoExecute(Sender: TObject);
begin
  if ChangeDioInfo(DioInfo) then
    DioTree.Items[DioInfo.Index].Text := DioInfo.Caption;
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.actExportExecute(Sender: TObject);
var FrmExport: TExportFrm;
    ExportData: TDioData;
    ReportBuilder: TDioReportBuilder;
begin
  FrmExport := TExportFrm.Create(Application);
  try
    { Установка параметров отчета }
    FrmExport.ArcType := DioData.ArcType;
    FrmExport.DioType := DioType.DioType;
    FrmExport.ViewType := DioData.HData.ViewType;
    { Установка параметров дат }
    if DioData.ArcType = atHour then
    begin
      FrmExport.DateBox.Items.Assign(DateBox.Items);
      FrmExport.DateBox.ItemIndex := DateBox.ItemIndex;
    end
    else begin
      if DioData.HData.ViewType = vtCurrent then
        FrmExport.SDate := DioData.HData[1].Date
      else
        FrmExport.SDate := DioData.HData[0].Date;
      FrmExport.EDate := DioData.HData[DioData.HData.Count - 1].Date;
    end;

    if FrmExport.ShowModal = mrOk then
    begin
      { Подготовка данных }
      ExportData := TDioData.Create;
      try
        { Загрузка данных }
        ExportData.FileName := DioData.FileName;
        { Настройка данных }
        with ExportData.HData do
        begin
          { Начальная дата }
          StartDate := FrmExport.SDate;
          { Конечная дата }
          EndDate := FrmExport.EDate;
          { Тип отчета }
          DateFilter := true;
          if not FrmExport.cbNakop.Checked then
            ViewType := vtCurrent
          else
            ViewType := vtSavings;
          { Расчет статистики }
          Calculate;
        end;
        ReportBuilder := TDioReportBuilder.Create(ExportData,DioInfo,FrmExport.Report);
        try
          Reportbuilder.Min := FrmExport.cbMin.Checked;
          Reportbuilder.Max := FrmExport.cbMax.Checked;
          Reportbuilder.Sum := FrmExport.cbSum.Checked;
          Reportbuilder.Aver := FrmExport.cbAver.Checked;
          with ReportBuilder.BuildReport do
            if FrmExport.cbSaveAs.Checked then
              SaveAsPswrd(FrmExport.edDocFileName.Text,FrmExport.edPswrdOpen.Text,
              FrmExport.edPswrdWrite.Text);

          if FrmExport.cbOpenMSWord.Checked then ReportBuilder.Show;

        finally
          ReportBuilder.Free;
        end;
      finally
        ExportData.Free;
      end;
    end;
  finally
    FrmExport.Free;
  end;
end;

procedure TMainForm.actFieldsExecute(Sender: TObject);
begin
  if ChangeField(DioType.DioType) then
  begin
    UpdateColumns;
    OnDataLoad(nil);
  end;
end;

procedure TMainForm.actMinExecute(Sender: TObject);
begin
  if DioTree.Selected <> nil then
    if DioTree.Selected.Level > 0 then OnDataLoad(nil);
end;

procedure TMainForm.actNakopExecute(Sender: TObject);
begin
  if actNakop.Checked then
    DioData.HData.ViewType := vtSavings
  else
    DioData.HData.ViewType := vtCurrent;
  OnDataLoad(nil);
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
begin
  DioTree.Selected := nil;
  if OpenDialog.Execute then
  begin
    DioData.FileName := OpenDialog.FileName;
    actExport.Enabled := DioData.IsOpen;
    actSelectAll.Enabled := DioData.IsOpen;
    actFields.Enabled := DioData.IsOpen;
  end;
end;

procedure TMainForm.actSaveExecute(Sender: TObject);
var List: TStringList;
begin
  if SaveDialog.Execute then
    case SaveDialog.FilterIndex of
      1:  DioData.SaveToFile(SaveDialog.FileName);
      2,3:  begin
            List := TStringList.Create;
            try
              List.Text := ListViewToStr(DataList,false,true);
              List.SaveToFile(SaveDialog.FileName);
            finally
              List.Free;
            end;
          end;
    end;
end;

procedure TMainForm.actSelectAllExecute(Sender: TObject);
begin
  DataList.SetFocus;
  DataList.SelectAll;
end;

procedure TMainForm.actViewNumberExecute(Sender: TObject);
begin
  if actViewNumber.Checked then
    DioInfo.Mask := 'n'
  else
    DioInfo.Mask := 'n - o';
  ProgOpt.Option['DioMask'] := DioInfo.Mask;
  UpdateDioCaption;
end;

procedure TMainForm.DataListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  actCopy.Enabled := Selected;
end;

procedure TMainForm.OnDataLoad(Sender: TObject);

  procedure AddListItem(HData: TCustomDioData; ACaption: string = '');
  var Item: TListItem;
      j: integer;
  begin
    if DataList.Columns.Count = 0 then Exit;
    Item := DataList.Items.Add;
    for j := 0 to DataList.Columns.Count - 1 do
    begin
      if Item.Caption = '' then
        if ACaption = '' then
          Item.Caption := HData.StrItem[DataList.Columns[j].Tag]
        else
          Item.Caption := ACaption
      else
        Item.SubItems.Add(HData.StrItem[DataList.Columns[j].Tag]);
      end;
  end;

var i: integer;
    TmpDate: TDateTime;
begin
  DataList.Clear;
  DioType.DioType := DioData.CSData.DioType;
  DatePanel.Visible := DioData.IsArcHour;

  // Заполнение списка дат
  if (DioData.IsArcHour) and (Sender = DioData)   then
  begin
    DateBox.Clear;
    TmpDate := Date;
    for i := 0 to DioData.HData.Count - 1 do
      if TmpDate <> DioData.HData[i].Date then
      begin
        DateBox.Items.Add(DioData[i,iDate]);
        TmpDate := DioData.HData[i].Date
      end;
    if DateBox.Items.Count > 0 then DateBox.ItemIndex := 0;
  end;

  // Установка фильтра по дате
  if DioData.IsArcHour then
  begin
    DioData.HData.StartDate := StrToDate(DateBox.Items[DateBox.ItemIndex]);
    DioData.HData.EndDate := StrToDate(DateBox.Items[DateBox.ItemIndex]);
    DioData.HData.DateFilter := true;
  end else
    DioData.HData.DateFilter := false;

  // Загрузка данных прибора
  for i := 0 to DioData.HData.Count - 1 do
    if  DioData.HData[i].Enabled then
      if DioData.IsArcDay then
        AddListItem(DioData.HData[i])
      else
        AddListItem(DioData.HData[i],DioData[i,iHr]);

  // Заполнение данных статистики
  if DioData.HData.Count > 0 then
  begin
    DataList.Items.Add;
    DioData.HData.Calculate;
    if actMin.Checked then AddListItem(DioData.HData.Min,'Мин.');
    if actMax.Checked then AddListItem(DioData.HData.Max,'Макс.');
    if actAver.Checked then AddListItem(DioData.HData.Avarage,'Среднее');
    if actSum.Checked then AddListItem(DioData.HData.Sum,'Сумма');
  end;

  actSelectAll.Enabled := DataList.Items.Count > 0;
end;

procedure TMainForm.OnDioInfoLoad(Sender: TObject);
begin
  lblInfo.Caption := String(DioInfo.NumberAsStr + ' ' + DioInfo.Owner);
  lblAddress.Caption := String(DioInfo.Address);
end;

procedure TMainForm.OnDioTypeChange(Sender: TObject);
begin
  UpdateColumns;
end;

procedure TMainForm.DateBoxChange(Sender: TObject);
begin
  OnDataLoad(DateBox);
end;

procedure TMainForm.DeleteDio(DioNode: TTreeNode; DeleteDio: boolean);
const
  DioMsg = 'Вы действительно хотите удалить данные прибора?';
  DioPrb = ' Внимание! Все файлы данных прибора также будут удалены.';
var
  DlgMsg: string; DelFile: TFileInfo; i: integer;

  function DelDioFile(ADioNode: TTreeNode): boolean;
  begin
    DelFile.FullName := GetNodeInfo(ADioNode).FileName;
    Result := DelFile.Delete;
    if Result then ADioNode.Delete;
  end;

begin
  if DioNode = nil then Exit;
  // Формирование сообщения
  DlgMsg := DioMsg;
  if DioNode.Level = 0 then DlgMsg := DlgMsg + DioPrb;
  // Вывод на экран диалога
  if MessageDlg(DlgMsg,mtWarning,[mbOK,mbCancel],-1) = mrOk then
  begin
    DelFile := TFileInfo.Create;
    try
      // Удаление файлов данных
      for i := DioNode.Count - 1 downto 0  do
        DelDioFile(DioNode[i]);
      // Удаление файла прибора
      if DeleteDio then
        if DelDioFile(DioNode) then DioNode.Delete;
    finally
      DelFile.Free;
    end;
  end;
end;

procedure TMainForm.DioTreeChange(Sender: TObject; Node: TTreeNode);
begin
  actDioInfo.Enabled := Node <> nil;
  actDioDelete.Enabled := Node <> nil;
  actDioClear.Enabled := Node <> nil;

  if Node = nil then
  begin
    DioInfo.Clear;
    DioData.Clear;
    actSave.Enabled := false;
    actDioClear.Enabled := false;
    StatusBar.SimpleText := '';
    Exit;
  end;

  actSave.Enabled := Node.Level = 1;
  actExport.Enabled := Node.Level = 1;
  actSelectAll.Enabled := Node.Level = 1;
  actFields.Enabled := Node.Level = 1;

  if DioInfo.LoadFromFile( DioDataDir + IntToStr(GetNodeInfo(Node).Number) + '.info' ) then
  begin
    if Node.Level = 0 then
      DioInfo.Index := Node.AbsoluteIndex
    else
      DioInfo.Index := Node.Parent.AbsoluteIndex;
    StatusBar.SimpleText := DioInfo.GetTextMask(DioMaskAllData);
  end;

  if Node.Level = 1 then
    DioData.LoadFromFile(GetNodeInfo(Node).FileName)
  else
    DataList.Clear;
end;

procedure TMainForm.DioTreeCompare(Sender: TObject; Node1, Node2: TTreeNode; Data: Integer;
  var Compare: Integer);
begin
  if Node1.Level = 0 then
    Compare := SortOrder * (GetNodeInfo(Node1).Number - GetNodeInfo(Node2).Number);
  if Node1.Level = 1 then
    Compare := Node2.ImageIndex - Node1.ImageIndex;
end;

procedure TMainForm.DioTreeDeletion(Sender: TObject; Node: TTreeNode);
begin
  ClearNodeInfo(Node);
end;

procedure TMainForm.DioTreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var TmpNode: TTreeNode;
begin
  if Button = mbRight then
  begin
    TmpNode := DioTree.GetNodeAt(X,Y);
    if DioTree.Selected <> TmpNode then DioTree.Selected := TmpNode;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Папка приложения
  AppDir := ExtractFilePath(Application.ExeName);
  // Загрузка настроек
  ProgOpt := TCustomProgOptions.CreateXML(Self,AppDir + 'Options.xml');
  ProgOpt.NodeOptName := 'App';
  // Применение настроек
  DioInfo.Mask := ProgOpt.Option['DioMask'];
  actViewNumber.Checked := DioInfo.Mask = 'n';
  DioDataDir := AppDir + ProgOpt.Option['DataDir'] + '\';
  // Назначение событий
  DioData.OnLoad := OnDataLoad;
  DioType.OnChange := OnDioTypeChange;
  DioInfo.OnLoad := OnDioInfoLoad;
  // Создание списка приборов
  //IDioList := LoadDioList(AppDir + DefDioList);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ProgOpt.Free;
end;

procedure TMainForm.SetDioDataDir(const Value: TFileName);
begin
  if DirectoryExists(Value) then
  begin
    EDioDataDir := Value;
    UpdateDioTree;
  end;
end;

procedure TMainForm.UpdateColumns;
var DioFields: TDioFields;
    i: integer;
begin
  DataList.Columns.Clear;
  DioFields := TDioFields.Create(DioType.DioType);
  try
    for i := 0 to DioFields.Count - 1 do
      if DioFields.Item[i].Enabled then
        with DataList.Columns.Add do
        begin
          Caption := DioFields[i].Caption;
          Tag := DioFields[i].FieldIndex;
          Alignment := taCenter;
          if Index = 0 then Width := 60;
        end;
  finally
    DioFields.Free;
  end;
end;

procedure TMainForm.UpdateDioCaption;
var Node: TTreeNode;
begin
  Node := DioTree.Items.GetFirstNode;
  while Node <> nil do
  begin
    DioInfo.FileName := GetNodeInfo(Node).FileName;
    Node.Text := DioInfo.Caption;
    Node := Node.getNextSibling;
  end;
  DioTree.Refresh;
  DioTree.Selected := DioTree.Selected;
end;

procedure TMainForm.UpdateDioTree;
var InfoFiles, DioFiles: TDirectory;
    InfoIndex, DioIndex: integer;
    DioNode, DataNode: TTreeNode;
begin
  DioTree.Items.Clear;
  InfoFiles := TDirectory.Create;
  try
    InfoFiles.Mask := '*.info';
    InfoFiles.Directory := DioDataDir;
    for InfoIndex := 0 to InfoFiles.Count - 1 do
    begin
      DioInfo.FileName := InfoFiles[InfoIndex].FullName;
      DioNode := DioTree.Items.Add(nil,DioInfo.Caption);
      DioNode.ImageIndex := 0;
      DioNode.SelectedIndex := 0;
      SetNodeInfo(DioNode,DioInfo.Number,DioInfo.FileName);
      DioFiles := TDirectory.Create;
      try
        DioFiles.Mask := TFileName(DioInfo.NumberAsStr + '*.d9m');
        DioFiles.Directory := DioDataDir;
        DioData.WorkData := false;
        for DioIndex := 0 to DioFiles.Count - 1 do
        begin
          DioData.FileName := DioFiles[DioIndex].FullName;
          DataNode := DioTree.Items.AddChild(DioNode,DioDateToStr(DioData.CSData.Date));
          SetNodeInfo(DataNode,DioInfo.Number,DioData.FileName);
          DataNode.ImageIndex := Integer(DioData.ArcType);
          DataNode.SelectedIndex := DataNode.ImageIndex;
        end;
        DioData.WorkData := true;
      finally
        DioFiles.Free;
      end;
    end;
  finally
    InfoFiles.Free;
  end;
  DioTree.AlphaSort;
end;

end.
