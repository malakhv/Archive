unit TimeWrk;

interface

const
  TimeSep = '.';

type
  TSwTimeString = string[9];

type
  TMn = 0..59;
  TSc = 0..59;
  TMl = 0..999;

type
  TSwTime = record
    mm: TMn;
    ss: TSc;
    ml: TMl;
  end;

type
  TCharSet = set of Char;

const
  CharSet: TCharSet = ['0'..'9','.',#8];

const
  NilTime : TSwTime = (mm: 0; ss: 0; ml: 0);

function MlSecond(SwTime: TSwTime): integer;
function SwTimeToStr(SwTime: integer): TSwTimeString; overload;
function SwTimeToStr(SwTime: TSwTime): TSwTimeString; overload;

function SwTimeStrToInt(SwTimeStr: TSwTimeString): integer;
function StrToSwTime(SwTimeStr: TSwTimeString): TSwTime;

implementation

uses
  SysUtils, MainUnit;

const
  MlSecByMin = 60000;

function ToAddWithZero(Value: integer): TSwTimeString;
begin
  if Value < 10 then
    Result := '0' + IntToStr(Value)
  else
    Result := IntToStr(Value);
end;

function MlSecond(SwTime: TSwTime): integer;
begin
  Result := SwTime.ml + SwTime.ss * 1000 + SwTime.mm * 60 * 1000;
end;

function SwTimeToStr(SwTime: integer): TSwTimeString;
var tmp: integer;
begin
  tmp := SwTime div 60000;
  Result := ToAddWithZero(tmp) + TimeSep;
  tmp := (SwTime mod 60000) div 1000;
  Result := Result + ToAddWithZero(tmp) + TimeSep;
  tmp := ((SwTime mod 60000) mod 1000);
  Result := Result + ToAddWithZero(tmp)
end;

function SwTimeToStr(SwTime: TSwTime): TSwTimeString;
begin
  Result := SwTimeToStr(MlSecond(SwTime));
end;

function SwTimeStrToInt(SwTimeStr: TSwTimeString): integer;
begin
  Result := MlSecond(StrToSwTime(SwTimeStr))
end;

function StrToSwTime(SwTimeStr: TSwTimeString): TSwTime;
var i,j: integer; str: string;
    rs: array[0..2] of integer;
begin
  SwTimeStr := Trim(SwTimeStr);
  for i := Low(rs) to High(rs) do
    rs[i] := 0;
  j := 0;
  for i := 1 to Length(SwTimeStr) do
  begin
    if SwTimeStr[i] <> TimeSep then
    begin
      str := str + SwTimeStr[i];
    end else
    begin
      if str <> '' then
      begin
        rs[j] := StrToIntDef(str,0);
        inc(j);
        str := '';
      end;
    end;
  end;
  if str <> '' then
    rs[j] := StrToIntDef(str,0);
  Result.mm := rs[0];
  Result.ss := rs[1];
  Result.ml := rs[2];
end;

end.
