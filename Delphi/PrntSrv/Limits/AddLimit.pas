unit AddLimit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TAddLimitForm = class(TForm)
    MainBox: TGroupBox;
    btnPanel: TPanel;
    PrinterBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    UserBox: TComboBox;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    procedure PrinterBoxChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddLimitForm: TAddLimitForm;

implementation

{$R *.dfm}

procedure TAddLimitForm.PrinterBoxChange(Sender: TObject);
begin
  btnOK.Enabled := (PrinterBox.ItemIndex <> -1)and(UserBox.ItemIndex <> -1);
end;

procedure TAddLimitForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TAddLimitForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
