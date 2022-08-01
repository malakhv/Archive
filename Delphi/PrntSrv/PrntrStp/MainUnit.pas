unit MainUnit;
                  
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, CheckedScrollBox, ExtCtrls, Buttons,
  DB, ADODB, ComCtrls, Printers,ImgList, ActnList, ToolWin, ActnMan,
  ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    MList: TListView;
    CheckMenu: TPopupMenu;
    mnChckDel: TMenuItem;
    N1: TMenuItem;
    mnPrntInfo: TMenuItem;
    ImageList: TImageList;
    StatusBar1: TStatusBar;
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    actAddPrnt: TAction;
    actExit: TAction;
    actSelAll: TAction;
    actUnSelAll: TAction;
    actCurComp: TAction;
    actListComp: TAction;
    actInfo: TAction;
    actAbout: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnChckDelClick(Sender: TObject);
    procedure MListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actAddPrntExecute(Sender: TObject);
    procedure actCurCompExecute(Sender: TObject);
    procedure actSelAllExecute(Sender: TObject);
    procedure actUnSelAllExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure mnPrntInfoClick(Sender: TObject);

  private
    function Connection: boolean;
    function ExecSQL(SQLStr: string; flag: byte = 0): boolean;
    procedure LoadPrinter(Machine: string = '*');
    procedure LoadMachineList;
    procedure LoadPrinterList;
    procedure UpdatePrinterInfo(const ID: Integer; const Run: boolean);
    procedure UpdateDB;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  PrinterList: TCheckedScrollBox;
  AppDir: TFileName;

implementation

uses Global, AddPrinter, MNameUnit, AboutUnit, InfoUnit, PInfUnit;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);
  PrinterList := TCheckedScrollBox.Create(Self);
  PrinterList.Parent := self;
  PrinterList.Align := alClient;
  PrinterList.Color := clWindow;
  PrinterList.CheckColor := clWindow;
  PrinterList.Font := MList.Font;
  PrinterList.BorderStyle := bsNone;
  PrinterList.BevelKind := bkSoft;
  PrinterList.Visible := true;
  if Connection then
  begin
    LoadMachineList;
    LoadPrinter;
  end;
end;

function TMainForm.Connection: boolean;
begin
  Result := true;
  ADOConnection.ConnectionString := ConnectionString +AppDir+'..\'+LimitDBName;
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
  end
end;

procedure TMainForm.LoadPrinter(Machine: string = '*');
var SQL: string;
begin
  PrinterList.Clear;
  if Machine <> '*' then
  SQL := 'Select pr.ID, pr.PName, pr.Run from AllPrinters pr,' +
    ' PServer ps where pr.SID = ps.ID and ps.Name =' + ''''+Machine+''''
  else SQL := 'Select * from AllPrinters';

  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    PrinterList.Add(ADOQuery.FieldByName('PName').AsString,CheckMenu,
      ADOQuery.FieldByName('ID').AsInteger,ADOQuery.FieldByName('Run').AsBoolean);
    ADOQuery.Next;
  end;
end;

procedure TMainForm.UpdateDB;
var i: integer;
begin
  if not ADOConnection.Connected then Exit;
  for i := 0 to Length(PrinterList.Items) - 1 do
  begin
    UpdatePrinterInfo(PrinterList.Items[i].Tag,PrinterList.Items[i].Checked);
  end;
end;

procedure TMainForm.UpdatePrinterInfo(const ID: Integer; const Run: boolean);
var SQL: string;
begin
  SQL := 'Select * from AllPrinters allP where allP.ID = ' + IntToStr(ID);
  if not ExecSQL(SQL) then Exit;
  if ADOQuery.Eof then Exit;
  ADOQuery.Edit;
    ADOQuery.FieldByName('Run').AsBoolean := Run;
  ADOQuery.Post;
end;

procedure TMainForm.LoadMachineList;
var SQL: string; item: TListItem;
begin
  MList.Items.Clear;
  SQL := 'Select * from PServer order by PServer.Name';
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    Item := MList.Items.Add;
    Item.Caption := ADOQuery.FieldByName('Name').AsString;
    Item.Data := Pointer(ADOQuery.FieldByName('ID').AsInteger);
    Item.ImageIndex := 3;
    ADOQuery.Next;
  end
end;

procedure TMainForm.MListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  UpdateDB;
  PrinterList.Clear;
  if Selected then
  begin
    LoadPrinter(Item.Caption);
  end;
end;

procedure TMainForm.mnChckDelClick(Sender: TObject);
var SQL: string;
begin
  SQL := 'delete from AllPrinters allp where allp.ID = '+
    IntToStr(PrinterList.Selected.Tag);
  ExecSQL(SQL,1);
  if MList.Selected <> nil then
    LoadPrinter(MList.Selected.Caption)
  else LoadPrinter;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UpdateDB;
end;

procedure TMainForm.LoadPrinterList;
var i: integer; Item: TListItem;
begin
  AddPrinterForm.PList.Items.Clear; 
  for i := 0 to Printer.Printers.Count - 1 do
  begin
    Item := AddPrinterForm.PList.Items.Add;
    Item.Caption := Printer.Printers[i];
  end;
end;

procedure TMainForm.actAddPrntExecute(Sender: TObject);
var SQL: string; SID: integer;
begin
  LoadPrinterList;
  if AddPrinterForm.ShowModal = mrOk then
  begin
    SQL := 'Select allp.PName from AllPrinters allp, PServer ps' +
      ' where allp.PName = '+ ''''+ AddPrinterForm.PList.Selected.Caption +
      ''''+' and allp.SID = ps.ID and ps.Name = '+ '''' + MachineName + '''';
    if not ExecSQL(SQL) then Exit;
    if not ADOQuery.Eof then
    begin
      ShowMessage('Невозможно добавить принтер.Информация о выбранном принтере уже есть в базе данных.');
      Exit;
    end;

    //добавляем имя компа в бд, если нету его там
    SQL := 'Select * from PServer ps where ps.Name = '+ '''' + MachineName + '''';
    if not ExecSQL(SQL) then Exit;
    if ADOQuery.Eof then
    begin
      ADOQuery.Append;
      ADOQuery.FieldByName('Name').AsString := MachineName;
      ADOQuery.Post;
      SID := ADOQuery.FieldByName('ID').AsInteger;
    end else SID := ADOQuery.FieldByName('ID').AsInteger;


    SQL := 'Select * from AllPrinters';
    if not ExecSQL(SQL) then Exit;
    ADOQuery.Append;
      ADOQuery.FieldByName('PName').AsString := AddPrinterForm.PList.Selected.Caption;
      ADOQuery.FieldByName('SID').AsInteger := SID;
      ADOQuery.FieldByName('TotalPage').AsInteger := 0;
      ADOQuery.FieldByName('Info').AsString := '';
      ADOQuery.FieldByName('Run').AsBoolean := false;
    ADOQuery.Post;
    LoadMachineList;
    LoadPrinter;
  end;
end;

procedure TMainForm.actCurCompExecute(Sender: TObject);
begin
  if (Sender as TAction).Checked then Exit;
  UpdateDB;
  if Sender = actListComp then
  begin
    actListComp.Checked := true;
    actCurComp.Checked  := false;
    MList.Visible := true;
    LoadMachineList;
    LoadPrinter;
  end;
  if Sender = actCurComp then
  begin
    actListComp.Checked := false;
    actCurComp.Checked  := true;
    MList.Visible := false;
    LoadPrinter(MachineName);
  end;
end;

procedure TMainForm.actSelAllExecute(Sender: TObject);
begin
  PrinterList.SetCheckedAll(true);
end;

procedure TMainForm.actUnSelAllExecute(Sender: TObject);
begin
  PrinterList.SetCheckedAll(false);
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actInfoExecute(Sender: TObject);
begin
  InfoForm.ShowModal;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.mnPrntInfoClick(Sender: TObject);
var SQL: string;
begin
  SQL := 'Select * from AllPrinters allp where allp.ID = '+
    IntToStr(PrinterList.Selected.Tag);
  if not ExecSQL(SQL) then Exit;
  if ADOQuery.Eof then
  begin
    ShowMessage('Принтер не найден в базе данных.');
    Exit;
  end;

  PInfoForm.Info.Lines.Text := ADOQuery.FieldByName('Info').AsString;

  if PInfoForm.ShowModal = mrOk then
  begin
    ADOQuery.Edit;
    ADOQuery.FieldByName('Info').AsString := PInfoForm.Info.Lines.Text;
    ADOQuery.Post;
  end;

end;

end.
