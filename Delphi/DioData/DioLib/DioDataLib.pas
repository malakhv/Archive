{******************************************************************************}
{                                                                              }
{                           Dio Data Class Library                             }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit DioDataLib;

interface

uses SysUtils, Classes, MyClasses, DioTypes, DioMassaLib;

type

  { Базовый тип для работы с данными прибора }

  TCustomDioData = class(TPersistent)
  private
    FDate: TDate;
    FHr: byte;
    FData: TDioFloatArray;
    FEnabled: boolean;
    function GetHData: THDataRec;
    function GetHDataEx: THDataExRec;
    function GetHDataF: THDataFRec;
    function GetItem(FieldIndex: integer): TDioFloat;
    procedure SetHData(const Value: THDataRec);
    procedure SetHDataEx(const Value: THDataExRec);
    procedure SetHDataF(const Value: THDataFRec);
    procedure SetItem(FieldIndex: integer; const Value: TDioFloat);
    function GetStrItem(FieldIndex: integer): string;
    procedure SetStrItem(FieldIndex: integer; const Value: string);
    function GetEnabled: boolean;
  protected
    function DoGetItem(const FieldIndex: integer): TDioFloat; virtual;
    function DoGetStrItem(const FieldIndex: integer): string; virtual;
    function DoGetEnabled: boolean; virtual;
    procedure DoSetItem(const FieldIndex: integer; const Value: TDioFloat); virtual;
    procedure DoSetStrItem(const FieldIndex: integer; const Value: string); virtual;
    procedure DataAssign(Source: array of TDioFloat); virtual;
    procedure DataAssignTo(var Des: array of TDioFloat);
  public
    property Date: TDate read FDate write FDate;
    property Hr: byte read FHr write FHr;
    property Item[FieldIndex: integer]: TDioFloat read GetItem write SetItem; default;
    property StrItem[FieldIndex: integer]: string read GetStrItem write SetStrItem;
    property HDataF: THDataFRec read GetHDataF write SetHDataF;
    property HData: THDataRec read GetHData write SetHData;
    property HDataEx: THDataExRec read GetHDataEx write SetHDataEx;
    property Enabled: boolean read GetEnabled write FEnabled;
    procedure Assign(Source: TPersistent); override;
    procedure AssignToStrings(var Strings: TStrings);
    procedure Clear; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

type

  { Статистика }

  { Тип статистики }

  TDioStatisticType = (stNone = 0, stMax = 1, stMin = 2, stSumma = 3, stAverage = 4);

  { Базовый класс для работы со статистикой }

  TDioStatistic = class(TCustomDioData)
  private
    FStatType: TDioStatisticType;
  protected
    procedure SetStat(Source: TDioFloat; var Des: TDioFloat);
    procedure DoSetItem(const FieldIndex: integer; const Value: TDioFloat); override;
    procedure DataAssign(Source: array of TDioFloat); override;
  public
    property StatType: TDioStatisticType read FStatType write FStatType;
    procedure Assign(Source: TPersistent); override;
    constructor Create; override;
  end;

  { Статистика Max }

  TDioStatMax = class(TDioStatistic)
  public
    constructor Create; override;
    procedure Clear; override;
  end;

  { Статистика Min }

  TDioStatMin = class(TDioStatistic)
  public
    procedure Clear; override;
    constructor Create; override;
  end;

  { Статистика Сумма }

  TDioStatSum = class(TDioStatistic)
  protected
    function DoGetStrItem(const FieldIndex: integer): string; override;
  public
    constructor Create; override;
  end;

   { Статистика Среднее значение }

  TDioStatAverage = class(TDioStatistic)
  private
    FElementCount: integer;
    procedure SetElementCount(const Value: integer);
  protected
    function DoGetItem(const FieldIndex: integer): TDioFloat; override;
  public
    property ElementCount: integer read FElementCount write SetElementCount;
    procedure Assign(Source: TPersistent); override;
    constructor Create; override;
  end;

type

  { Данные прибора }

  TCustomDioDataItems = class;

  { Элемент массива данных }

  TCustomDioDataItem = class(TCustomDioData)
  private
    FIndex: integer;
    FOwner: TCustomDioDataItems;
  protected
    function DoGetItem(const FieldIndex: integer): TDioFloat; override;
    function DoGetEnabled: boolean; override;
  public
    property Index: integer read FIndex;
    property Owner: TCustomDioDataItems read FOwner;
    function GetNext: TCustomDioDataItem;
    function GetPrev: TCustomDioDataItem;
    constructor Create(AOwner: TCustomDioDataItems); reintroduce; virtual;
  end;

 { Класс для работы с основными данными прибора и вычисления дополнительных }

  TDioHData = class(TCustomDioDataItem)
  private
    FDioMassa: TDioMassa;
    procedure SetDioMassa(const Value: TDioMassa);
  protected
    function DoGetItem(const FieldIndex: integer): TDioFloat; override;
  public
    property DioMassa: TDioMassa read FDioMassa write SetDioMassa;
    constructor Create(AOwner: TCustomDioDataItems); override;
  end;

  { Класс для работы с полным набором данных прибора }

  TDioHDataEx = class(TCustomDioDataItem)
  public
    constructor Create(AOwner: TCustomDioDataItems); override;
  end;

  { Тип данных прибора (обычные или расширенные) }

  TDioDataType = (dtNone = 0, dtBase = 1, dtHData = 2, dtHDataEx = 3);

  { Массив данных прибора }

  TBaseDioHDataArray = array of TCustomDioDataItem;

  { Класс для работы с массивом данных прибора }

  TCustomDioDataItems = class(TPersistent)
  private
    FItem: TBaseDioHDataArray;
    FDataType: TDioDataType;
    FViewType: TDioViewType;
    FMax: TDioStatMax;
    FMin: TDioStatMin;
    FSum: TDioStatSum;
    FAvarage: TDioStatAverage;
    FOnAdd: TNotifyEvent;
    FCalcEnabled: boolean;
    FDateFilter: boolean;
    FEndDate: TDate;
    FStartDate: TDate;
    function GetCount: integer;
    function GetItem(Index: integer): TCustomDioDataItem;
    procedure SetItem(Index: integer; const Value: TCustomDioDataItem);
    procedure SetAverage(const Value: TDioStatAverage);
    procedure SetMax(const Value: TDioStatMax);
    procedure SetMin(const Value: TDioStatMin);
    procedure SetSum(const Value: TDioStatSum);
    function GetEnabledCount: integer;
  protected
    function DoGetItem(Index: integer): TCustomDioDataItem; virtual;
    procedure DoSetItem(Index: integer; Value: TCustomDioDataItem); virtual;
  public
    property Item[Index: integer]: TCustomDioDataItem read GetItem write SetItem; default;
    property Count: integer read GetCount;
    property EnabledCount: integer read GetEnabledCount;
    property DataType: TDioDataType read FDataType write FDataType;
    property ViewType: TDioViewType read FViewType write FViewType;
    property Max: TDioStatMax read FMax write SetMax;
    property Min: TDioStatMin read FMin write SetMin;
    property Sum: TDioStatSum read FSum write SetSum;
    property Avarage: TDioStatAverage read FAvarage write SetAverage;
    property CalcEnabled: boolean read FCalcEnabled write FCalcEnabled;
    property DateFilter: boolean read FDateFilter write FDateFilter;
    property StartDate: TDate read FStartDate write FStartDate;
    property EndDate: TDate read FEndDate write FEndDate;
    property OnAdd: TNotifyEvent read FOnAdd write FOnAdd;
    function Add(Value: TCustomDioData = nil): integer; overload;
    function Add(Value: THDataFRec): integer; overload;
    function IndexOf(DataItem: TCustomDioDataItem): integer;
    procedure Assign(Source: TPersistent); override;
    procedure Calculate; overload;
    procedure Calculate(StartIndex, EndIndex: integer); overload;
    procedure Clear;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

type

  { Класс для работы с данными CSData }

  TDioCSData = class(TCustomDioData)
  private
    FKData: TCSKArray;
    FSysCfg: byte;
    FRefIndex: byte;
    FHrs: integer;
    FSNum: integer;
    FErrorCode: byte;
    FDioType: byte;
    function GetCSData: TCSDataFRec;
    procedure SetCSData(const Value: TCSDataFRec);
  protected
    function DoGetItem(const FieldIndex: integer): TDioFloat; override;
    function DoGetStrItem(const FieldIndex: integer): string; override;
    procedure DoSetItem(const FieldIndex: integer; const Value: TDioFloat); override;
  public
    property SysCfg: byte read FSysCfg write FSysCfg;
    property RefIndex: byte read FRefIndex write FRefIndex;
    property CSData: TCSDataFRec read GetCSData write SetCSData;
    property Hrs: integer read FHrs write FHrs;
    property SNum: integer read FSNum write FSNum;
    property ErrorCode: byte read FErrorCode write FErrorCode;
    property DioType: byte read FDioType write FDioType;
    procedure Clear; override;
    constructor Create; override;
    destructor Destroy; override;
  end;

type

  { Класс для работы с файлом данных прибора }

  TDioData = class(TCustomFileObject)
  private
    FCSData: TDioCSData;
    FHData: TCustomDioDataItems;
    FWorkData: boolean;
    procedure SetCSData(const Value: TDioCSData);
    procedure SetHData(const Value: TCustomDioDataItems);
    function GetItem(Index, FieldIndex: integer): TDioFloat;
    function GetStrItem(Index, FieldIndex: integer): string;
    function GetArcType: TDioArcType;
    procedure SetArcType(const Value: TDioArcType);
    function GetIsArcDay: boolean;
    function GetIsArcHour: boolean;
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
    function DoSetFileName(const AFileName: TFileName): boolean; override;
  public
    property CSData: TDioCSData read FCSData write SetCSData;
    property HData: TCustomDioDataItems read FHData write SetHData;
    property ArcType: TDioArcType read GetArcType write SetArcType;
    property IsArcHour: boolean read GetIsArcHour;
    property IsArcDay: boolean read GetIsArcDay;
    property WorkData: boolean read FWorkData write FWorkData;
    property Item[Index, FieldIndex: integer]: TDioFloat read GetItem;
    property StrItem[Index, FieldIndex: integer]: string read GetStrItem; default;
    procedure Clear;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

uses Windows, Types, DateUtils, MyStrUtils, DioUtils, DioFieldInfo;

{ TCustomDioData }

procedure TCustomDioData.DataAssign(Source: array of TDioFloat);
begin
  TArrayWork.ArrayCopy(Source,FData);
end;

procedure TCustomDioData.DataAssignTo(var Des: array of TDioFloat);
var i: integer;
begin
  for i := Low(Des) to High(Des) do
    Des[i] := Item[i];
end;

destructor TCustomDioData.Destroy;
begin
  SetLength(FData,0);
  inherited;
end;

function TCustomDioData.DoGetEnabled: boolean;
begin
  Result := FEnabled;
end;

function TCustomDioData.DoGetItem(const FieldIndex: integer): TDioFloat;
begin
  if FieldIndex > High(FData) then
    Result := 0
  else
    Result := FData[FieldIndex];
end;

function TCustomDioData.DoGetStrItem(const FieldIndex: integer): string;
begin
  case FieldIndex of
    iDate: Result := DioDateToStr(Date,false,false);
    iT1, iT2, iT3, iT4, iDT1, iDT2, iTA, iUB:
      Result := FloatToStrF(Item[FieldIndex],ffFixed,5,2);
    iQ, iQ1, iV1, iV2, iV3, iV4, iV5, iDV1, iDV2, iM1, iM2, iM3, iM4, iDM1, iDM2:
      Result := FloatToStrF(Item[FieldIndex],ffFixed,12,2);
    iHr: Result := IntToStr(Hr) + ':00';
  else
    Result := '';
  end;
end;

procedure TCustomDioData.DoSetItem(const FieldIndex: integer; const Value: TDioFloat);
begin
  if ( FieldIndex >= Low(FData) ) and ( FieldIndex <= High(FData) )  then
    FData[FieldIndex] := Value;
end;

procedure TCustomDioData.DoSetStrItem(const FieldIndex: integer; const Value: string);
begin
  Item[FieldIndex] := StrToFloatDef(Value,0);
end;

procedure TCustomDioData.Assign(Source: TPersistent);
begin
  if Assigned(Source) then
    if Source is TCustomDioData then
    begin
      Date := (Source as TCustomDioData).Date;
      Hr := (Source as TCustomDioData).Hr;
      Enabled := (Source as TCustomDioData).Enabled;
      (Source as TCustomDioData).DataAssignTo(FData);
    end;
end;

procedure TCustomDioData.AssignToStrings(var Strings: TStrings);
var i: integer;
begin
  for i := Low(FData) to High(FData) do
    Strings.Add(StrItem[i]);
end;

procedure TCustomDioData.Clear;
begin
  FDate := StrToDate('01.01.2001');
  FHr := 0;
  TArrayWork.Clear(FData);
end;

constructor TCustomDioData.Create;
begin
  inherited;
  SetLength(FData,HDataCount);
  Enabled := true;
  Clear;
end;

function TCustomDioData.GetEnabled: boolean;
begin
  Result := DoGetEnabled;
end;

function TCustomDioData.GetHData: THDataRec;
begin
  Result.Date := TDioStr(DateToStr(FDate));
  Result.Hr := Hr;
  DataAssignTo(Result.HData);
end;

function TCustomDioData.GetHDataEx: THDataExRec;
begin
  TArrayWork.Clear(Result.HDataEx);
  Result.Date := TDioStr(DateToStr(FDate));
  Result.Hr := Hr;
  DataAssignTo(Result.HDataEx);
end;

function TCustomDioData.GetHDataF: THDataFRec;
begin
  // Копирование даты
  StringToCharArray(DateToStr(FDate),Result.Date);
  // Копирование данных
  TArrayWork.ArrayCopy(FData,Result.HData);
  Result.Hr := Hr;
end;

function TCustomDioData.GetItem(FieldIndex: integer): TDioFloat;
begin
  Result := DoGetItem(FieldIndex);
end;

function TCustomDioData.GetStrItem(FieldIndex: integer): string;
begin
  Result := DoGetStrItem(FieldIndex);
end;

procedure TCustomDioData.SetHData(const Value: THDataRec);
begin
  Date := StrToDateDef(String(Value.Date),Date);
  Hr := Value.Hr;
  DataAssign(Value.HData);
end;

procedure TCustomDioData.SetHDataEx(const Value: THDataExRec);
begin
  Date := StrToDateDef(String(Value.Date),SysUtils.Date);
  Hr := Value.Hr;
  DataAssign(Value.HDataEx);
end;

procedure TCustomDioData.SetHDataF(const Value: THDataFRec);
begin
  FDate := StrToDateDef(Trim(CharArrayToString(Value.Date)),SysUtils.Date);
  Hr := Value.Hr;
  DataAssign(Value.HData);
end;

procedure TCustomDioData.SetItem(FieldIndex: integer; const Value: TDioFloat);
begin
  DoSetItem(FieldIndex,Value);
end;

procedure TCustomDioData.SetStrItem(FieldIndex: integer; const Value: string);
begin
  DoSetStrItem(FieldIndex,Value);
end;

{ TDioStatistic }

procedure TDioStatistic.Assign(Source: TPersistent);
begin
  inherited;
  StatType := (Source as TDioStatistic).StatType;
end;

constructor TDioStatistic.Create;
begin
  inherited;
  SetLength(FData,HDataExCount);
  FStatType := stNone;
end;

procedure TDioStatistic.DataAssign(Source: array of TDioFloat);
begin
 case FStatType of
    stNone: inherited;
    stMax: TArrayWork.Max(Source,FData);
    stMin: TArrayWork.Min(Source,FData);
    stSumma, stAverage: TArrayWork.Add(Source,FData);
  end;
end;

procedure TDioStatistic.DoSetItem(const FieldIndex: integer; const Value: TDioFloat);
var AValue: TDioFloat;
begin
  AValue := Item[FieldIndex];
  SetStat(Value,AValue);
  inherited DoSetItem(FieldIndex,AValue);
end;

procedure TDioStatistic.SetStat(Source: TDioFloat; var Des: TDioFloat);
begin
  case FStatType of
    stNone: Des := Source;
    stMax: if Des < Source then Des := Source;
    stMin: if Des > Source then Des := Source;
    stSumma, stAverage: Des := Des + Source;
  end;
end;

{ TDioStatMax }

procedure TDioStatMax.Clear;
begin
  inherited;
  FDate := StrToDate('01.01.2001');
  FHr := 0;
  TArrayWork.SetValue(Low(Integer),FData);
end;

constructor TDioStatMax.Create;
begin
  inherited;
  StatType := stMax;
end;

{ TDioStatMin }

procedure TDioStatMin.Clear;
begin
  FDate := StrToDate('01.01.2001');
  FHr := 0;
  TArrayWork.SetValue(High(Integer),FData);
end;

constructor TDioStatMin.Create;
begin
  inherited;
  StatType := stMin;
end;

{ TDioStatSum }

constructor TDioStatSum.Create;
begin
  inherited;
  StatType := stSumma;
end;

function TDioStatSum.DoGetStrItem(const FieldIndex: integer): string;
begin
  case FieldIndex of
    iT1, iT2, iT3, iT4, iTA, iUB, iDT1, iDT2: Result := '';
  else
    Result := inherited;
  end;
end;

{ TDioStatAverage }

procedure TDioStatAverage.Assign(Source: TPersistent);
begin
  inherited;
  ElementCount := (Source as TDioStatAverage).ElementCount;
end;

constructor TDioStatAverage.Create;
begin
  inherited;
  StatType := stAverage;
  FElementCount := 1;
end;

function TDioStatAverage.DoGetItem(const FieldIndex: integer): TDioFloat;
begin
  Result := inherited / FElementCount;
end;

procedure TDioStatAverage.SetElementCount(const Value: integer);
begin
  if Value > 0 then
    FElementCount := Value;
end;

{ TCustomDioDataItem }

constructor TCustomDioDataItem.Create(AOwner: TCustomDioDataItems);
begin
  inherited Create;
  FOwner := AOwner;
  if FOwner <> nil then
    FIndex := FOwner.Count - 1
  else
    FIndex := -1;
end;

function TCustomDioDataItem.DoGetEnabled: boolean;

  function ValidDate: boolean;
  begin
    // Либо дата лежит в диапазоне, либо фильтр по дате отключен
    Result := ((CompareDate(Date,FOwner.StartDate) <> LessThanValue) and
      (CompareDate(Date,FOwner.EndDate) <> GreaterThanValue)) or not FOwner.DateFilter;
  end;

  function ValidIndex: boolean;
  begin
    Result := ((FOwner.ViewType = vtCurrent) and (Index <> 0)) or (FOwner.ViewType <> vtCurrent);
  end;

begin
  if FOwner = nil then
    Result := inherited
  else
    Result := ValidDate and ValidIndex;
end;

function TCustomDioDataItem.DoGetItem(const FieldIndex: integer): TDioFloat;
begin
  if FOwner.ViewType = vtCurrent then
    case FieldIndex of
      iQ, iQ1, iV1, iV2, iV3, iV4, iV5: Result := inherited - GetPrev.FData[FieldIndex]
    else
      Result := inherited;
    end
  else
    Result := inherited;
end;

function TCustomDioDataItem.GetNext: TCustomDioDataItem;
begin
  if FOwner <> nil then
  begin
    Result := FOwner.Item[Index + 1];
  end else
    Result := nil;
end;

function TCustomDioDataItem.GetPrev: TCustomDioDataItem;
begin
  if FOwner <> nil then
  begin
    Result := FOwner.Item[Index - 1];
  end else
    Result := nil;
end;

{ TDioHData }

constructor TDioHData.Create(AOwner: TCustomDioDataItems);
begin
  inherited;
  FDioMassa := TDioMassa.Create;
end;

function TDioHData.DoGetItem(const FieldIndex: integer): TDioFloat;
begin
  case FieldIndex of
    iM1: Result := FDioMassa.GetMByT(Item[iT1],Item[iV1]);
    iM2: Result := FDioMassa.GetMByT(Item[iT2],Item[iV2]);
    iM3: Result := FDioMassa.GetMByT(Item[iT3],Item[iV3]);
    iM4: Result := FDioMassa.GetMByT(Item[iT4],Item[iV4]);
    iDT1: Result := Item[iT1] - Item[iT2];
    iDT2: Result := Item[iT3] - Item[iT4];
    iDV1: Result := Item[iV1] - Item[iV2];
    iDV2: Result := Item[iV3] - Item[iV4];
    iDM1: Result := Item[iM1] - Item[iM2];
    iDM2: Result := Item[iM3] - Item[iM4];
  else
    Result := inherited;
  end;
end;

procedure TDioHData.SetDioMassa(const Value: TDioMassa);
begin
  if Assigned(Value) then
    FDioMassa.Assign(Value);
end;

{ TDioHDataEx }

constructor TDioHDataEx.Create(AOwner: TCustomDioDataItems);
begin
  inherited;
  SetLength(FData,HDataExCount);
end;


{ TBaseDioHDataCollection }

function TCustomDioDataItems.Add(Value: TCustomDioData): integer;
begin
  Result := Count;
  SetLength(FItem,Result + 1);
  case FDataType of
    dtBase: FItem[Result] := TCustomDioDataItem.Create(Self);
    dtHData: FItem[Result] := TDioHData.Create(Self);
    dtHDataEx: FItem[Result] := TDioHDataEx.Create(Self);
  end;
  FItem[Result].FIndex := Result;
  if Assigned(Value) then FItem[Result].Assign(Value);
  if Assigned(FOnAdd) then FOnAdd(Self);
end;

function TCustomDioDataItems.Add(Value: THDataFRec): integer;
begin
  FItem[Add].HDataF := Value;
  Result := Count - 1;
end;

procedure TCustomDioDataItems.Assign(Source: TPersistent);
var i: integer;
begin
  inherited;
  Clear;
  for i := 0 to (Source as TCustomDioDataItems).Count do
    Add((Source as TCustomDioDataItems).Item[i]);
end;

procedure TCustomDioDataItems.Calculate;
begin
  Calculate(0,Count-1);
end;

procedure TCustomDioDataItems.Calculate(StartIndex, EndIndex: integer);
var i: integer;
    ElCount: integer;
begin
  FMax.Clear;
  FMin.Clear;
  FSum.Clear;
  FAvarage.Clear;
  ElCount := 0;
  for i := StartIndex to EndIndex do
  begin
    if (CalcEnabled and Item[i].Enabled) or (not CalcEnabled) then
    begin
      FMax.HDataEx := Item[i].HDataEx;
      FMin.HDataEx := Item[i].HDataEx;
      if ViewType = vtCurrent then
        FSum.HDataEx := Item[i].HDataEx;
      FAvarage.HDataEx := Item[i].HDataEx;
      Inc(ElCount);
    end;
  end;
  if ViewType <> vtCurrent then
  begin
    FSum.HDataEx := FMax.HDataEx;
    TArrayWork.Sub(FMin.FData,FSum.FData);
  end;
  FAvarage.ElementCount := ElCount;
end;

procedure TCustomDioDataItems.Clear;
var i: integer;
begin
  for i := Low(FItem) to High(FItem) do
    FItem[i].Free;
  SetLength(FItem,0);
end;

constructor TCustomDioDataItems.Create;
begin
  inherited;
  FDataType := dtHData;
  FMax := TDioStatMax.Create;
  FMin := TDioStatMin.Create;
  FSum := TDioStatSum.Create;
  FAvarage := TDioStatAverage.Create;
  FCalcEnabled := true;
  ViewType := vtCurrent;
end;

destructor TCustomDioDataItems.Destroy;
begin
  Clear;
  FMax.Free;
  FMin.Free;
  FSum.Free;
  FAvarage.Free;
  inherited;
end;

function TCustomDioDataItems.DoGetItem(Index: integer): TCustomDioDataItem;
begin
  if (Index >= 0) and (Index < Count) then
    Result := FItem[Index]
  else
    Result := nil;
end;

procedure TCustomDioDataItems.DoSetItem(Index: integer; Value: TCustomDioDataItem);
begin
  FItem[Index].Assign(Value);
end;

function TCustomDioDataItems.GetCount: integer;
begin
  Result := Length(FItem);
end;

function TCustomDioDataItems.GetEnabledCount: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Item[i].Enabled then Inc(Result);
end;

function TCustomDioDataItems.GetItem(Index: integer): TCustomDioDataItem;
begin
  Result := DoGetItem(Index);
end;

function TCustomDioDataItems.IndexOf(DataItem: TCustomDioDataItem): integer;
var i: integer;
begin
  Result := DataItem.Index;
  if Item[Result] <> DataItem then
  begin
    Result := -1;
    for i := 0 to Count - 1 do
      if Item[i] = DataItem then
      begin
        Result := i;
        Break;
      end;
  end;
end;

procedure TCustomDioDataItems.SetAverage(const Value: TDioStatAverage);
begin
  if Assigned(Value) then
    FAvarage.Assign(Value);
end;

procedure TCustomDioDataItems.SetItem(Index: integer;
  const Value: TCustomDioDataItem);
begin
  if Assigned(Value) then
    DoSetItem(Index,Value);
end;

procedure TCustomDioDataItems.SetMax(const Value: TDioStatMax);
begin
  if Assigned(Value) then
    FMax.Assign(Value);
end;

procedure TCustomDioDataItems.SetMin(const Value: TDioStatMin);
begin
  if Assigned(Value) then
    FMin.Assign(Value);
end;

procedure TCustomDioDataItems.SetSum(const Value: TDioStatSum);
begin
  if Assigned(Value) then
    FSum.Assign(Value);
end;

{ TDioCSData }

procedure TDioCSData.Clear;
begin
  inherited;
  TArrayWork.Clear(FKData);
end;

constructor TDioCSData.Create;
begin
  inherited;
  SetLength(FData,CSDataCount);
  Clear;
end;

destructor TDioCSData.Destroy;
begin
  Clear;
  inherited;
end;

function TDioCSData.DoGetItem(const FieldIndex: integer): TDioFloat;
begin
  case FieldIndex of
    iDT1: Result := Item[iT1] - Item[iT2];
    iDT2: Result := Item[iT3] - Item[iT4];
    iDV1: Result := Item[iV1] - Item[iV2];
    iDV2: Result := Item[iV3] - Item[iV4];
    iDM1: Result := Item[iM1] - Item[iM2];
    iDM2: Result := Item[iM3] - Item[iM4];
    iK1: Result := FKData[0];
    iK2: Result := FKData[1];
    iK3: Result := FKData[2];
    iK4: Result := FKData[3];
    iK5: Result := FKData[4];
    iM1: Result := FData[11];
    iM2: Result := FData[12];
    iM3: Result := FData[13];
    iM4: Result := FData[14];
    iTA: Result := FData[15];
    iUB: Result := FData[16];
  else
    Result := inherited;
  end;
end;

function TDioCSData.DoGetStrItem(const FieldIndex: integer): string;
begin
  case FieldIndex of
    iK1, iK2, iK3, iK4, iK5: Result := FloatToStrF(Item[FieldIndex],ffFixed,5,2);
  else
    Result := inherited;
  end;
end;

procedure TDioCSData.DoSetItem(const FieldIndex: integer; const Value: TDioFloat);
begin
  case FieldIndex of
    iK1: FKData[0] := Value;
    iK2: FKData[1] := Value;
    iK3: FKData[2] := Value;
    iK4: FKData[3] := Value;
    iK5: FKData[4] := Value;
    iM1: FData[11] := Value;
    iM2: FData[12] := Value;
    iM3: FData[13] := Value;
    iM4: FData[14] := Value;
    iTA: FData[15] := Value;
    iUB: FData[16] := Value;
  else
    inherited;
  end;
end;

function TDioCSData.GetCSData: TCSDataFRec;
begin
  Result.ArchiveDate := Date;
  TArrayWork.ArrayCopy(FData,Result.CSData);
  TArrayWork.ArrayCopy(FKData,Result.KData);
  Result.SysCfg := SysCfg;
  Result.RefIndex := RefIndex;
  Result.Hrs := Hrs;
  Result.SNum := SNum;
  Result.ErrorCode := FErrorCode;
  Result.DioType := DioType;
end;

procedure TDioCSData.SetCSData(const Value: TCSDataFRec);
begin
  Date := Value.ArchiveDate;
  TArrayWork.ArrayCopy(Value.CSData,FData);
  TArrayWork.ArrayCopy(Value.KData,FKData);
  SysCfg := Value.SysCfg;
  RefIndex := Value.RefIndex;
  Hrs := Value.Hrs;
  SNum := Value.SNum;
  ErrorCode := Value.ErrorCode;
  DioType := Value.DioType;
end;

{ TDioData }

procedure TDioData.Clear;
begin
  FCSData.Clear;
  FHData.Clear;
end;

constructor TDioData.Create;
begin
  inherited;
  FCSData := TDioCSData.Create;
  FHData := TCustomDioDataItems.Create;
  FWorkData := true;
end;

destructor TDioData.Destroy;
begin
  FCSData.Free;
  FHData.Free;
  inherited;
end;

function TDioData.DoLoadFromFile(const AFileName: TFileName): boolean;
var MyFile: integer;
    AHDataF: THDataFRec;
    ACSDataF: TCSDataFRec;
begin
  Result := true;
  FCSData.Clear;
  FHData.Clear;
  try
    MyFile := FileOpen(AFileName, fmOpenRead);
    if FileRead(MyFile, ACSDataF, CSDataFRecSize) = CSDataFRecSize then
      FCSData.CSData := ACSDataF;
    while true and FWorkData do
      if FileRead(MyFile, AHDataF, HDataFRecSize) = HDataFRecSize then
        FHData.Add(AHDataF)
      else
        Break;
    FileClose(MyFile);
  except
    Result := false;
  end;
end;

function TDioData.DoSaveToFile(const AFileName: TFileName): boolean;
var MyFile, i: integer;
    AHDataF: THDataFRec;
    ACSDataF: TCSDataFRec;
begin
  Result := false;
  i := 0;
  MyFile := FileCreate(AFileName);
  if MyFile = -1 then Exit;
  ACSDataF := FCSData.CSData;
  if FileWrite(MyFile, ACSDataF, CSDataFRecSize) <> CSDataFRecSize then
    Exit;
  if FWorkData then
    for i := 0 to FHData.Count - 1 do
    begin
      AHDataF := FHData[i].HDataF;
      if FileWrite(MyFile, AHDataF, HDataFRecSize) <> HDataFRecSize then Break;
    end;
  FileClose(MyFile);
  if (i = FHData.Count - 1) or ( not FWorkData) then Result := true;
end;

function TDioData.DoSetFileName(const AFileName: TFileName): boolean;
begin
  Result := inherited or true;
end;

function TDioData.GetArcType: TDioArcType;
begin
  if FCSData.SysCfg > 2 then
    Result := atHour
  else
    Result := atDay;
end;

function TDioData.GetIsArcDay: boolean;
begin
  Result := ArcType = atDay;
end;

function TDioData.GetIsArcHour: boolean;
begin
  Result := ArcType = atHour;
end;

function TDioData.GetItem(Index, FieldIndex: integer): TDioFloat;
begin
  Result := HData[Index][FieldIndex];
end;

function TDioData.GetStrItem(Index, FieldIndex: integer): string;
begin
  Result := HData[Index].StrItem[FieldIndex];
end;

procedure TDioData.SetArcType(const Value: TDioArcType);
begin
  FCSData.SysCfg := Byte(Value);
end;

procedure TDioData.SetCSData(const Value: TDioCSData);
begin
  if Assigned(Value) then FCSData.Assign(VAlue);
end;

procedure TDioData.SetHData(const Value: TCustomDioDataItems);
begin
  if Assigned(Value) then FHData.Assign(Value);
end;

end.
