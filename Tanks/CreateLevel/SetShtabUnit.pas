unit SetShtabUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, Buttons;

type
  TSetShtabForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    T1LivEdit: TSpinEdit;
    SpinEdit1: TSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetShtabForm: TSetShtabForm;

implementation

{$R *.dfm}

procedure TSetShtabForm.BitBtn2Click(Sender: TObject);
begin
 Close;
end;

end.
