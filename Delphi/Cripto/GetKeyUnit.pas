unit GetKeyUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TGetKeyForm = class(TForm)
    btnCansel: TBitBtn;
    btnOK: TBitBtn;
    edKey: TEdit;
    procedure edKeyChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GetKeyForm: TGetKeyForm;

implementation

{$R *.dfm}

procedure TGetKeyForm.edKeyChange(Sender: TObject);
begin
  btnOK.Enabled := edKey.Text <> '';
end;

end.
