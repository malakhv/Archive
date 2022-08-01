unit PtrcInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Global;

type
  TftmPtrcInfo = class(TForm)
    btnPanel: TPanel;
    cbTrnr: TComboBox;
    Label1: TLabel;
    cbSchl: TComboBox;
    Label2: TLabel;
    cbBYear: TComboBox;
    Label3: TLabel;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    cbSex: TComboBox;
    Label4: TLabel;
    cbCity: TComboBox;
    Label7: TLabel;
    edFName: TEdit;
    Label8: TLabel;
    edName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edFNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
  end;

implementation

{$R *.dfm}

procedure TftmPtrcInfo.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TftmPtrcInfo.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TftmPtrcInfo.edFNameChange(Sender: TObject);
begin
  btnOK.Enabled := (Trim(edFName.Text) <> '') and (Trim(edName.Text) <> '') and
    (cbTrnr.ItemIndex <> -1) and (cbBYear.ItemIndex > 0) and (cbSchl.ItemIndex <> -1) and
    (cbCity.ItemIndex <> -1);
end;

procedure TftmPtrcInfo.FormCreate(Sender: TObject);
var i: integer;
begin
  for i := 1970 to 2020 do
  begin
    cbBYear.Items.Add(IntToStr(i));
  end;
end;

procedure TftmPtrcInfo.ReloadData(var Msg: TMessage);
begin
  SwDB.GCity(cbCity);
  SwDB.GTrnr(cbTrnr);
  SwDB.GSchl(cbSchl);
end;

end.
