unit YearUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TYearForm = class(TForm)
    YearBox: TComboBox;
    btnOK: TSpeedButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YearForm: TYearForm;

implementation

{$R *.dfm}

procedure TYearForm.btnOKClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

end.
