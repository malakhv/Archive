unit DBList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Global, Menus, ActnPopup, ToolWin, ActnMan,
  ActnCtrls, ActnMenus, XPStyleActnCtrls, ActnList, ImgList;

type
  TfrmDBList = class(TForm)
    btnPanel: TPanel;
    btnClose: TSpeedButton;
    ActionManager: TActionManager;
    PopupAction: TPopupActionBar;
    actAdd: TAction;
    ActEdit: TAction;
    ActDelete: TAction;
    actUpdate: TAction;
    ImageList: TImageList;
    ActionToolBar: TActionToolBar;
    mnEdit: TMenuItem;
    mnSep1: TMenuItem;
    mnDelete: TMenuItem;
    mnSep2: TMenuItem;
    mnUpdate: TMenuItem;
    mnAdd: TMenuItem;
    ListView: TListView;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure ListViewEdited(Sender: TObject; Item: TListItem; var S: string);
    procedure actUpdateExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ActDeleteExecute(Sender: TObject);
  private
    FMode: byte;
    FDelEnabled: boolean;
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
    procedure SetMode(const Value: byte);
  public
    property Mode: byte read FMode write SetMode;
    constructor Create(AOwner: TComponent; AMode: byte = 0); reintroduce;
  end;

implementation

uses GetStrUnit, DlgUnit;

{$R *.dfm}

type
  TGDataMethod = function(Des: TObject): boolean of object;
  TSDataMethod = function(Name: string; ID: integer = ID_ERROR): boolean of object;
  TDDataMethod = function(ID:Integer): boolean of object;

const
  ValFormCaption: array[0..4] of string = ('Виды заплывов', 'Типы бассейнов',
    'Список городов', 'Список тренеров', 'Список школ');

var
  GMethod: TGDataMethod;
  SMethod: TSDataMethod;
  DMethod: TDDataMethod;

constructor TfrmDBList.Create(AOwner: TComponent; AMode: byte);
begin
  inherited Create(AOwner) ;
  FMode := AMode;
  FDelEnabled := false;
  case AMode of
    0: begin
      GMethod := SwDB.GSwType;
      SMethod := SwDB.SSwType;
      DMethod := SwDB.DSwType;
    end;
    1: begin
      GMethod := SwDB.GPlType;
      SMethod := SwDB.SPlType;
      DMethod := SwDB.DPlType;
    end;
    2: begin
      GMethod := SwDB.GCity;
      SMethod := SwDB.SCity;
      DMethod := SwDB.DCity;
      FDelEnabled := true;
    end;
    3: begin
      GMethod := SwDB.GTrnr;
      SMethod := SwDB.STrnr;
      DMethod := SwDB.DTrnr;
      FDelEnabled := true;
    end;
    4: begin
      GMethod := SwDB.GSchl;
      SMethod := SwDB.SSchl;
      DMethod := SwDB.DSchl;
      FDelEnabled := true;
    end;
  end;
  Self.Caption := ValFormCaption[FMode];
end;

procedure TfrmDBList.actAddExecute(Sender: TObject);
var frmVal: TfrmGetValue;
begin
  frmVal := TfrmGetValue.Create(Self);
  frmVal.Caption := ValFormCaption[FMode];
  try
    if frmVal.ShowModal = mrOK then
    begin
      if SMethod(Trim(frmVal.edValue.Text)) then
        actUpdate.Execute;
    end;
  finally
    frmVal.Free;
  end;
end;

procedure TfrmDBList.FormCreate(Sender: TObject);
begin
  PostMessage(Self.Handle,WM_RELOADDATA,0,0);
end;

procedure TfrmDBList.ListViewEdited(Sender: TObject; Item: TListItem; var S: string);
begin
  if SMethod(S,Integer(Item.Data)) then
    PostMessage(MainFormHandle,WM_UPDATEBRWSR,0,0);
end;

procedure TfrmDBList.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  actEdit.Enabled := Selected;
  actDelete.Enabled := Selected and FDelEnabled;
end;

procedure TfrmDBList.ReloadData(var Msg: TMessage);
begin
  GMethod(ListView);
  ListView.Columns[0].Width := ListView.ClientWidth;
end;

procedure TfrmDBList.SetMode(const Value: byte);
begin
  FMode := Value;
end;

procedure TfrmDBList.ActDeleteExecute(Sender: TObject);
var Dlg: TDlgFrm;
begin
  Dlg := TDlgFrm.Create(Self);
  try
    Dlg.Text.Caption := 'Удалить?';
    if Dlg.ShowModal = mrOK then
    begin
      DMethod(Integer(ListView.Selected.Data));
      ListView.DeleteSelected;
      PostMessage(MainFormHandle,WM_UPDATEBRWSR,0,0);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmDBList.ActEditExecute(Sender: TObject);
begin
  ListView.Selected.EditCaption;
end;

procedure TfrmDBList.actUpdateExecute(Sender: TObject);
begin
  PostMessage(Self.Handle,WM_RELOADDATA,FMode,0);
end;

procedure TfrmDBList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
