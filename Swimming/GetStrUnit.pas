unit GetStrUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TfrmGetValue = class(TForm)
    lblName: TLabel;
    edValue: TEdit;
    btnCancel: TSpeedButton;
    btnOk: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGetValue: TfrmGetValue;

implementation

{$R *.dfm}

procedure TfrmGetValue.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmGetValue.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

end.
