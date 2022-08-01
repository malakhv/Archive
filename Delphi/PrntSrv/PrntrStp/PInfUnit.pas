unit PInfUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TPInfoForm = class(TForm)
    InfoBox: TGroupBox;
    Panel1: TPanel;
    Info: TMemo;
    btnCancel: TSpeedButton;
    btnSave: TSpeedButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PInfoForm: TPInfoForm;

implementation

{$R *.dfm}

procedure TPInfoForm.btnSaveClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TPInfoForm.btnCancelClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
