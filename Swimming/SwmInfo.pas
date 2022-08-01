unit SwmInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Global, jpeg;

type
  TfrmSwmInfo = class(TForm)
    Label1: TLabel;
    cbCmpt: TComboBox;
    Label2: TLabel;
    cbSwTp: TComboBox;
    Label3: TLabel;
    cbSex: TComboBox;
    Image: TImage;
    Label4: TLabel;
    cbPlTp: TComboBox;
    Label5: TLabel;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    cbBYear: TComboBox;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbSwTpChange(Sender: TObject);
  private
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
  public
    function ShowMode(Mode: byte):TModalResult;
  end;

implementation

{$R *.dfm}

procedure TfrmSwmInfo.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TfrmSwmInfo.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TfrmSwmInfo.cbSwTpChange(Sender: TObject);
begin
  btnOk.Enabled := (cbSwTp.ItemIndex <> -1) and (cbPlTp.ItemIndex <> -1) and
    (cbBYear.ItemIndex <> -1) and (cbCmpt.ItemIndex <> -1)  
end;

procedure TfrmSwmInfo.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 1970 to 2020 do
  begin
    cbBYear.Items.Add(IntToStr(i));
  end;
end;

procedure TfrmSwmInfo.ReloadData(var Msg: TMessage);
begin
  SwDB.GSwType(cbSwTp);
  SwDB.GCmpt(cbCmpt);
  SwDB.GPlType(cbPlTp);
end;

function TfrmSwmInfo.ShowMode(Mode: byte): TModalResult;
begin
  case Mode of
    1: Self.Caption := 'Новый заплыв';
    2: Self.Caption := 'Информация о заплыве';
  else
    Self.Caption := 'Новый заплыв';
  end;
  Result := Self.ShowModal;
end;

end.
