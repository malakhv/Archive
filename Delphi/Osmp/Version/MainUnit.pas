unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    btnSave: TButton;
    cbDate: TCheckBox;
    cbNumber: TCheckBox;
    edtNumber: TEdit;
    dtpDate: TDateTimePicker;
    btnLoad: TButton;
    btnGenerate: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure btnSaveClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    procedure VerLoad(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses VerUnit;

{$R *.dfm}

procedure TMainForm.btnLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    Ver.LoadFromFile(OpenDialog.FileName);
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    with Ver do
    begin
      IsVerDate := cbDate.Checked;
      IsVerNumber := cbNumber.Checked;
      VerDate := dtpDate.DateTime;
      VerNumber := StrToIntDef(edtNumber.Text,0);
      SaveToFile(SaveDialog.FileName);
    end;
end;

procedure TMainForm.btnGenerateClick(Sender: TObject);
begin
  with Ver do
  begin
    IsVerDate := cbDate.Checked;
    IsVerNumber := cbNumber.Checked;
    Generate;
  end;
  VerLoad(nil);
end;

procedure TMainForm.VerLoad(Sender: TObject);
begin
  with Ver do
  begin
    cbDate.Checked := IsVerDate;
    cbNumber.Checked := IsVerNumber;
    dtpDate.DateTime := VerDate;
    edtNumber.Text := IntToStr(VerNumber);
  end;
end;

end.
