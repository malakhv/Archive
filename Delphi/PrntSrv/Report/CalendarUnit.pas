unit CalendarUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Buttons;

type
  TCalendarForm = class(TForm)
    Calendar: TMonthCalendar;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CalendarForm: TCalendarForm;

implementation

{$R *.dfm}

procedure TCalendarForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TCalendarForm.btnOkClick(Sender: TObject);
begin
   Self.ModalResult := mrOK;
end;

procedure TCalendarForm.FormCreate(Sender: TObject);
begin
  Calendar.Date := Date;
end;

end.
