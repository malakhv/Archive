unit DioUtils;

interface

uses DioTypes;

type

  { Работа с массивом данных прибора }

  { Режимы копирования массивов }

  TArrayCopyMode = (cmNone = 0, cmMax = 1, cmMin = 2, cmAdd = 3, cmSub = 4, cmDiv = 5,
    cmMul = 6, cmCopy = 7);

  { Класс содержыщий функции работы с массивами }

  TArrayWork = class(TObject)
  public
    class procedure ArrayCopy(Source: array of TDioFloat; var Des: array of TDioFloat;
      CopyMode: TArrayCopyMode = cmCopy);
    class procedure Add(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure Sub(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure DivArr(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure Mul(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure Min(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure Max(Source: array of TDioFloat; var Des: array of TDioFloat);
    class procedure Clear(var Des: array of TDioFloat);
    class procedure SetValue(Value: TDioFloat; var Des: array of TDioFloat);
  end;

  procedure StrToCharArray(const Str: TDioStr; var CharArray: array of TDioChar);

  function DioDateToStr(DateTime: TDateTime; LongYear: boolean = false;
    IncludeTime: boolean = true): string;

implementation

uses SysUtils;

procedure FPUInit;
{ Инициализация математического сопроцессора }
asm
  fninit;
end;

{ TArrayWork }

class procedure TArrayWork.Add(Source: array of TDioFloat; var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmAdd);
end;

class procedure TArrayWork.ArrayCopy(Source: array of TDioFloat;
  var Des: array of TDioFloat; CopyMode: TArrayCopyMode);
var i: integer;
begin
  for i := Low(Des) to High(Des) do
  begin
    // Если массив приёмник оказался длиннее массива источника
    if i > High(Source) then
    begin
      // Если режим копирования арифметическое действие - то обнуляем
      // оставшиеся элементы, иначе оставляем значение без изменения
      if (CopyMode = cmAdd) or (CopyMode = cmDiv) or (CopyMode = cmMul) then
        Des[i] := 0;
      Continue;
    end;
    // Инициализация математического сопроцессора
    FPUInit;
    // Выбор режима копирования
    case CopyMode of
      cmMax: if Des[i] < Source[i] then Des[i] := Source[i];
      cmMin: if Des[i] > Source[i] then Des[i] := Source[i];
      cmAdd: Des[i] := Des[i] + Source[i];
      cmSub: Des[i] := Des[i] - Source[i];
      cmDiv: Des[i] := Des[i] / Source[i];
      cmMul: Des[i] := Des[i] * Source[i];
      cmCopy, cmNone: Des[i] := Source[i];
    end;
  end;
end;

class procedure TArrayWork.Clear(var Des: array of TDioFloat);
begin
  SetValue(0,Des);
end;

class procedure TArrayWork.DivArr(Source: array of TDioFloat;
  var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmDiv);
end;

class procedure TArrayWork.Max(Source: array of TDioFloat; var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmMax);
end;

class procedure TArrayWork.Min(Source: array of TDioFloat; var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmMin);
end;

class procedure TArrayWork.Mul(Source: array of TDioFloat; var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmMul);
end;

class procedure TArrayWork.SetValue(Value: TDioFloat; var Des: array of TDioFloat);
var i: integer;
begin
  for i := Low(Des) to High(Des) do
    Des[i] := Value;
end;

class procedure TArrayWork.Sub(Source: array of TDioFloat; var Des: array of TDioFloat);
begin
  ArrayCopy(Source,Des,cmSub);
end;

procedure StrToCharArray(const Str: TDioStr; var CharArray: array of TDioChar);
var i: integer;
SIndex: integer;
begin
  SIndex := 1;
  for i := Low(CharArray) to High(CharArray) do
  begin
    if SIndex <= Length(Str) then
      CharArray[i] := Str[SIndex]
    else
      CharArray[i] := #0;
    Inc(SIndex);
  end;
end;

function DioDateToStr(DateTime: TDateTime; LongYear: boolean = false;
  IncludeTime: boolean = true): string;
const
  DioDateFormatS = 'dd.mm.yy';
  DioDateFormatL = 'dd.mm.yyyy';
  DioTimeFormat = 'hh:nn:ss';
var
  FormatStr: string;
begin
  if LongYear then
    FormatStr := DioDateFormatL
  else
    FormatStr := DioDateFormatS;
  if IncludeTime then FormatStr := FormatStr + ' ' + DioTimeFormat;
    DateTimeToString(Result,FormatStr,DateTime);
end;

end.
