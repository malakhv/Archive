unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, DB, ADODB, ImgList, StdCtrls, Spin, Buttons,
  Menus, ToolWin, ActnList, ActnMan, ActnCtrls, ActnMenus, XPStyleActnCtrls;

type
  TMainForm = class(TForm)
    ADOConnection: TADOConnection;
    ADOQuery: TADOQuery;
    TreeImages: TImageList;
    StatusBar: TStatusBar;
    PopupMenu: TPopupMenu;
    mnDel: TMenuItem;
    N1: TMenuItem;
    mnAddLimit: TMenuItem;
    TreeView: TTreeView;
    UserPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    btnDelAllLimits: TSpeedButton;
    edUserName: TEdit;
    LimitPanel: TPanel;
    PgCountBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    chPageLimit: TCheckBox;
    PageLimit: TSpinEdit;
    Printed: TStaticText;
    TimeBox: TGroupBox;
    btnAddTime: TSpeedButton;
    btnDelTime: TSpeedButton;
    chTime: TCheckBox;
    Intervals: TListView;
    PrinterBox: TGroupBox;
    lblPrinter: TLabel;
    lblComp: TLabel;
    ToolBar: TToolBar;
    btnNewUser: TToolButton;
    btnDelUser: TToolButton;
    Info: TMemo;
    ToolButton1: TToolButton;
    btnNewLimit: TToolButton;
    btnDelLimit: TToolButton;
    BtnImages: TImageList;
    BtnImagesHot: TImageList;
    BtnImagesDis: TImageList;
    ActionManager: TActionManager;
    ActionMainMenuBar: TActionMainMenuBar;
    actExit: TAction;
    actAddLimit: TAction;
    actAddUser: TAction;
    actDelete: TAction;
    actAdd: TAction;
    actInfo: TAction;
    actAbout: TAction;
    procedure FormCreate(Sender: TObject);
    procedure chPageLimitClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure btnAddTimeClick(Sender: TObject);
    procedure btnDelTimeClick(Sender: TObject);
    procedure edUserNameChange(Sender: TObject);
    procedure InfoChange(Sender: TObject);
    procedure PageLimitChange(Sender: TObject);
    procedure chTimeClick(Sender: TObject);
    procedure IntervalsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btnDelAllLimitsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelUserClick(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actAddLimitExecute(Sender: TObject);
    procedure actAddUserExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure btnDelLimitClick(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
  private
    function ExecSQL(SQLStr: string; flag: byte = 0): boolean;
    function Connection: boolean;
    procedure LoadUser;
    function LoadLimitInfo(ID: integer): boolean;
    procedure LoadIntervals(LimitID: integer);
    function SaveLimitInfo(ID: integer): byte;
    function DeleteLimit(ID: integer): boolean;

    function AddInterval(LimitID: Integer; T1,T2: TDateTime): integer;
    procedure DelInterval(const ID: integer);
    procedure DelAllInterval(const LimitID: integer);
    procedure DeleteAllLimits(const UserID: integer);
    procedure DeleteUser(ID: integer);
    procedure LoadUserInfo(ID: integer);
    function  SaveUserInfo(ID: integer): string;
    procedure LoadBox(CompoBox: TComboBox; Field: string);
    procedure LoadPrinterBox;
    procedure LoadUserBox(ID: integer = -1);
    procedure SetBtnEnabled;
    procedure ClearInfo;
  
  public

  end;

var
  MainForm: TMainForm;
  CurNode: TTreeNode;

implementation

uses Global, EditTime, GlLimits, AddUser, AddLimit, AboutUnit, InfoUnit;

{$R *.dfm}

var
  LimitInfoChange, UserInfoChange: boolean;

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

function TMainForm.Connection: boolean;
begin
  Result := true;
  ADOConnection.ConnectionString := ConnectionString + AppDir + '..\' +LimitDBName;
  try
    ADOConnection.Open;
  except
    ShowMessage('Неудалось подключиться к базе данных');
    Result := false;
  end;
end;

procedure TMainForm.LoadUser;
var SQL: string;
    Node, CrNode: TTreeNode;
begin
  TreeView.Selected := nil;
  CurNode := nil; 
  TreeView.Items.Clear;
  if not ADOConnection.Connected then Exit;
  SQL := 'Select * from Users order by Users.Name';
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    Node := TreeView.Items.Add(nil,ADOQuery.FieldByName('Name').AsString);
    Node.Data := Pointer(ADOQuery.FieldByName('ID').AsInteger);
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
    ADOQuery.Next;
  end;

  if TreeView.Items.Count = 0 then Exit;
  CrNode := TreeView.Items.Item[0];
  if CrNode = nil then Exit;

  while CrNode <> nil do
  begin
    SQL := 'Select * from Limits where Limits.UserID = '
      + IntToStr(Integer(CrNode.Data));
    if not ExecSQL(SQL) then Continue;
    while not ADOQuery.Eof do
    begin
      Node := TreeView.Items.AddChild(CrNode,'Не определен');
      case ADOQuery.FieldByName('Type').AsInteger  of
        1: Node.Text := LimitType1;
        2: Node.Text := LimitType2;
        3: Node.Text := LimitType3;
      else
        Node.Text := LimitType0;
      end;
      Node.Data := Pointer(ADOQuery.FieldByName('ID').AsInteger);
      Node.ImageIndex := 1;
      Node.SelectedIndex := 1;
      ADOQuery.Next;
    end;
    CrNode := CrNode.getNextSibling;
  end;
  UserInfoChange := false;
  LimitInfoChange := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);
  Self.ClientHeight := minFormClientH;
  Self.ClientWidth  := minFormClientW;
  CurNode := nil;
  LimitInfoChange := false;
  UserInfoChange  := false;
  LoadDefOptions;
  if Connection then
  begin
    LoadUser;
  end;
end;

procedure TMainForm.chPageLimitClick(Sender: TObject);
begin
  PageLimit.Enabled := (Sender as TCheckBox).Checked;
  LimitInfoChange := true;
end;

function TMainForm.LoadLimitInfo(ID: integer): boolean;
var SQL, pname, mname: string;
begin
  Result := false;
  Intervals.Items.Clear;
  SQL := 'Select * from Limits where Limits.ID = ' + IntToStr(ID);
  if not ExecSQL(SQL) then Exit;
  if ADOQuery.Eof then Exit;
  chPageLimit.Checked := (ADOQuery.FieldByName('Type').AsInteger = 1) or
    (ADOQuery.FieldByName('Type').AsInteger = 3);
  PageLimit.Value := ADOQuery.FieldByName('PageLimit').AsInteger;
  Printed.Caption := IntToStr(ADOQuery.FieldByName('PagePrinted').AsInteger);

  chTime.Checked := (ADOQuery.FieldByName('Type').AsInteger = 2) or
    (ADOQuery.FieldByName('Type').AsInteger = 3);
  if chTime.Checked then
  begin
    LoadIntervals(ID);
  end;

  SQL := 'Select p.PName, ps.Name from AllPrinters p, PServer ps, Limits l ' +
    ' where p.ID = l.PID and ps.ID = p.SID and l.ID = ' + IntToStr(ID);
  pname := 'No Printer';
  mname := 'No Data';
  if ExecSQL(SQL) then
  begin
    if not ADOQuery.Eof then
    begin
       pname := ADOQuery.FieldByName('PName').AsString;
       mname := ADOQuery.FieldByName('Name').AsString;
    end;
  end;
  lblPrinter.Caption := pname;
  lblComp.Caption    := mname;
  LimitInfoChange := false;
  Result := true;
end;

procedure TMainForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if CurNode <> nil then
  begin
    case CurNode.Level of
      0:  begin
            if UserInfoChange then
              CurNode.Text := SaveUserInfo(Integer(CurNode.Data))
          end;
      1:  begin
            if LimitInfoChange then
            begin
              case SaveLimitInfo(Integer(CurNode.Data)) of
                1: CurNode.Text := LimitType1;
                2: CurNode.Text := LimitType2;
                3: CurNode.Text := LimitType3;
              else
                CurNode.Text := LimitType0;
              end;
            end;
          end;
    end;
  end;

  CurNode := Node;
  SetBtnEnabled;
  if Node = nil then Exit;

  LimitPanel.Visible := Node.Level = 1;
  UserPanel.Visible  := Node.Level = 0;
  mnDel.Enabled := Node <> nil;

  if Node.Level = 0 then
  begin
    LoadUserInfo(Integer(Node.Data));
  end;

  if Node.Level = 1 then
  begin
    LoadLimitInfo(Integer(Node.Data));
  end;
end;

function TMainForm.SaveLimitInfo(ID: integer): byte;
var SQL: string; LType: integer;
begin
  Result := 0;
  SQL := 'select * from Limits where Limits.ID = ' + IntToStr(ID);
  if not ExecSQL(SQL) then Exit;
  if ADOQuery.Eof then Exit;
  ADOQuery.Edit;
    LType := 0;
    if chPageLimit.Checked then
    begin
      LType := 1;
      ADOQuery.FieldByName('PageLimit').AsInteger := PageLimit.Value;
    end;
    if chTime.Checked then
    begin
      Inc(LType,2);
    end;
  ADOQuery.FieldByName('Type').AsInteger := LType;
  ADOQuery.Post;
  if LType = 1 then DelAllInterval(ID);

  LimitInfoChange := false;
  Result := byte(LType);
end;

procedure TMainForm.btnAddTimeClick(Sender: TObject);
begin
  if TimeForm.ShowModal = mrOK then
  begin
    AddInterval(Integer(TreeView.Selected.Data),TimeForm.dpT1.Time,
      TimeForm.dpT2.Time);
    LoadIntervals(Integer(TreeView.Selected.Data));
    chTime.Checked := true;
    LimitInfoChange := true;
  end;
end;

procedure TMainForm.btnDelTimeClick(Sender: TObject);
begin
  if Intervals.Selected <> nil then
  begin
    DelInterval(Integer(Intervals.Selected.Data));
    Intervals.Items.Delete(Intervals.Selected.Index);
    LimitInfoChange := true;
  end;
end;

function TMainForm.AddInterval(LimitID: Integer; T1,
  T2: TDateTime): integer;
var SQL: string;
begin
  Result := -1;
  SQL := 'Select * from [Interval]';
  if not ExecSQL(SQL) then Exit;
  ADOQuery.Append;
  ADOQuery.FieldByName('LimitID').AsInteger := LimitID;
  ADOQuery.FieldByName('T1').AsDateTime := T1;
  ADOQuery.FieldByName('T2').AsDateTime := T2;
  Result := ADOQuery.FieldByName('ID').AsInteger;
  ADOQuery.Post;
end;

procedure TMainForm.DelInterval(const ID: integer);
var SQL: string;
begin
  SQL := 'delete from [Interval] where [Interval].ID=' + IntToStr(ID);
  ExecSQL(SQL,1);
end;

procedure TMainForm.LoadIntervals(LimitID: integer);
var SQL: string; item: TListItem;
    Format:  TFormatSettings;
begin
  Intervals.Items.Clear;
  SQL := 'Select * from [Interval] where [Interval].LimitID = ' +
  IntToStr(LimitID);
  if not ExecSQL(SQL) then Exit;
  Format.LongTimeFormat  := 'HH:mm';
  Format.TimeSeparator := ':';
  while not ADOQuery.Eof do
  begin
    item := Intervals.Items.Add;
    item.Caption := TimeToStr(ADOQuery.FieldByName('T1').AsDateTime,Format) +
      ' - ' + TimeToStr(ADOQuery.FieldByName('T2').AsDateTime,Format);
    item.Data := Pointer(ADOQuery.fieldByName('ID').AsInteger);
    ADOQuery.Next;
  end;
end;

procedure TMainForm.DelAllInterval(const LimitID: integer);
var SQL: string;
begin
  SQL := 'delete from [Interval] where [Interval].LimitID=' + IntToStr(LimitID);
  ExecSQL(SQL,1);
end;

function TMainForm.DeleteLimit(ID: integer): boolean;
var SQL: string;
begin
  DelAllInterval(ID);
  SQL := 'delete from Limits where Limits.ID=' + IntToStr(ID);
  Result := ExecSQL(SQL,1);
end;

procedure TMainForm.DeleteUser(ID: integer);
var SQL: string;
begin
  DeleteAllLimits(ID);
  SQL := 'delete from Users where Users.ID = ' + IntToStr(ID);
  ExecSQL(SQL,1);
end;

procedure TMainForm.LoadUserInfo(ID: integer);
begin
  edUserName.Text := 'No Data';
  Info.Clear;
  if not ExecSQL('Select * from Users where Users.ID = ' + IntToStr(ID)) then
    Exit;
  if ADOQuery.Eof then Exit;
  edUserName.Text := ADOQuery.FieldByName('Name').AsString;
  Info.Text := ADOQuery.FieldByName('Info').AsString;
  UserInfoChange := false;
end;

function TMainForm.SaveUserInfo(ID: integer): string;
begin
  Result := 'No Data';
  if not ExecSQL('Select * from Users where Users.ID = ' + IntToStr(ID)) then
    Exit;
  if ADOQuery.Eof then Exit;
  ADOQuery.Edit;
  if edUserName.Text <> '' then
    ADOQuery.FieldByName('Name').AsString := Trim(edUserName.Text);
  ADOQuery.FieldByName('Info').AsString := Info.Text;
  ADOQuery.Post;
  Result := Trim(edUserName.Text);
  UserInfoChange := false;
end;

procedure TMainForm.edUserNameChange(Sender: TObject);
begin
  UserInfoChange := true;
end;

procedure TMainForm.InfoChange(Sender: TObject);
begin
  UserInfoChange := true;
end;

procedure TMainForm.PageLimitChange(Sender: TObject);
begin
  LimitInfoChange := true;
end;

procedure TMainForm.chTimeClick(Sender: TObject);
begin
  LimitInfoChange := true;
end;

procedure TMainForm.IntervalsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  LimitInfoChange := true;
end;

procedure TMainForm.DeleteAllLimits(const UserID: integer);
var SQL: string;
    LID: array of integer; i: integer;
begin
  SetLength(LID,0);
  SQL := 'Select * from Limits where Limits.UserID = ' + IntToStr(UserID);
  if not ExecSQL(SQL) then Exit;
  while not ADOQuery.Eof do
  begin
    SetLength(LID,Length(LID)+1);
    LID[Length(LID)-1] := ADOQuery.FieldByName('ID').AsInteger;
    ADOQuery.Next;
  end;
  for i := 0 to Length(LID) - 1 do
  begin
    DeleteLimit(LID[i]);
  end;
end;

procedure TMainForm.btnDelAllLimitsClick(Sender: TObject);
begin
  DeleteAllLimits(Integer(TreeView.Selected.Data));
  TreeView.Selected.DeleteChildren;
end;

procedure TMainForm.LoadBox(CompoBox: TComboBox; Field: string);
begin
  CompoBox.Items.Clear;
  while not ADOQuery.Eof do
  begin
    CompoBox.Items.AddObject(ADOQuery.fieldByName(Field).AsString,
      TObject(ADOQuery.fieldByName('ID').AsInteger));
    ADOQuery.Next;
  end;
  CompoBox.ItemIndex := -1;
end;

procedure TMainForm.LoadPrinterBox;
begin
  if ExecSQL('Select * from AllPrinters p order by p.PName') then
    LoadBox(AddLimitForm.PrinterBox,'PName');
end;

procedure TMainForm.LoadUserBox(ID: integer = -1);
begin
  if ExecSQL('Select * from Users u order by u.Name') then
    LoadBox(AddLimitForm.UserBox,'Name');
  if ID <> -1 then
  AddLimitForm.UserBox.ItemIndex :=
    AddLimitForm.UserBox.Items.IndexOfObject(TObject(ID));
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TreeView.Selected := nil;
  ADOConnection.Close;
end;

procedure TMainForm.SetBtnEnabled;
begin
  if TreeView.Selected <> nil then
  begin
    btnDelUser.Enabled  := TreeView.Selected.Level = 0;
    btnDelLimit.Enabled := TreeView.Selected.Level = 1;
  end else
  begin
    btnDelUser.Enabled  := false;
    btnDelLimit.Enabled := false;
  end;
end;

procedure TMainForm.btnDelUserClick(Sender: TObject);
begin
  if TreeView.Selected = nil then Exit;
  if TreeView.Selected.Level = 0 then
  begin
    if MessageDlg('Вы действительно хотите удалить пользователя?',
      mtWarning,mbOKCancel,0) = mrOK then
    begin
      DeleteUser(Integer(TreeView.Selected.Data));
      ClearInfo;
      TreeView.Items.Delete(TreeView.Selected);
    end;
  end;
end;

procedure TMainForm.ClearInfo;
begin
  EdUserName.Text := '';
  Info.Clear;
  PageLimit.Value := 0;
  Printed.Caption := '0';
  Intervals.Items.Clear;
  lblPrinter.Caption := 'Принтер';
  lblComp.Caption := 'Компьютер';
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.actAddLimitExecute(Sender: TObject);
var id: integer; n: TTreeNode;
begin
  LoadPrinterBox;
  if Sender = mnAddLimit then
  begin
    if TreeView.Selected.Level = 0 then
      LoadUserBox(Integer(TreeView.Selected.Data))
    else
      LoadUserBox(Integer(TreeView.Selected.Parent.Data));
  end
  else LoadUserBox;
  if AddLimitForm.ShowModal = mrOK then
  begin
    if not ExecSQL('Select * from Limits') then Exit;
    ADOQuery.Append;
    ADOQuery.FieldByName('UserID').AsInteger :=
      Integer(AddLimitForm.UserBox.Items.Objects[AddLimitForm.UserBox.ItemIndex]);
    ADOQuery.FieldByName('Type').AsInteger := 1;
    ADOQuery.FieldByName('PageLimit').AsInteger := ProgOptions.NewLimit.PageLimit;
    ADOQuery.FieldByName('PID').AsInteger :=
      Integer(AddLimitForm.PrinterBox.Items.Objects[AddLimitForm.PrinterBox.ItemIndex]);
    ADOQuery.FieldByName('PagePrinted').AsInteger := 0;
    ADOQuery.Post;
    id := ADOQuery.FieldByName('ID').AsInteger;
    TreeView.Selected := nil;
    LoadUser;
    n := TreeView.Items.Item[0];
    while n <> nil do
    begin
      if (n.Level = 1) and (Integer(n.Data) = id) then
      begin
        TreeView.Selected := n;
        break;
      end;
      n := n.GetNext;
    end;
  end;
end;

procedure TMainForm.actAddUserExecute(Sender: TObject);
var SQL: string;
begin
  if AddUserForm.ShowModal = mrOK then
  begin
    SQL := 'Select * from Users';
    if not ExecSQL(SQL) then Exit;
    ADOQuery.Append;
    ADOQuery.FieldByName('Name').AsString := AddUserForm.edName.Text;
    ADOQuery.FieldByName('Info').AsString := AddUserForm.Info.Text;
    ADOQuery.Post;
    LoadUser;
  end;
end;

procedure TMainForm.actDeleteExecute(Sender: TObject);
begin
  if TreeView.Selected = nil then Exit;
  case TreeView.Selected.Level of
    1:  begin
          DeleteLimit(Integer(TreeView.Selected.Data));
          ClearInfo;
          TreeView.Items.Delete(TreeView.Selected);
        end;
    0:  begin
          if MessageDlg('Вы действительно хотите удалить пользователя?',
            mtWarning,mbOKCancel,0) = mrOK then
          begin
            DeleteUser(Integer(TreeView.Selected.Data));
            ClearInfo;
            TreeView.Items.Delete(TreeView.Selected);
          end;
        end;
  end;
end;

procedure TMainForm.actAddExecute(Sender: TObject);
begin
  if TreeView.Selected = nil then Exit;
  case TreeView.Selected.Level of
    1:  begin
          actAddLimitExecute(mnAddLimit);
        end;
    0:  begin
          actAddLimitExecute(mnAddLimit);
        end;
  end;
end;

procedure TMainForm.btnDelLimitClick(Sender: TObject);
begin
  if TreeView.Selected = nil then Exit;
  if TreeView.Selected.Level = 1 then
  begin
    DeleteLimit(Integer(TreeView.Selected.Data));
    ClearInfo;
    TreeView.Items.Delete(TreeView.Selected);
  end;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  AboutBox.ShowModal;  
end;

procedure TMainForm.actInfoExecute(Sender: TObject);
begin
  InfoForm.ShowModal;  
end;

end.
