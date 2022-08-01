unit CodeCmplEditUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TCdCmplForm = class(TForm)
    btnPanel: TPanel;
    CodeComplList: TMemo;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdCmplForm: TCdCmplForm;

implementation

{$R *.dfm}

procedure TCdCmplForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;  
end;

procedure TCdCmplForm.btnOkClick(Sender: TObject);
begin
  CodeComplList.Text := Trim(CodeComplList.Text);
  CodeComplList.Lines.SaveToFile('CdCmpl.lst');
  Self.ModalResult := mrOK;
end;

end.
