unit EditTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls;

type
  TTimeForm = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    dpT1: TDateTimePicker;
    dpT2: TDateTimePicker;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dpT1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimeForm: TTimeForm;

implementation

{$R *.dfm}

procedure TTimeForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TTimeForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TTimeForm.dpT1Change(Sender: TObject);
begin
  btnOK.Enabled := dpT1.Time < dpT2.Time;
end;

end.
