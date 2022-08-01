unit InfoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TInfoForm = class(TForm)
    btnOk: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.dfm}

procedure TInfoForm.btnOkClick(Sender: TObject);
begin
  Close;
end;

end.
