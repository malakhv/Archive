unit ExlParamUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons;

type
  TExlParamForm = class(TForm)
    btnPanel: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    HeadEdit: TEdit;
    Label2: TLabel;
    FontSize: TSpinEdit;
    HeadColor: TColorBox;
    Label3: TLabel;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExlParamForm: TExlParamForm;

implementation

{$R *.dfm}

procedure TExlParamForm.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;  
end;

procedure TExlParamForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
