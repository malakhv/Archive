unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, ExtCtrls, ImgList, DB, ADODB,
  OleServer, ExcelXP, GlRprt, ProgOptionsUnit, ActnList, ActnMan,
  ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    ToolBar: TToolBar;
    TreeView: TTreeView;
    Report: TListView;
    Splitter: TSplitter;
    PopupMenu: TPopupMenu;
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    Images: TImageList;
    ImagesHot: TImageList;
    ImagesDis: TImageList;
    btnDay: TToolButton;
    btnWeek: TToolButton;
    btnMonth: TToolButton;
    btnYear: TToolButton;
    btnYears: TToolButton;
    btnDate: TToolButton;
    btnSep2: TToolButton;
    btnExportTxt: TToolButton;
    btnExportExl: TToolButton;
    ImageList: TImageList;
    MenuOneYear: TPopupMenu;
    mnCurYear: TMenuItem;
    mnSelectYear: TMenuItem;
    btnDateInterval: TToolButton;
    btnExportHTML: TToolButton;
    SaveDialog: TSaveDialog;
    EApp: TExcelApplication;
    btnUpdate: TToolButton;
    ToolButton2: TToolButton;
    FontDialog: TFontDialog;
    ActionManager: TActionManager;
    actExHtml: TAction;
    actExText: TAction;
    actExExcel: TAction;
    actExit: TAction;
    ActionMainMenuBar: TActionMainMenuBar;
    actTree: TAction;
    actFont: TAction;
    actFilterAdd: TAction;
    actFilterDel: TAction;
    actSortName: TAction;
    actSortDoc: TAction;
    actSortPrnt: TAction;
    actSortComp: TAction;
    actSortPage: TAction;
    actSortDateTime: TAction;
    actSortDB: TAction;
    actClearDB: TAction;
    actSQLEditor: TAction;
    actImages: TImageList;
    actToolBarStandart: TAction;
    actInfo: TAction;
    actAbout: TAction;
    procedure FormCreate(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure btnDayClick(Sender: TObject);
    procedure btnWeekClick(Sender: TObject);
    procedure btnMonthClick(Sender: TObject);
    procedure btnYearClick(Sender: TObject);
    procedure btnYearsClick(Sender: TObject);
    procedure btnDateClick(Sender: TObject);
    procedure mnSelectYearClick(Sender: TObject);
    procedure btnExportTxtClick(Sender: TObject);
    procedure btnDateIntervalClick(Sender: TObject);
    procedure btnExportHTMLClick(Sender: TObject);
    procedure ReportColumnClick(Sender: TObject; Column: TListColumn);
    procedure btnExportExlClick(Sender: TObject);
    procedure btnDayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnUpdateClick(Sender: TObject);
    procedure ReportCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ReportMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnAddFilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actTreeExecute(Sender: TObject);
    procedure actFontExecute(Sender: TObject);
    procedure actFilterAddExecute(Sender: TObject);
    procedure actFilterDelExecute(Sender: TObject);
    procedure actSort(Sender: TObject);
    procedure actClearDBExecute(Sender: TObject);
    procedure actSQLEditorExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actToolBarStandartExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
  private
    function Connection: boolean;
    function ExecSQL(SQLStr: string; flag: byte = 0): boolean;
    procedure ClearTreeView;
    procedure CreateUserNode(Parent: TTreeNode; Filter: string = '*');
    procedure CreatePrinterNode(Parent: TTreeNode);
    procedure AddFilterNode;
    procedure AddItem;
    procedure ViewData(Filter: string = '*'; all: boolean = false);
    procedure ViewDay(ADate: TDateTime);
    procedure ViewYear(AYear: word);
    procedure SetRecCount;
    function GetPageSum: integer;
    procedure AddItemCount(APageCount, ADocCount: Integer);
    procedure SetPageSum(Sum: integer);
    procedure StartSort;
    procedure ClearDB;
    procedure ViewSQL(SQL: string);
    procedure BtnFilterDataEnabled(AEnabled: boolean);
  public
    procedure CreateNode;
    procedure UpdateLists;
    function AddFilterToDB(AName,AFilter: string): integer;
    procedure AddFilterToTreeView(AName: string; ID: integer);
    function DeleteFilter(const ID: integer): boolean;
    function GetFilter(const ID: integer): string;
  end;

var
  MainForm: TMainForm;
  CurrentFilter: string;
  Opt: TProgOpt;

implementation

uses StdCtrls, Global, DateUtils, CalendarUnit, YearUnit, RTFUnit,
  DateIntervalUnit, HtmlParamUnit, ExportHTML, ExportExcel, ExlParamUnit,
  ProgressUnit, DstStringUnit, ClearDBUnit, SQLEditorUnit, NewFilterUnit,
  InfoUnit, AboutUnit;

{$R *.dfm}

const
  xlhAl = -4108;
  xlvAl = -4108;

const
  CapStrAr: array[0..4] of string = ('Пользователей: ','Документов: ','Принтеров: ',
    'Компьютеров: ','Страниц: ');

var
  SortColumn: integer = -1;
  srt: ShortInt = 1;
  DrawItem: TListItem = nil;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  Result := 0;
  if (Integer(Item1.Data) = -1) or (Integer(Item2.Data) = -1) then
  begin
    if Integer(Item1.Data) = -1 then Result := -1;
    if Integer(Item2.Data) = -1 then Result := -1;
    if Integer(Item1.Data) = Integer(Item2.Data) then Result := 0;
    Exit;
  end;
  if SortColumn < 0 then
  begin
    if Integer(Item1.Data) = Integer(Item2.Data) then Result := 0;
    if Integer(Item1.Data) > Integer(Item2.Data) then Result := 1;
    if Integer(Item1.Data) < Integer(Item2.Data) then Result := -1;
    Result :=  srt * Result;
    Exit;
  end;
  if SortColumn = 0 then
  begin
    Result := srt * CompareText(Item1.Caption,Item2.Caption);
    Exit;
  end;
  if (SortColumn <> 0) and (SortColumn <> 5) then
  begin
    Result := srt * CompareText(Item1.SubItems.Strings[SortColumn - 1],
      Item2.SubItems.Strings[SortColumn - 1]);
    Exit;
  end;
  Result := srt * CompareDateTime(StrToDateTime(Item1.SubItems.Strings[SortColumn - 1]),
      StrToDateTime(Item2.SubItems.Strings[SortColumn - 1]));
end;

{ TMainForm }

function TMainForm.Connection: boolean;
begin
  Result := true;
  ADOConnection.ConnectionString := ConnectionString + AppDir +'..\' +LimitDBName;
  try
    ADOConnection.Open;
  except
    ShowMessage('Неудалось подключиться к базе данных');
    Result := false;
  end;
end;

function TMainForm.ExecSQL(SQLStr: string; flag: byte): boolean;
begin
  Result := true;
  try
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add(SQLStr);
    case flag of
      0:  ADOQuery.Open;
      1:  ADOQuery.ExecSQL;
    end;
  except
    Result := false;
  end;
end;

procedure TMainForm.ClearTreeView;
var Node: TTreeNode;
begin
  if TreeView.Items.Count = 0 then Exit;
  Node := TreeView.Items.Item[0];
  while Node <> nil do
  begin
    ClearNode(Node);
    Node := Node.GetNext;
  end;
  TreeView.Items.Clear;
  CurrentFilter := '';
  SortColumn := -1;
  srt := 1;
  DrawItem := nil;
end;

procedure TMainForm.CreateUserNode(Parent: TTreeNode; Filter: string = '*');
var Nd: TTreeNode; Inf: TNodeInfo; SQL: string;
begin
  SQL := 'Select distinct Report.UName from Report';
  if Filter <> '*' then
    SQL := SQL + ' where ' + Filter + ' order by Report.UName'
  else SQL := SQL +  ' order by Report.UName';
  if not ExecSQL(SQL) then
    Exit;
  while not ADOQuery.Eof do
  begin
    Nd := TreeView.Items.AddChild(Parent,ADOQuery.FieldByName('UName').AsString);
    Inf.NodeType := ntUser;
    SetNodeInfo(Inf,Nd);
    Nd.ImageIndex    := 0;
    Nd.SelectedIndex := 0;
    ADOQuery.Next;
  end;
end;

procedure TMainForm.CreatePrinterNode(Parent: TTreeNode);
var Nd: TTreeNode; Inf: TNodeInfo;
begin
  if not ExecSQL('Select distinct rp.PName from Report rp order by rp.PName') then
    Exit;
  while not ADOQuery.Eof do
  begin
    Nd := TreeView.Items.AddChild(Parent,ADOQuery.FieldByName('PName').AsString);
    Inf.NodeType := ntPrinter;
    SetNodeInfo(Inf,Nd);
    Nd.ImageIndex    := 2;               
    Nd.SelectedIndex := 2;
    ADOQuery.Next;
  end;
end;

procedure TMainForm.CreateNode;
var Node,PrNode: TTreeNode;
    Info: TNodeInfo;
begin
  ClearTreeView;
  // Все Данные
  Node := TreeView.Items.Add(nil,'Все данные');
  Node.ImageIndex    := -1;
  Node.SelectedIndex := -1;
  Info.NodeType := ntNone;
  SetNodeInfo(Info,Node);
  // Раздел - Принтеры
  PrNode := TreeView.Items.Add(nil,'Принтеры');
  SetNodeInfo(Info,PrNode);
  PrNode.ImageIndex    := 2;
  PrNode.SelectedIndex := 2;
  // Список Принтеров
  CreatePrinterNode(PrNode);
  // Список Пользователей для Принтера
  PrNode := PrNode.getFirstChild;
  while PrNode <> nil do
  begin
    CreateUserNode(PrNode,'Report.PName = '+''''+PrNode.Text+'''');
    PrNode := PrNode.getNextSibling;
  end;
  // Раздел - Пользователи
  PrNode := TreeView.Items.Add(nil,'Пользователи');
  SetNodeInfo(Info,PrNode);
  PrNode.ImageIndex    := 1;
  PrNode.SelectedIndex := 1;
  // Список пользователей
  CreateUserNode(PrNode);
  // Список дополнительных фильтров
  AddFilterNode;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);

  Opt := TProgOpt.Create;
  Opt.LoadFromFile(AppDir + OptFileName);

  Report.Font.Size        := Opt.Options.FontSize;
  Report.Font.Name        := Opt.Options.FontName;
  Report.Font.Color       := Opt.Options.FontColor;
  TreeView.Font.Size      := Opt.Options.FontSize;
  TreeView.Font.Name      := Opt.Options.FontName;
  TreeView.Font.Color     := Opt.Options.FontColor;
  TreeView.Visible        := Opt.Options.TreeState;
  Splitter.Visible        := Opt.Options.TreeState;
  actTree.Checked         := Opt.Options.TreeState;

  StatusBar.Panels.Items[0].Text := RecCountLabel;
  StatusBar.Panels.Items[0].Text := PageCountLabel;
  CurrentFilter := '';
  if Connection then
  begin
    CreateNode;
  end;
end;

procedure TMainForm.AddItem;
var Item: TListItem;
begin
  Item := Report.Items.Add;
  Item.Caption := ADOQuery.FieldByName('UName').AsString;
  Item.SubItems.Add(ADOQuery.FieldByName('Document').AsString);
  Item.SubItems.Add(ADOQuery.FieldByName('PName').AsString);
  Item.SubItems.Add(ADOQuery.FieldByName('Machine').AsString);
  Item.SubItems.Add(IntToStr(ADOQuery.FieldByName('PageCount').AsInteger));
  Item.SubItems.Add(DateTimeToStr(ADOQuery.FieldByName('Date').AsDateTime));
  Item.Data := Pointer(ADOQuery.FieldByName('ID').AsInteger);
end;

procedure TMainForm.ViewData(Filter: string = '*'; all: boolean = false);
var SQL: string;  i: integer; fl: boolean;
begin
  Report.Items.Clear;
  if not all then
  begin
    SQL := 'Select * from Report';
    if Filter <> '*' then SQL := SQL + ' where ' + Filter;
    CurrentFilter := '';
    if Filter <> '*' then CurrentFilter := Filter;

    fl := false;
    for i := 0 to ToolBar.ButtonCount - 1 do
    begin
      if ToolBar.Buttons[i].Down then
      begin
        fl := true;
        break;
      end;
    end;
    if fl then begin ToolBar.Buttons[i].Click; exit; end;
  end else SQL := Filter;

  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
var Info: TNodeInfo; str: string;
begin
  if Node = nil then Exit;
  Info := GetNodeInfo(Node);
  actFilterDel.Enabled := Info.NodeType = ntFilter;
  BtnFilterDataEnabled(Info.NodeType <> ntFilter);
  case Info.NodeType of
    ntNone: begin
              ViewData;
              if (Node.Text = 'Принтеры') and (SortColumn < 0) then
                ReportColumnClick(Report,Report.Columns.Items[2]);
              if (Node.Text = 'Пользователи')  and (SortColumn < 0) then
                ReportColumnClick(Report,Report.Columns.Items[0]);
            end;
    ntUser: begin
              Info := GetNodeInfo(Node.Parent);
              case Info.NodeType of
                ntPrinter:  begin
                              ViewData('Report.UName = ' +''''+ Node.Text +''''+
                                ' and Report.PName = ' +''''+ Node.Parent.Text
                                +'''');
                            end;
                ntNone:     begin
                              ViewData('Report.UName = ' +''''+ Node.Text +'''');
                            end;
              end;
            end;
    ntPrinter:  begin
                  ViewData('Report.PName = ' +''''+ Node.Text +'''');
                  BtnFilterDataEnabled(true);
                end;
    ntFilter:   begin
                  Report.Items.Clear;        
                  if Info.FID <> - 1 then
                  begin
                    str := GetFilter(Info.FID);
                    if str <> '' then ViewSQL(str);
                  end;
                end;
  end;
  StartSort;
end;

procedure TMainForm.ViewDay(ADate: TDateTime);
var SQL: string; dt, dt2: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  dt2 := DateOf(ADate);
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if dt = dt2 then
    begin
      AddItem;
    end;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.ViewYear(AYear: word);
var SQL: string; dt: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if YearOf(dt) = AYear then AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.btnDayClick(Sender: TObject);
var SQL: string; dt, dt2: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  dt2 := DateOf(Now);
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if dt = dt2 then
    begin
      AddItem;
    end;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
  //btnDay.Down := btnDay.Down;
end;

procedure TMainForm.btnWeekClick(Sender: TObject);
var SQL: string; dt: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if (YearOf(dt) = YearOf(Now)) and (WeekOf(dt) = WeekOf(Now)) then AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.btnMonthClick(Sender: TObject);
var SQL: string; dt: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if (YearOf(dt) = YearOf(Now)) and (MonthOf(dt) = MonthOf(Now)) then AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.btnYearClick(Sender: TObject);
var SQL: string; dt: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if YearOf(dt) = YearOf(Now) then AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.btnYearsClick(Sender: TObject);
var SQL: string; dt: TDateTime;
begin
  Report.Items.Clear;
  SQL := 'Select * from Report';
  if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
    if abs(YearOf(dt) - YearOf(Now)) <= 5  then AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
  StartSort;
end;

procedure TMainForm.btnDateClick(Sender: TObject);
var mr: integer;
begin
  mr := mrCancel;
  if not btnDate.Down then mr := CalendarForm.ShowModal;
  if (mr = mrOK)or(btnDate.Down) then
  begin
    ViewDay(CalendarForm.Calendar.Date); 
  end;
end;

procedure TMainForm.mnSelectYearClick(Sender: TObject);
begin
  if YearForm.ShowModal = mrOK then
  begin
    ViewYear(Word(StrToInt(YearForm.YearBox.Items[YearForm.YearBox.ItemIndex])));
  end;
end;

procedure TMainForm.btnExportTxtClick(Sender: TObject);
begin
  RTFForm.CreateReport(Report);
  RTFForm.ShowModal;
end;

procedure TMainForm.SetRecCount;
begin
  StatusBar.Panels.Items[0].Text := RecCountLabel + IntToStr(Report.Items.Count);
end;

function TMainForm.GetPageSum: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to Report.Items.Count - 1 do
  begin
    if Trim(Report.Items.Item[i].SubItems.Strings[3]) <> '' then
      Result := Result + StrToInt(Report.Items.Item[i].SubItems.Strings[3]);
  end;
end;

procedure TMainForm.SetPageSum(Sum: integer);
begin
  StatusBar.Panels.Items[1].Text := PageCountLabel + IntToStr(Sum);
  AddItemCount(Sum, Report.Items.Count);
end;

procedure TMainForm.btnDateIntervalClick(Sender: TObject);
var SQL: string; dt: TDateTime; mr: integer;
begin
  mr := mrCancel;
  if not btnDateInterval.Down then mr := DateIntrvlFrm.ShowModal;
  if (mr = mrOK)or(btnDateInterval.Down) then
  begin
    Report.Items.Clear;
    SQL := 'Select * from Report';
    if CurrentFilter <> '' then SQL := SQL + ' where ' + CurrentFilter;
    if not ExecSQL(SQL) then Exit;
    while not ADOQuery.Eof do
    begin
      dt := DateOf(ADOQuery.FieldByName('Date').AsDateTime);
      if (dt >= DateOf(DateIntrvlFrm.DTP1.Date)) and
         (dt <= DateOf(DateIntrvlFrm.DTP2.Date)) then
      begin
        AddItem;
      end;
      ADOQuery.Next;
    end;
    SetRecCount;
    SetPageSum(GetPageSum);
  end;
end;

procedure TMainForm.btnExportHTMLClick(Sender: TObject);
var HtmlReport: TStringList;
    Head: THTMLHead; Table: THTMLTable; Fnt: THTMLFont;
    i: integer;
begin
  if HtmlParamForm.ShowModal = mrOK then
  begin
    HtmlReport := TStringList.Create;
    HtmlReport.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//RU">');
    HtmlReport.Add('<html>');
    HtmlReport.Add('  <head>');
    HtmlReport.Add('    <title>'+ HtmlParamForm.HeadEdit.Text +'</title>');
    HtmlReport.Add('  </head>');
    HtmlReport.Add('<body>');
    HtmlReport.Add('');
    // Заголовок
    Head := THTMLHead.Create;
    Head.Text := HtmlParamForm.HeadEdit.Text;
    case HtmlParamForm.AlignBox.ItemIndex of
      0: Head.Align := haCenter;
      1: Head.Align := haLeft;
      2: Head.Align := haRight;
    end;
    Fnt := THTMLFont.Create;
    Fnt.Color := HtmlParamForm.HeadColor.Selected;
    Fnt.Text := Head.HeadTag;
    HtmlReport.Add(Fnt.FontTag);
    // Таблица
    Table := THTMLTable.Create;
    Table.Color := HtmlParamForm.TableBgColor.Selected;
    Table.Border := HtmlParamForm.TableBorder.Value;
    case HtmlParamForm.TableAlBox.ItemIndex of
      0: Table.Align := haCenter;
      1: Table.Align := haLeft;
      2: Table.Align := haRight;
    end;
    Table.LoadFromListView(Report);
    Table.TRItems.TRItem[0].Align := haCenter;
    Table.TRItems.TRItem[0].Color := HtmlParamForm.TableHeadColor.Selected;
    // Столбец "Стриниц" - по левому краю
    for i := 1 to Table.TRItems.Count - 1 do
    begin
      Table.TRItems.TRItem[i].TDItems.TDItem[4].Align := haRight;
    end;
    HtmlReport.AddStrings(Table.TableTag);
    // Конец Документа
    HtmlReport.Add('');
    HtmlReport.Add('</body>');
    HtmlReport.Add('</html>');
    HtmlReport.SaveToFile(HtmlParamForm.SaveDialog.FileName);

    HtmlReport.Free;
    Fnt.Free;
    Head.Free;
    Table.Free;
  end;
end;

procedure TMainForm.ReportColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if SortColumn <> -2 then
  begin
    if SortColumn = Column.Index then srt := -1 * srt
    else srt := 1;
  end;
  if Column <> nil then
    SortColumn := Column.Index;
  Report.CustomSort(@CustomSortProc,0);
end;                  

procedure TMainForm.btnExportExlClick(Sender: TObject);
const t = 4; l = 1;
var i,j: integer;
begin
  if ExlParamForm.ShowModal = mrOK then
  begin
    ProgressForm.Gauge.Progress := 0;
    ProgressForm.Gauge.MaxValue := Report.Items.Count + 10;
    ProgressForm.lblPr.Caption := 'Соединение с сервером автоматизации...';
    ProgressForm.Show;
    Application.ProcessMessages;

    EApp.Connect;

    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
    ProgressForm.lblPr.Caption := 'Создание рабочей книги...';
    Application.ProcessMessages;
    EApp.Workbooks.Add(Null,0);
    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
    ProgressForm.lblPr.Caption := 'Генерация заголовка отчета...';
    Application.ProcessMessages;
    // Заголовок
    if Trim(ExlParamForm.HeadEdit.Text) <> '' then
    begin
      EApp.Range[EApp.Cells.Item[t-2,l],
        EApp.Cells.Item[t-2,(Report.Columns.Count -1) + l ]].MergeCells := true;
      EApp.Range[EApp.Cells.Item[t-2,l],
        EApp.Cells.Item[t-2,(Report.Columns.Count - 1) + l ]].HorizontalAlignment := xlhAl;
      EApp.Cells.Item[t-2,l].Value := ExlParamForm.HeadEdit.Text;
      EApp.Cells.Item[t-2,l].Font.Size := ExlParamForm.FontSize.Value;
      EApp.Cells.Item[t-2,l].Font.Bold := true;
      EApp.Cells.Item[t-2,l].Font.Color := ExlParamForm.HeadColor.Selected;
    end;

    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
    ProgressForm.lblPr.Caption := 'Создание заголовков таблици...';
    Application.ProcessMessages;

    for i := 0 to Report.Columns.Count - 1 do
    begin
      EApp.Cells.Item[t,i+l].Value := Report.Columns.Items[i].Caption;
      EApp.Cells.Item[t,i+l].HorizontalAlignment := xlhAl;
      EApp.Cells.Item[t,i+l].Font.Bold := true;
      EApp.Cells.Item[t,i+l].Borders.LineStyle := xlContinuous;
    end;

    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
    ProgressForm.lblPr.Caption := 'Настройка столбцов...';
    Application.ProcessMessages;

    EApp.Cells.Item[t,l].ColumnWidth := 16;
    EApp.Cells.Item[t,l+1].ColumnWidth := 35;
    EApp.Cells.Item[t,l+2].ColumnWidth := 35;
    EApp.Cells.Item[t,l+3].ColumnWidth := 14;
    EApp.Cells.Item[t,l+4].ColumnWidth := 13;
    EApp.Cells.Item[t,l+5].ColumnWidth := 15;

    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
    ProgressForm.lblPr.Caption := 'Экспорт данных...';
    Application.ProcessMessages;

    for i := 0 to Report.Items.Count - 1 do
    begin
      //if Integer(Report.Items.Item[i].Data) = -1 then
      if Report.Items.Item[i].Caption = ' ' then
      begin
        continue;
      end;
      EApp.Cells.Item[i+(t+1),l].Value := Report.Items.Item[i].Caption;
      EApp.Cells.Item[i+(t+1),l].Borders.LineStyle := xlContinuous;
      for j := 0 to Report.Items.Item[i].SubItems.Count - 1 do
      begin
        case j of
          0:  begin
                EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
                  Report.Items.Item[i].SubItems.Strings[j];
              end;
          3:  begin
                if Integer(Report.Items.Item[i].Data) <> -1 then
                  EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
                    StrToInt(Report.Items.Item[i].SubItems.Strings[j])
                else
                  EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
                    Report.Items.Item[i].SubItems.Strings[j];
              end;
          4:  begin
                if Integer(Report.Items.Item[i].Data) <> -1 then
                  EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
                    StrToDateTime(Report.Items.Item[i].SubItems.Strings[j])
                  else
                    EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
                      Report.Items.Item[i].SubItems.Strings[j];
              end;
          else begin
            EApp.Cells.Item[i+(t+1),j+(l+1)].Value :=
              Report.Items.Item[i].SubItems.Strings[j];
          end;
        end;
        EApp.Cells.Item[i+(t+1),j+(l+1)].Borders.LineStyle := xlContinuous;
      end;
      ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 1;
      Application.ProcessMessages;
    end;
    ProgressForm.Gauge.Progress := ProgressForm.Gauge.Progress + 5;
    ProgressForm.lblPr.Caption := 'Запуск приложения...';
    Application.ProcessMessages;
    EApp.Visible[0] := true;
    EApp.Disconnect;
    ProgressForm.Close;
  end;
end;

procedure TMainForm.StartSort;
var clmn: integer;
begin
  if SortColumn > 0 then
  begin
    clmn := SortColumn;
    SortColumn := -2;
    ReportColumnClick(nil,Report.Columns.Items[clmn]);
  end;
end;

procedure TMainForm.btnDayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
  if Button = mbRight then
  begin
    (Sender as TToolButton).Down := not (Sender as TToolButton).Down;
    if (Sender as TToolButton).Down then
      (Sender as TToolButton).Click
    else btnUpdate.Click;
    for i := 0 to ToolBar.ButtonCount - 1 do
    begin
      if (ToolBar.Buttons[i] <> (Sender as TToolButton)) then
        if ToolBar.Buttons[i].Down then ToolBar.Buttons[i].Down := false;
    end;
  end;
  if Button = mbLeft then
  begin
    for i := 0 to ToolBar.ButtonCount - 1 do
    begin
      if (ToolBar.Buttons[i] <> (Sender as TToolButton)) then
        if ToolBar.Buttons[i].Down then ToolBar.Buttons[i].Down := false;
    end;
  end;
end;

procedure TMainForm.btnUpdateClick(Sender: TObject);
begin
  if TreeView.Selected <> nil then
  begin
    TreeViewChange(Sender, TreeView.Selected);
  end;
end;

procedure TMainForm.AddItemCount(APageCount, ADocCount: Integer);
var item: TListItem; i,j,c: integer;
  Lst: TDisStringList;
begin
  if Report.Items.Count <> 0 then
  begin
    c := Report.Items.Count;
    // пустая строка
    item := Report.Items.Add;
    item.Caption := ' ';
    item.Data := Pointer(-1);
    for i := 0 to 4 do item.SubItems.Add(' ');
    // Строка Итого
    item := Report.Items.Add;
    item.Data := Pointer(-1);
    item.Caption := 'Итого: ' ;
    for i := 0 to 4 do item.SubItems.Add(' ');

    Lst := TDisStringList.Create;
    item := Report.Items.Add;
    item.Data := Pointer(-1);
    for i := 0 to Report.Columns.Count - 1 do
    begin
      Lst.Clear;
      // Заполняем Lst
      case i of
        0,2,3:  begin
                    for j := 0 to c - 1 do
                    begin
                      if i <> 0 then
                        Lst.Add(Report.Items.Item[j].SubItems.Strings[i-1])
                      else Lst.Add(Report.Items.Item[j].Caption);
                    end;
                    if i <> 0 then
                      item.SubItems.Add(CapStrAr[i] + IntToStr(Lst.DisCount))
                    else
                      item.Caption := CapStrAr[i] + IntToStr(Lst.DisCount);
                  end;
        1:        begin
                    item.SubItems.Add(CapStrAr[i] + IntToStr(ADocCount));
                  end;
        4:        begin
                    item.SubItems.Add(CapStrAr[i] + IntToStr(APageCount));
                  end;
        5:        begin
                    item.SubItems.Add(' ');
                  end;
      end;
    end;
    Lst.Free;
  end;
end;

procedure TMainForm.ClearDB;
begin
  if ExecSQL('Delete * from Report',1) then ShowMessage('БД усешно очищена')
  else ShowMessage('Ошибка при очистке БД');
  btnUpdateClick(nil);
end;

procedure TMainForm.ViewSQL(SQL: string);
var i: integer;
begin
  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    if ToolBar.Buttons[i].Down then ToolBar.Buttons[i].Down := false;
  end;
  CurrentFilter := '';
  Report.Items.Clear;
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    AddItem;
    ADOQuery.Next;
  end;
  SetRecCount;
  SetPageSum(GetPageSum);
end;

procedure TMainForm.ReportCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with Sender as TCustomListView do
  begin
    if Integer(Item.Data) = -1 then
    begin
      Canvas.Font.Style := [fsBold];
    end;
    if Item.Index mod 2 = 0 then
      Canvas.Brush.Color := clCream;
    if Item = DrawItem then
      Canvas.Brush.Color := clSkyBlue;
  end;
end;

procedure TMainForm.ReportMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {if Button = mbRight then
  begin
    if DrawItem = Report.ItemFocused then DrawItem := nil;
    Report.Repaint;
  end;}
end;

procedure TMainForm.BtnFilterDataEnabled(AEnabled: boolean);
var i: integer;
begin
  for i := 0 to  6 do
  begin
    if ToolBar.Buttons[i].Enabled <> AEnabled then
      ToolBar.Buttons[i].Enabled := AEnabled;
  end;
end;

procedure TMainForm.UpdateLists;
  procedure LoadList(FName: string; Sender: TObject);
  var SQL: string;
  begin
    (Sender as TListBox).Clear;
    SQL := 'Select distinct Report.'+FName+' from Report order by Report.' +
      FName;
    if not ExecSQL(SQL) then Exit;
    while not ADOQuery.Eof do
    begin
      (Sender as TListBox).Items.Add(ADOQuery.FieldByName(FName).AsString);
      ADOQuery.Next;
    end;
  end;
begin
  LoadList('UName',NewFilterForm.UserList);
  LoadList('PName',NewFilterForm.PrList);
  LoadList('Machine',NewFilterForm.CompList);
end;

procedure TMainForm.mnAddFilterClick(Sender: TObject);
begin

end;

//---------------FILTER---------------------------------------------------------

procedure TMainForm.AddFilterNode;
begin
  if not ExecSQL('Select * from Filters') then Exit;
  while not ADOQuery.Eof do
  begin
    AddFilterToTreeView(ADOQuery.FieldByName('Name').AsString,
      ADOQuery.FieldByName('ID').AsInteger);
    ADOQuery.Next;
  end;
end;

function TMainForm.AddFilterToDB(AName, AFilter: string): integer;
begin
  Result := -1;
  if not ExecSQL('Select * from Filters') then Exit;
  ADOQuery.Append;
  ADOQuery.FieldByName('Name').AsString := Trim(AName);
  ADOQuery.FieldByName('Filter').AsString := AFilter;
  ADOQuery.Post;
  Result := ADOQuery.FieldByName('ID').AsInteger;
end;

function TMainForm.DeleteFilter(const ID: integer): boolean;
begin
  Result := ExecSQL('Delete from Filters where Filters.ID = '+IntToStr(ID),1);
end;

function TMainForm.GetFilter(const ID: integer): string;
begin
  Result := '';
  if not ExecSQL('Select * from Filters where Filters.ID = '+IntToStr(ID)) then
    Exit;
  if not ADOQuery.Eof then
    Result := ADOQuery.FieldByName('Filter').AsString;
end;

procedure TMainForm.AddFilterToTreeView(AName: string; ID: integer);
var nd: TTreeNode; Inf: TNodeInfo;
begin
  if ID < 0 then Exit;
  nd := TreeView.Items.Add(nil,AName);
  nd.ImageIndex := 4;
  nd.SelectedIndex := 4;
  inf.NodeType := ntFilter;
  inf.FID := ID;
  SetNodeInfo(Inf,Nd);
end;

//------------------------------------------------------------------------------

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Opt.Options.TreeState := TreeView.Visible;
  Opt.Options.FontSize  := Report.Font.Size;
  Opt.Options.FontName  := Report.Font.Name;
  Opt.Options.FontColor := Report.Font.Color;
  Opt.SaveToFile(AppDir + OptFileName);
  Opt.Free;
  ADOConnection.Close;
end;

procedure TMainForm.actTreeExecute(Sender: TObject);
begin
  TreeView.Visible := actTree.Checked;
  Splitter.Visible := actTree.Checked;
  Splitter.Left := TreeView.Width + 2;
  Splitter.Align := alLeft;
end;

procedure TMainForm.actFontExecute(Sender: TObject);
begin
  if FontDialog.Execute then
  begin
    Report.Font.Name    := FontDialog.Font.Name;
    Report.Font.Size    := FontDialog.Font.Size;
    Report.Font.Color   := FontDialog.Font.Color;
    TreeView.Font.Name  := FontDialog.Font.Name;
    TreeView.Font.Size  := FontDialog.Font.Size;
    TreeView.Font.Color := FontDialog.Font.Color;
  end;
end;

procedure TMainForm.actFilterAddExecute(Sender: TObject);
begin
  if NewFilterForm.ShowModal = mrOk then
  begin
    AddFilterToTreeView(NewFilterForm.FNameEdit.Text,
      AddFilterToDB(NewFilterForm.FNameEdit.Text,NewFilterUnit.NewFilter));
  end;
end;

procedure TMainForm.actFilterDelExecute(Sender: TObject);
var inf: TNodeInfo;
begin
  if TreeView.Selected <> nil then
  begin
    inf := GetNodeInfo(TreeView.Selected);
    if inf.NodeType = ntFilter then
      if DeleteFilter(inf.FID) then
      begin
        ClearNode(TreeView.Selected);
        TreeView.Items.Delete(TreeView.Selected);
      end;
  end;
end;

procedure TMainForm.actSort(Sender: TObject);
begin
  if (Sender as TAction).Tag > 0 then
    ReportColumnClick(Sender,Report.Columns.Items[(Sender as TAction).Tag])
  else begin
    SortColumn := -2;
    ReportColumnClick(Sender,nil);
  end;
end;

procedure TMainForm.actClearDBExecute(Sender: TObject);
begin
  if ClearDBForm.ShowModal = mrOK then
  begin
    ClearDB;
  end;
end;

procedure TMainForm.actSQLEditorExecute(Sender: TObject);
begin
  if SQLEditorForm.ShowModal = mrOk then
  begin
    if OpCode = 0 then
      ViewSQL(SQLEditorForm.SQLEditor.Text);
    if OpCode = 1 then
      ExecSQL(SQLEditorForm.SQLEditor.Text,1);
  end;
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.actToolBarStandartExecute(Sender: TObject);
begin
  ToolBar.Visible := actToolBarStandart.Checked;
end;

procedure TMainForm.actInfoExecute(Sender: TObject);
begin
  InfoForm.ShowModal;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutBox.ShowModal;  
end;

end.
