unit ProgresUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Gauges, ExtCtrls;

type
  TProgresForm = class(TForm)
    Panel1: TPanel;
    SendProgres: TGauge;
    BitBtn1: TBitBtn;
    CompLabel: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgresForm: TProgresForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TProgresForm.BitBtn1Click(Sender: TObject);
begin
 ProgresForm.BitBtn1.Kind := bkCancel;
 ProgresForm.BitBtn1.Caption := 'Отмена';
 ProgresForm.SendProgres.Progress := 0; 
 MainUnit.EndSend := true;
 Close;
end;

end.
