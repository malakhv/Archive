
{******************************************************************************}
{                                                                              }
{                           Dio Data Class Library                             }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit DioMassaLib;

interface

uses SysUtils, Classes, MyClasses,  DioTypes;

type

  { Класс для работы с файлом, содержащим информацию о зависимости плотности
    воды от её температуры }

  TRList = class(TCustomFileObject)
  private
    EData: TDioFloatArray;
    ET1: TDioFloat;
    ET2: TDioFloat;
    EDT: TDioFloat;
    function GetItem(Index: integer): TDioFloat;
    function GetVCount: integer;
    procedure SetItem(Index: integer; const Value: TDioFloat);
    function GetTCount: integer;
    procedure SetTCount(const Value: integer);
    function GetT(Index: integer): TDioFloat;
  protected
    function GetIndexByT(AT: TDioFloat): integer;
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property T1: TDioFloat read ET1 write ET1;
    property T2: TDioFloat read ET2 write ET2;
    property DT: TDioFloat read EDT write EDT;
    property Item[Index: integer]: TDioFloat read GetItem write SetItem; default;
    property T[Index: integer]: TDioFloat read GetT;
    property VCount: integer read GetVCount;
    property TCount: integer read GetTCount write SetTCount;
    function Add: integer; overload;
    function Add(Value: TDioFloat): integer; overload;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    constructor Create; override;
    destructor Destroy; override;
  end;

  { Класс для расчета массы по показаниям температуры (T) и обьема (V) }

  TDioMassa = class(TRList)
  private
    function GetRo(AT: TDioFloat): TDioFloat;
    procedure SetRo(AT: TDioFloat; const Value: TDioFloat);
  public
    property Ro[AT: TDioFloat]: TDioFloat read GetRo write SetRo;
    function GetMByT(AT,AV: TDioFloat): TDioFloat;
    function GetMByRo(ARo,AV: TDioFloat): TDioFloat;
  end;

implementation

uses Windows, Math, DioUtils;

procedure FPUInit;
{ Инициализация математического сопроцессора }
asm
  fninit;
end;

{ TRList }

function TRList.Add: integer;
begin
  Result := VCount;
  SetLength(EData,Result + 1);
end;

function TRList.Add(Value: TDioFloat): integer;
begin
  EData[Add] := Value;
  Result := VCount - 1;
end;

procedure TRList.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TRList then
    with TRList(Source) do
    begin
      TArrayWork.ArrayCopy(EData,Self.EData);
      Self.T1 := T1;
      Self.T2 := T2;
      Self.DT := DT;
    end;
end;

procedure TRList.Clear;
begin
  SetLength(EData,0);
end;

constructor TRList.Create;
begin
  inherited;
  T1 := 0;
  T2 := 100;
  DT := 1;
end;

destructor TRList.Destroy;
begin
  Clear;
  inherited;
end;

function TRList.DoLoadFromFile(const AFileName: TFileName): boolean;
var MyFile: integer;

  function ReadData(var Des: TDioFloat): boolean;
  var Buf: TDioFloat;
  begin
    Result := true;
    if FileRead(MyFile,Buf,ElementSize) = ElementSize then
      Des := Buf
    else
      Result := false;
  end;

var Buf: TDioFloat;

begin
  Result := false;
  Clear;
  MyFile := FileOpen(AFileName,fmOpenRead);
  if not ( ReadData(ET1) and ReadData(ET2) and ReadData(EDT) ) then
    Exit;
  while ReadData(Buf) do
    EData[Add] := Buf;
  FileClose(MyFile);
  Result := true;
end;

function TRList.DoSaveToFile(const AFileName: TFileName): boolean;
var MyFile, i: integer;

  function WriteData(const Source: TDioFloat): boolean;
  begin
    if FileWrite(MyFile,Source,ElementSize) = ElementSize then
      Result := true
    else
      Result := false;
  end;

begin
  Result := false;
  MyFile := FileCreate(AFileName);
  if MyFile = -1 then Exit;
  if not ( WriteData(T1) and WriteData(T2) and WriteData(DT) ) then
    Exit;
  for i := System.Low(EData) to System.High(EData) do
    if not WriteData(EData[i]) then
      break;
  FileClose(MyFile);
  Result := true;
end;

function TRList.GetVCount: integer;
begin
  Result := Length(EData);
end;

function TRList.GetIndexByT(AT: TDioFloat): integer;
begin
  FPUInit;
  Result := Round( (AT - T1) / DT );
  if Result < 0 then
    Result := 0;
  if Result > VCount - 1 then
    Result := VCount - 1;
end;

function TRList.GetItem(Index: integer): TDioFloat;
begin
  if Index >= 0 then
    Result := EData[Index]
  else
    Result := 0;
end;

function TRList.GetT(Index: integer): TDioFloat;
begin
  if (Index >= 0) and (Index < VCount) then
    Result := T1 + Index * DT
  else
    Result := TError;
end;

function TRList.GetTCount: integer;
begin
  Result := Ceil( (T2 - T1) / DT );
end;

procedure TRList.SetItem(Index: integer; const Value: TDioFloat);
begin
  EData[Index] := Value;
end;

procedure TRList.SetTCount(const Value: integer);
begin
  if Value >= 0 then
    T2 := T1 + Value * DT;
end;

{ TDioMassa }

function TDioMassa.GetMByRo(ARo, AV: TDioFloat): TDioFloat;
begin
  Result := ARo * AV;
end;

function TDioMassa.GetMByT(AT, AV: TDioFloat): TDioFloat;
begin
  FPUInit;
  Result := (987.56 * AV) / 1000;
  //Result := GetMByRo(Ro[AT],AV);
end;

function TDioMassa.GetRo(AT: TDioFloat): TDioFloat;
begin
  Result := Item[GetIndexByT(AT)];
end;

procedure TDioMassa.SetRo(AT: TDioFloat; const Value: TDioFloat);
begin
  Item[GetIndexByT(AT)] := Value;
end;


end.
