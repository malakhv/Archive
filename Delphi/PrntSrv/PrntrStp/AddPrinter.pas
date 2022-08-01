unit AddPrinter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ComCtrls, ImgList;

type
  TAddPrinterForm = class(TForm)
    PList: TListView;
    btnPanel: TPanel;
    btnCansel: TSpeedButton;
    btnAdd: TSpeedButton;
    procedure PListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure btnCanselClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddPrinterForm: TAddPrinterForm;

implementation

{$R *.dfm}

procedure TAddPrinterForm.btnCanselClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TAddPrinterForm.btnAddClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TAddPrinterForm.PListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  btnAdd.Enabled := Selected;
end;

end.
