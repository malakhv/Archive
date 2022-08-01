unit DateIntervalUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TDateIntrvlFrm = class(TForm)
    DTP1: TDateTimePicker;
    DTP2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DTP1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DateIntrvlFrm: TDateIntrvlFrm;

implementation

{$R *.dfm}

procedure TDateIntrvlFrm.btnOkClick(Sender: TObject);
begin
 Self.ModalResult := mrOK
end;

procedure TDateIntrvlFrm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TDateIntrvlFrm.DTP1Change(Sender: TObject);
begin
  btnOk.Enabled := DTP1.Date <= DTP2.Date; 
end;

procedure TDateIntrvlFrm.FormCreate(Sender: TObject);
begin
  DTP1.Date := Date;
  DTP2.Date := Date;
end;

end.
