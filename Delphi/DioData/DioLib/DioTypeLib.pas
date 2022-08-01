unit DioTypeLib;

interface

uses Classes;

const

  { Типы прибора }

  tDioNone = $000;
  tDio3T3V = $0AA;
  tDio2T4V = $0FF;
  tDio4T4V = $0A8;

  { Строковые имена приборов }

  sDio3T3V = 'dio3T3V';
  sDio2T4V = 'dio2T4V';
  sDio4T4V = 'dio4T4V';

type

  TDioType = class(TPersistent)
  private
    FDioType: byte;
    FOnChange: TNotifyEvent;
    function GetDioTypeStr: string;
    procedure SetDioType(const Value: byte);
    procedure SetDioTypeStr(const Value: string);
  protected
    procedure DoSetDioType(const ADioType: byte);
  public
    property DioType: byte read FDioType write SetDioType;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property DioTypeStr: string read GetDioTypeStr write SetDioTypeStr;
    class function DioTypeToStr(ADioType: byte): string;
    class function StrToDioType(Str: string): byte;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    constructor Create;
  end;

implementation

uses SysUtils;

{ TDioType }

procedure TDioType.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TDioType then
    DioType := (Source as TDioType).DioType;
end;

procedure TDioType.AssignTo(Des: TPersistent);
begin
  inherited;
  if Des <> nil then Des.Assign(Self);
end;

constructor TDioType.Create;
begin
  inherited;
  FDioType := tDioNone;
end;

class function TDioType.DioTypeToStr(ADioType: byte): string;
begin
  case ADioType of
    tDio3T3V: Result := sDio3T3V;
    tDio2T4V: Result := sDio2T4V;
    tDio4T4V: Result := sDio4T4V;
  else
    Result := '';
  end;
end;

procedure TDioType.DoSetDioType(const ADioType: byte);
begin
  if FDioType <> ADioType then
  begin
    FDioType := ADioType;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

function TDioType.GetDioTypeStr: string;
begin
  Result := DioTypeToStr(FDioType);
end;

procedure TDioType.SetDioType(const Value: byte);
begin
  DoSetDioType(Value);
end;

procedure TDioType.SetDioTypeStr(const Value: string);
begin
  DioType := StrToDioType(Value);
end;

class function TDioType.StrToDioType(Str: string): byte;
var TmpStr: string;
begin
  Result := 0;
  TmpStr := LowerCase(Trim(Str));
  if TmpStr = sDio3T3V then Result := tDio3T3V;
  if TmpStr = sDio2T4V then Result := tDio2T4V;
  if TmpStr = sDio4T4V then Result := tDio4T4V;
end;

end.
