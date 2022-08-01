unit OtchotUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TOtchotForm = class(TForm)
    Panel1: TPanel;
    OtchotMemo: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SaveDialog: TSaveDialog;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OtchotForm: TOtchotForm;

implementation

{$R *.dfm}

procedure TOtchotForm.BitBtn2Click(Sender: TObject);
begin
 if OtchotMemo.Lines.Count>0 then
 begin
  if SaveDialog.Execute then
  begin
    OtchotMemo.Lines.SaveToFile(SaveDialog.FileName);
  end;
 end;
end;

end.
