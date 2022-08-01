unit FieldInfoUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
    ComCtrls, StdCtrls;

type
  TFieldInfoForm = class(TForm)
    btnPanel: TPanel;
    FieldList: TListView;
    btnClose: TButton;
    btnOK: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FieldListItemChecked(Sender: TObject; Item: TListItem);
  private
    FDioType: byte;
    procedure SetDioType(const Value: byte);
  public
    property DioType: byte read FDioType write SetDioType;
    procedure UpdateFieldList;
  end;

var
  FieldInfoForm: TFieldInfoForm;

function ChangeField(ADioType: byte): boolean;

implementation

{$R *.dfm}

uses XMLIntf, DioTypeLib, DioFieldLib;

function ChangeField(ADioType: byte): boolean;
begin
  FieldInfoForm := TFieldInfoForm.Create(Application);
  try
    FieldInfoForm.DioType := ADioType;
    Result := FieldInfoForm.ShowModal = mrOK;
  finally
    FieldInfoForm.Free;
  end;
end;

{ TFieldInfoForm }

procedure TFieldInfoForm.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFieldInfoForm.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFieldInfoForm.FieldListItemChecked(Sender: TObject; Item: TListItem);
begin
  if Item.Data <> nil then
    IXMLNode(Item.Data).NodeValue := Integer(Item.Checked);
end;

procedure TFieldInfoForm.SetDioType(const Value: byte);
begin
  FDioType := Value;
  UpdateFieldList;
end;

procedure TFieldInfoForm.UpdateFieldList;
var DioFields: TDioFields;
    i: integer;
begin
  DioFields := TDioFields.Create(FDioType);
  for i := 0 to DioFields.Count - 1 do
    with FieldList.Items.Add do
    begin
      Caption := DioFields[i].Caption;
      Checked := DioFields[i].Enabled;
      Data := Pointer(DioFields[i].XMLNode);
    end;
  DioFields.Free;
end;

end.
