unit CmptInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TCmptInfoForm = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    memInfo: TMemo;
    lblInfo: TLabel;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    dtTime: TDateTimePicker;
    lblTime: TLabel;
    dtDate: TDateTimePicker;
    Label1: TLabel;
    Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dtDateChange(Sender: TObject);
  private
    FDataChange: boolean;
  public
    property DataChange: boolean read FDataChange write FDataChange;
    function ShowMode(Mode: byte): TModalResult;
  end;

implementation

{$R *.dfm}

procedure TCmptInfoForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TCmptInfoForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TCmptInfoForm.dtDateChange(Sender: TObject);
begin
  if (Sender = dtDate) or (Sender = dtTime) then
    FDataChange := true;
end;

procedure TCmptInfoForm.FormCreate(Sender: TObject);
begin
  dtDate.Date := Date;
end;

function TCmptInfoForm.ShowMode(Mode: byte):TModalResult;
begin
  case Mode of
    1: Self.Caption := 'Новое соревнование';
    2: Self.Caption := 'Информация о соревновании';
  end;
  Result := Self.ShowModal;
end;

end.
