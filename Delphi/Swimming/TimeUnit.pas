unit TimeUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Global, ComCtrls, Mask;

type
  TTimeForm = class(TForm)
    lblSwmn: TLabel;
    btnOk: TButton;
    mskTime: TMaskEdit;
    procedure btnOkClick(Sender: TObject);
    procedure edTimeChange(Sender: TObject);
    procedure edTimeKeyPress(Sender: TObject; var Key: Char);
    procedure mskTimeChange(Sender: TObject);
  private
    FPtrcID: integer;
    FSwmnID: integer;
    procedure SetPtrcID(const Value: integer);
    procedure SetSwmnID(const Value: integer);
    function GetATime: integer;
    { Private declarations }
  public
    property PtrcID: integer read FPtrcID write SetPtrcID;
    property SwmnID: integer read FSwmnID write SetSwmnID;
    property ATime: integer read GetATime;
    procedure SetData(APtrcID, ASwmnID: integer);
    procedure ReloadData(var Msg: TMessage); message WM_RELOADDATA;
  end;

implementation

uses TimeWrk;

{$R *.dfm}

var
  Flag: integer = 0;

procedure TTimeForm.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOK;
end;

procedure TTimeForm.edTimeChange(Sender: TObject);
begin
  btnOk.Enabled := Trim(mskTime.Text) <> '';
end;

procedure TTimeForm.edTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ',' then Key := '.';
  if not(Key in CharSet) then
    Key := Char(0);
end;

function TTimeForm.GetATime: integer;
var i: integer;
    TimeStr: TSwTimeString;
begin
  TimeStr := mskTime.Text;
  for i := 1 to Length(TimeStr) do
    if TimeStr[i] = ' ' then TimeStr[i] := '0';
  TimeStr := TimeStr + '0';
  Result := SwTimeStrToInt(TimeStr);
end;

procedure TTimeForm.mskTimeChange(Sender: TObject);
begin
  btnOk.Enabled := Trim(mskTime.Text) <> '.  .';
  
end;

procedure TTimeForm.ReloadData(var Msg: TMessage);
var str: string[8];
begin
  str := SwTimeToStr(SwDB.GPtrcPTime(FPtrcID,FSwmnID));
  mskTime.Text := str;
end;

procedure TTimeForm.SetData(APtrcID, ASwmnID: integer);
begin
  FPtrcID := APtrcID;
  FSwmnID := ASwmnID;
  SendMessage(Self.Handle,WM_RELOADDATA,0,0);
end;

procedure TTimeForm.SetPtrcID(const Value: integer);
begin
  if FPtrcID <> Value then
  begin
    FPtrcID := Value;
    SendMessage(Self.Handle,WM_RELOADDATA,0,0);
  end;
end;

procedure TTimeForm.SetSwmnID(const Value: integer);
begin
  if FSwmnID <> Value then
  begin
    FSwmnID := Value;
    SendMessage(Self.Handle,WM_RELOADDATA,0,0);
  end;
end;

end.
