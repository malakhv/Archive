unit DlgUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TDlgFrm = class(TForm)
    Image: TImage;
    Text: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TDlgFrm.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDlgFrm.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
