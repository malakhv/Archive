unit MyStrUtils;

interface

function CharArrayToString(Source: array of AnsiChar): string; overload;
function CharArrayToString(Source: array of WideChar): string; overload;

procedure StringToCharArray(Source: string; var Des: array of  AnsiChar); overload;
procedure StringToCharArray(Source: string; var Des: array of  WideChar); overload;

function MyBoolToStr(Value: boolean): string;
function MyStrToBool(Str: string): boolean;

implementation

uses SysUtils;

function CharArrayToString(Source: array of AnsiChar): string;
begin
  Result := String(StrPas(Source));
  SetLength(Result,Length(Source));
  Result := Trim(Result);
end;

function CharArrayToString(Source: array of WideChar): string;
begin
  Result := StrPas(Source);
  SetLength(Result,Length(Source));
end;

procedure StringToCharArray(Source: string; var Des: array of  AnsiChar);
const
  EmptyChar = #0;
var
  i: integer;
begin
  for i := Low(Des) to High(Des) do
    if i < Length(Source) then
      Des[i] := AnsiChar(Source[i+1])
    else
      Des[i] := EmptyChar;
end;

procedure StringToCharArray(Source: string; var Des: array of  WideChar);
const
  EmptyChar = #0;
var
  i: integer;
begin
  for i := Low(Des) to High(Des) do
    if i < Length(Source) then
      Des[i] := WideChar(Source[i+1])
    else
      Des[i] := EmptyChar;
end;

function MyBoolToStr(Value: boolean): string;
begin
  Result := IntToStr(Abs(StrToInt(BoolToStr(Value))));
end;

function MyStrToBool(Str: string): boolean;
begin
  Result := StrToBoolDef(Str,false);
end;

end.
