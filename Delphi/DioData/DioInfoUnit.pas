unit DioInfoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DioTypes, DioInfoLib;

type
  TDioInfoForm = class(TForm)
    btnClose: TButton;
    btnOk: TButton;
    Label1: TLabel;
    edAddress: TEdit;
    Label2: TLabel;
    edOwner: TEdit;
    Label3: TLabel;
    edRes01: TEdit;
    Label4: TLabel;
    edRes02: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    function GetDioAddress: TDioStr;
    function GetDioOwner: TDioStr;
    function GetDioRes01: TDioStr;
    function GetDioRes02: TDioStr;
    procedure SetDioAddress(const Value: TDioStr);
    procedure SetDioOwner(const Value: TDioStr);
    procedure SetDioRes01(const Value: TDioStr);
    procedure SetDioRes02(const Value: TDioStr);
  public
    property DioAddress: TDioStr read GetDioAddress write SetDioAddress;
    property DioOwner: TDioStr read GetDioOwner write SetDioOwner;
    property DioRes01: TDioStr read GetDioRes01 write SetDioRes01;
    property DioRes02: TDioStr read GetDioRes02 write SetDioRes02;
    procedure AssignDioInfo(Source: TDioInfo);
    procedure AssignDioInfoTo(Des: TDioInfo);
  end;

var
  DioInfoForm: TDioInfoForm;

function ChangeDioInfo(ADioInfo: TDioInfo): boolean;

implementation

{$R *.dfm}

function ChangeDioInfo(ADioInfo: TDioInfo): boolean;
begin
  Result := false;
  if ADioInfo.Index = -1 then Exit;
  DioInfoForm := TDioInfoForm.Create(Application);
  try
    DioInfoForm.AssignDioInfo(ADioInfo);
    if DioInfoForm.ShowModal = mrOk then
    begin
      DioInfoForm.AssignDioInfoTo(ADioInfo);
      Result := ADioInfo.Save;
    end;
  finally
    DioInfoForm.Free;
  end;
end;

{ TDioInfoForm }

procedure TDioInfoForm.AssignDioInfo(Source: TDioInfo);
begin
  if Source <> nil then
    with Source do
    begin
      DioAddress := Address;
      DioOwner := Owner;
      DioRes01 := Res01;
      DioRes02 := Res02;
    end;
end;

procedure TDioInfoForm.AssignDioInfoTo(Des: TDioInfo);
begin
  if Des <> nil then
    with Des do
    begin
      Address := DioAddress;
      Owner := DioOwner;
      Res01 := DioRes01;
      Res02 := DioRes02;
    end;
end;

procedure TDioInfoForm.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDioInfoForm.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function TDioInfoForm.GetDioAddress: TDioStr;
begin
  Result := TDioStr(edAddress.Text);
end;

function TDioInfoForm.GetDioOwner: TDioStr;
begin
  Result := TDioStr(edOwner.Text);
end;

function TDioInfoForm.GetDioRes01: TDioStr;
begin
  Result := TDioStr(edRes01.Text);
end;

function TDioInfoForm.GetDioRes02: TDioStr;
begin
  Result := TDioStr(edRes02.Text);
end;

procedure TDioInfoForm.SetDioAddress(const Value: TDioStr);
begin
  edAddress.Text := String(Value);
end;

procedure TDioInfoForm.SetDioOwner(const Value: TDioStr);
begin
  edOwner.Text := String(Value);
end;

procedure TDioInfoForm.SetDioRes01(const Value: TDioStr);
begin
  edRes01.Text := String(Value);
end;

procedure TDioInfoForm.SetDioRes02(const Value: TDioStr);
begin
  edRes02.Text := String(Value);
end;

end.
