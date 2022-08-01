unit AddUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TAddUserForm = class(TForm)
    MainBox: TGroupBox;
    btnPanel: TPanel;
    lblName: TLabel;
    edName: TEdit;
    lblInfo: TLabel;
    Info: TMemo;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddUserForm: TAddUserForm;

implementation

{$R *.dfm}

procedure TAddUserForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TAddUserForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TAddUserForm.edNameChange(Sender: TObject);
begin
  btnOK.Enabled := edName.Text <> '';
end;

end.
