unit PtrcEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus, ActnPopup, ActnList, XPStyleActnCtrls, ActnMan, ImgList,
  ToolWin, ActnCtrls, StdCtrls, Global, Buttons;

type
  TfrmPatricipants = class(TForm)
    ActionToolBar: TActionToolBar;
    ImageList: TImageList;
    ActionManager: TActionManager;
    actAdd: TAction;
    ActEdit: TAction;
    ActDelete: TAction;
    actUpdate: TAction;
    PopupAction: TPopupActionBar;
    mnAdd: TMenuItem;
    mnEdit: TMenuItem;
    mnSep1: TMenuItem;
    mnDelete: TMenuItem;
    mnSep2: TMenuItem;
    mnUpdate: TMenuItem;
    ListView: TListView;
    FindEdit: TEdit;
    actFind: TAction;
    actSep: TAction;
    StatusBar: TStatusBar;
    btnPanel: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    chNoCat: TCheckBox;
    procedure actAddExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ActEditExecute(Sender: TObject);
    procedure actUpdateExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure chNoCatClick(Sender: TObject);
  private
    FBYear: integer;
    FSex: integer;
    FDelEnabled: boolean;
    procedure SetSex(const Value: integer);
    procedure SetYear(const Value: integer);
    { Private declarations }
  public
    property DelEnabled: boolean read FDelEnabled write FDelEnabled;
    property BYear: integer read FBYear write SetYear;
    property Sex: integer read FSex write SetSex;
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
    constructor Create(AOwner: TComponent; ABYear: integer = 0;
      ASex: integer = -1); reintroduce;
  end;

implementation

uses PtrcInfo, SQLUnit, ADODBWork;

{$R *.dfm}

procedure TfrmPatricipants.actAddExecute(Sender: TObject);
var frmInfo: TftmPtrcInfo;
begin
  frmInfo := TftmPtrcInfo.Create(Self);
  try
    SendMessage(frmInfo.Handle,WM_RELOADDATA,0,0);
    if frmInfo.ShowModal = mrOK then
    begin
      if SwDB.SPtrc(Trim(frmInfo.edFName.Text),Trim(frmInfo.edName.Text),'',
        StrToInt(frmInfo.cbBYear.Items[frmInfo.cbBYear.ItemIndex]),
        frmInfo.cbSex.ItemIndex,Integer(frmInfo.cbSchl.Items.Objects[frmInfo.cbSchl.ItemIndex]),
        Integer(frmInfo.cbTrnr.Items.Objects[frmInfo.cbTrnr.ItemIndex]),
        Integer(frmInfo.cbCity.Items.Objects[frmInfo.cbCity.ItemIndex])) then
        SendMessage(Self.Handle,WM_RELOADDATA,FBYear,FSex);
    end;
  finally
    frmInfo.Free;
  end;
end;

procedure TfrmPatricipants.ActDeleteExecute(Sender: TObject);
begin
  if ShowDlg(Self,'Удалить...',
    'Вы действительно хотите удалить запись?') = mrOK then
    if SwDB.DPtrc(Integer(ListView.Selected.Data)) then
    begin
      ListView.DeleteSelected;
      PostMessage(MainFormHandle,WM_RELOADDATA,0,0);
    end;
end;

procedure TfrmPatricipants.ActEditExecute(Sender: TObject);
var frmInfo: TftmPtrcInfo;
    List: TStringList;
    ID: integer;
begin
  frmInfo := TftmPtrcInfo.Create(Self);
  List := TStringList.Create;
  try
    ID := Integer(ListView.Selected.Data);
    SendMessage(frmInfo.Handle,WM_RELOADDATA,0,0);
    SwDB.LoadRec(List,GetRecByID(tPtrc,ID),'ID');
    frmInfo.edFName.Text := List.Values['FName'];
    frmInfo.edName.Text  := List.Values['Name'];
    frmInfo.cbSex.ItemIndex := StrToIntDef(List.Values['Sex'],0);
    frmInfo.cbBYear.ItemIndex := frmInfo.cbBYear.Items.IndexOf(List.Values['BYear']);
    frmInfo.cbTrnr.ItemIndex :=
      frmInfo.cbTrnr.Items.IndexOfObject(TObject(StrToInt(List.Values['Trnr_id'])));
    frmInfo.cbSchl.ItemIndex :=
      frmInfo.cbSchl.Items.IndexOfObject(TObject(StrToInt(List.Values['Schl_id'])));
    frmInfo.cbCity.ItemIndex :=
      frmInfo.cbCity.Items.IndexOfObject(TObject(StrToInt(List.Values['City_id'])));

    if frmInfo.ShowModal = mrOK then
    begin
      if SwDB.SPtrc(Trim(frmInfo.edFName.Text),Trim(frmInfo.edName.Text),'',
        StrToInt(frmInfo.cbBYear.Items[frmInfo.cbBYear.ItemIndex]),
        frmInfo.cbSex.ItemIndex,Integer(frmInfo.cbSchl.Items.Objects[frmInfo.cbSchl.ItemIndex]),
        Integer(frmInfo.cbTrnr.Items.Objects[frmInfo.cbTrnr.ItemIndex]),
        Integer(frmInfo.cbCity.Items.Objects[frmInfo.cbCity.ItemIndex]),ID) then
        begin
          SendMessage(Self.Handle,WM_RELOADDATA,FBYear,FSex);
          PostMessage(MainFormHandle,WM_UPDATEBRWSR,0,0);
        end;
    end;
  finally
    frmInfo.Free
  end;
end;

procedure TfrmPatricipants.actFindExecute(Sender: TObject);
begin
  SwDB.GPtrc(ListView,sql_Ptrc_view + ' and ' + tPtrc + '.FName Like ' + '''' +
    FindEdit.Text + '*' + '''');
end;

procedure TfrmPatricipants.actUpdateExecute(Sender: TObject);
begin
  SendMessage(Self.Handle,WM_RELOADDATA,FBYear,FSex);
end;

procedure TfrmPatricipants.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TfrmPatricipants.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TfrmPatricipants.chNoCatClick(Sender: TObject);
begin
  SendMessage(Self.Handle,WM_RELOADDATA,FBYear,FSex);
end;

constructor TfrmPatricipants.Create(AOwner: TComponent; ABYear, ASex: integer);
begin
  inherited Create(AOwner);
  FBYear := ABYear;
  FSex   := ASex;
  FDelEnabled := true;
end;

procedure TfrmPatricipants.FormCreate(Sender: TObject);
begin
  SendMessage(Self.Handle,WM_RELOADDATA,FBYear,FSex);
end;

procedure TfrmPatricipants.ListViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  ActDelete.Enabled := Selected and FDelEnabled;
  ActEdit.Enabled   := Selected;
  btnOK.Enabled     := Selected;
end;

procedure TfrmPatricipants.ReloadData(var Msg: TMessage);
var sql: WideString;
begin
  sql := sql_Ptrc_view;
  if not chNoCat.Checked then
  begin
    FBYear := Msg.WParam;
    FSex   := Msg.LParam;
    if FBYear > 0 then
      sql := sql + ' and ' + tPtrc + '.BYear = ' + IntToStr(FBYear);
    if (FSex = 0) or (FSex = 1) then
      sql := sql + ' and ' + tPtrc + '.Sex = ' + IntToStr(FSex);
  end;
  SwDB.GPtrc(ListView,sql);
end;

procedure TfrmPatricipants.SetSex(const Value: integer);
begin
  if FSex <> Value then
  begin
    SendMessage(Self.Handle,WM_RELOADDATA,0,Value);
  end;
end;

procedure TfrmPatricipants.SetYear(const Value: integer);
begin
  if FBYear <> Value then
    SendMessage(Self.Handle,WM_RELOADDATA,Value,0);
end;

end.
