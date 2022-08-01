unit HtmlParamUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, Spin;

type
  THtmlParamForm = class(TForm)
    btnPanel: TPanel;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    GroupBox1: TGroupBox;
    HeadEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    AlignBox: TComboBox;
    Label3: TLabel;
    HeadColor: TColorBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    TableBgColor: TColorBox;
    Label5: TLabel;
    TableBorder: TSpinEdit;
    GroupBox3: TGroupBox;
    PathEdit: TEdit;
    btnSelectPath: TSpeedButton;
    SaveDialog: TSaveDialog;
    TableAlBox: TComboBox;
    Label6: TLabel;
    TableHeadColor: TColorBox;
    Label7: TLabel;
    procedure btnSelectPathClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HtmlParamForm: THtmlParamForm;

implementation

{$R *.dfm}

procedure THtmlParamForm.btnSelectPathClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    PathEdit.Text := SaveDialog.FileName;
    btnOk.Enabled := true;
  end;
end;

procedure THtmlParamForm.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure THtmlParamForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
