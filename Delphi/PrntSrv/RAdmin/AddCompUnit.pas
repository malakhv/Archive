unit AddCompUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TAddCompForm = class(TForm)
    btnPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Info: TMemo;
    CompBox: TComboBox;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure CompBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddCompForm: TAddCompForm;

implementation

{$R *.dfm}

procedure TAddCompForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TAddCompForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TAddCompForm.CompBoxChange(Sender: TObject);
begin
  btnOK.Enabled := Trim(CompBox.Text) <> '';
end;

end.
