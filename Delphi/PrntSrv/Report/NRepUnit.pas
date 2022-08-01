unit NRepUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TNRepForm = class(TForm)
    Label1: TLabel;
    FNameEdit: TEdit;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FNameEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NRepForm: TNRepForm;

implementation

{$R *.dfm}

procedure TNRepForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TNRepForm.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TNRepForm.FNameEditChange(Sender: TObject);
begin
  btnOK.Enabled := FNameEdit.Text <> '';  
end;

end.
