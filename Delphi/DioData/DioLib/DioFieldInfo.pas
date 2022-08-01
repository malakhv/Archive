unit DioFieldInfo;

interface

uses DioTypes;

const

  { Индексы группы данных HData }

  iNone = -1;
  iDate = 23; iHr  = 24;
  iQ = 0;  iQ1 = 1;  iT1 = 2;  iT2 = 3;  iT3 = 4; iT4 = 5; iV1 = 6;
  iV2 = 7;   iV3 = 8; iV4 = 9; iV5 = 10; iTA = 11; iUB = 12;

  { Индексы группы данных HDataEx }

  iM1 = 13;  iM2 = 14; iM3 = 15; iM4 = 16; iDT1 = 17; iDT2 = 18; iDV1 = 19;
  iDV2 = 20; iDM1 = 21; iDM2 = 22;

  { Индексы группы данных К }

  iK1 = iHr + 1; iK2 = iK1 + 1; iK3 = iK2 + 1; iK4 = iK3 + 1; iK5 = iK4 + 1;

  { Имена полей данных групп HData, HDataEx и CSData }

  nDate = 'Date'; nHr = 'Hr';   nQ  = 'Q';    nQ1 = 'Q1';   nT1 = 'T1';
  nT2 = 'T2';     nT3 = 'T3';   nT4 = 'T4';   nV1 = 'V1';   nV2 = 'V2';
  nV3 = 'V3';     nV4 = 'V4';   nV5 = 'V5';   nTA = 'TA';   nUB = 'UB';
  nM1 = 'M1';     nM2 = 'M2';   nM3 = 'M3';   nM4 = 'M4';   nDT1 = 'DT1';
  nDT2 = 'DT2';   nDV1 = 'DV1'; nDV2 = 'DV2'; nDM1 = 'DM1'; nDM2 = 'DM2';

  { Имена полей данных группы K }

  nK1 = 'K1'; nK2 = 'K2'; nK3 = 'K3'; nK4 = 'K4'; nK5 = 'K5';

const

  { Надписи }

  cDate = 'Дата/Час.';  cHr = 'Hr';     cQ  = 'Q';      cQ1 = 'Q1';     cT1 = 'T1';
  cT2 = 'T2';           cT3 = 'T3';     cT4 = 'T4';     cV1 = 'V1';     cV2 = 'V2';
  cV3 = 'V3';           cV4 = 'V4';     cV5 = 'V5';     cTA = 'TA';     cUB = 'UB';
  cM1 = 'M1';           cM2 = 'M2';     cM3 = 'M3';     cM4 = 'M4';     cDT1 = 'T1-T2';
  cDT2 = 'T3-T4';       cDV1 = 'V1-V2'; cDV2 = 'V3-V4'; cDM1 = 'M1-M2'; cDM2 = 'M3-M4';

  cK1 = 'K1'; cK2 = 'K2'; cK3 = 'K3'; cK4 = 'K4'; cK5 = 'K5';

  { Функция возвращает строковое имя поля данных по индексу }

  function DioFieldToStr(AFieldIndex: integer): string;

  { Функция возвращает номер поля данных по строковому индексу }

  function StrToDioField(Srt: string): integer;

  { Функция возвращает надпись поля данных по индексу }

  function GetFieldCaption(AFieldIndex: integer): string;

implementation

type

  {Тип для описания имен полей данных в таблице}

  TDioFieldNames = array[0..AllDataCount - 1] of TDioStr;

const

  { Имена полей данных - связь с индексами DioDataFieldName[iQ] = nQ }

  DioFieldNames: TDioFieldNames = ( nQ, nQ1, nT1, nT2, nT3, nT4, nV1, nV2, nV3, nV4, nV5,
    nTA, nUB, nM1, nM2, nM3, nM4, nDT1, nDT2, nDV1, nDV2, nDM1, nDM2, nDate, nHr, nK1,
    nK2, nK3, nK4, nK5 );

  { Надписи полей данных }

  DioFieldCapions: TDioFieldNames = ( cQ, cQ1, cT1, cT2, cT3, cT4, cV1, cV2, cV3, cV4, cV5,
    cTA, cUB, cM1, cM2, cM3, cM4, cDT1, cDT2, cDV1, cDV2, cDM1, cDM2, cDate, cHr, cK1,
    cK2, cK3, cK4, cK5 );

function DioFieldToStr(AFieldIndex: integer): string;
begin
  if (AFieldIndex >= Low(DioFieldNames)) and (AFieldIndex <= High(DioFieldNames)) then
    Result := String(DioFieldNames[AFieldIndex])
  else
    Result := '';
end;

function StrToDioField(Srt: string): integer;
var i: integer;
begin
  Result := -1;
  for i := Low(DioFieldNames) to High(DioFieldNames) do
    if String(DioFieldNames[i]) = Srt then
    begin
      Result := i;
      break;
    end;
end;

function GetFieldCaption(AFieldIndex: integer): string;
begin
  if (AFieldIndex >= Low(DioFieldCapions)) and (AFieldIndex <= High(DioFieldCapions)) then
    Result := String(DioFieldCapions[AFieldIndex])
  else
    Result := '';
end;

end.
