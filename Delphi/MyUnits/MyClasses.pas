unit MyClasses;

interface

uses SysUtils, Classes;

type

  { Базовый объект для работы с файлом данных }

  TFileObject = class(TPersistent)
  private
    { Внутренние поля }
    FFileName: TFileName;
    FAutoLoad: boolean;
    FAutoSave: boolean;
    { События }
    FOnLoad: TNotifyEvent;
    FOnSave: TNotifyEvent;
    { Методы доступа к свойствам }
    procedure SetFileName(const Value: TFileName);
    function GetFileName: TFileName;
  protected
    { Функции сохранения и загрузки данных }
    function DoLoadFromFile(const AFileName: TFileName): boolean; virtual; abstract;
    function DoSaveToFile(const AFileName: TFileName): boolean; virtual; abstract;
    { Работа с именем файла }
    function DoGetFileName: TFileName; virtual;
    function DoSetFileName(const AFileName: TFileName): boolean; virtual;
    { Маршрутизаторы событий }
    procedure DoLoad; virtual;
    procedure DoSave; virtual;
  public
    { Автозагрузка при измернении свойства FileName }
    property AutoLoad: boolean read FAutoLoad write FAutoLoad;
    { Автосохранение при загрузке из файла }
    property AutoSave: boolean read FAutoSave write FAutoSave;
    { Имя файла }
    property FileName: TFileName read GetFileName write SetFileName;
    { Событие при загрузке из файла }
    property OnLoad: TNotifyEvent read FOnLoad write FOnLoad;
    { Событие при сохранении в файл }
    property OnSave: TNotifyEvent read FOnSave write FOnSave;
    { Быстрая загрузка из файла (используется свойство FileName) }
    function Load: boolean;
    { Быстрое сохранение в файл (используется свойство FileName) }
    function Save: boolean;
    { Загрузка из файла AFileName, свойству FileName присваевается значение AFileName }
    function LoadFromFile(const AFileName: TFileName): boolean;
    { Сохранение в файл AFileName. Eсли свойство FileName = '',
      ему присваевается значение AFileName }
    function SaveToFile(const AFileName: TFileName): boolean;
    procedure Assign(Source: TPersistent); override;
    { Обновление данных (Генерация события OnLoad) }
    procedure Update; virtual;
    constructor Create; overload; virtual;
    constructor Create(AFileName: TFileName; AAutoLoad: boolean = true;
      AAutoSave: boolean = true); overload;
  end;

  { Типы и классы для работы с версиями }

const
  INVALID_VER_NUMBER = 0;

type

  TVersionType = (vtNone = 0, vtDate = 1, vtNumber = 2, vtAll = 3);

  TVersion = class(TFileObject)
  private
    FVerDate: TDateTime;
    FVerNumber: integer;
    FIsVerDate: boolean;
    FIsVerNumber: boolean;
    FAutoEnabled: boolean;
    function GetVerDate: TDateTime;
    function GetVerNumber: integer;
    function GetVerType: TVersionType;
    procedure SetVerDate(const Value: TDateTime);
    procedure SetVerNumber(const Value: integer);
    procedure SetVerType(const Value: TVersionType);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property VerDate: TDateTime read GetVerDate write SetVerDate;
    property VerNumber: integer read GetVerNumber write SetVerNumber;
    property VerType: TVersionType read GetVerType write SetVerType;
    property IsVerDate: boolean read FIsVerDate write FIsVerDate;
    property IsVerNumber: boolean read FIsVerNumber write FIsVerNumber;
    property AutoEnabled: boolean read FAutoEnabled write FAutoEnabled;
    procedure Generate;
    procedure Clear;
    constructor Create; override;
  end;

implementation

uses Windows;

{ TCustomFileObject }

procedure TFileObject.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TFileObject then
    FileName := TFileObject(Source).FileName;
end;

constructor TFileObject.Create;
begin
  inherited;
  FAutoLoad := true;
  FAutoSave := false;
  FFileName := '';
end;

constructor TFileObject.Create(AFileName: TFileName; AAutoLoad: boolean; AAutoSave: boolean);
begin
  Create;
  FAutoLoad := AAutoLoad;
  FAutoSave := AAutoSave;
  FileName := AFileName;
end;


function TFileObject.DoGetFileName: TFileName;
begin
  Result := FFileName;
end;

procedure TFileObject.DoLoad;
begin
  if Assigned(FOnLoad) then FOnLoad(Self);
end;

procedure TFileObject.DoSave;
begin
  if Assigned(FOnSave) then FOnSave(Self);
end;

function TFileObject.DoSetFileName(const AFileName: TFileName): boolean;
begin
  Result := true;
  if FFileName <> AFileName then FFileName := AFileName;
end;

function TFileObject.GetFileName: TFileName;
begin
  Result := DoGetFileName;
end;

function TFileObject.Load: boolean;
begin
  Result := LoadFromFile(FileName);
end;

function TFileObject.LoadFromFile(const AFileName: TFileName): boolean;
begin
  Result := false;
  { Если автосохранение - сначало сохраняем }
  if AutoSave then Save;
  if FileExists(AFileName) then
    if DoLoadFromFile(AFileName) then
    begin
      Result := true;
      if DoSetFileName(AFileName) then DoLoad;
    end
  else
    Exception.Create('Неверное имя файла');
end;

function TFileObject.Save: boolean;
begin
  Result := SaveToFile(FileName);
end;

function TFileObject.SaveToFile(const AFileName: TFileName): boolean;
begin
  Result := false;
  if FileName = '' then Exit;
  if DoSaveToFile(AFileName) then
  begin
    //if FileName = '' then DoSetFileName(AFileName);
    Result := true;
  end;
end;

procedure TFileObject.SetFileName(const Value: TFileName);
begin
  DoSetFileName(Value);
  if AutoLoad and FileExists(FileName) then Load;
end;

procedure TFileObject.Update;
begin
  DoLoad;
end;

{ TVersion }

procedure TVersion.Clear;
begin
  FVerDate := Now;
  FVerNumber := INVALID_VER_NUMBER;
end;

constructor TVersion.Create;
begin
  inherited;
  AutoEnabled := false;
  IsVerDate := false;
  IsVerNumber := true;
end;

function TVersion.DoLoadFromFile(const AFileName: TFileName): boolean;
var MyFile: integer;
    vTp: TVersionType;
begin
  Result := false;
  Clear;
  MyFile := FileOpen(AFileName,fmOpenRead);
  try
    if MyFile > 0 then
    begin
      FileRead(MyFile,vTp,SizeOf(TVersionType));
      VerType := vTp;
      if IsVerDate then
        FileRead(MyFile,FVerDate,SizeOf(FVerDate));
      if IsVerNumber then
        FileRead(MyFile,FVerNumber,SizeOf(FVerNumber));
      Result := true;
    end;
  finally
    FileClose(MyFile);
  end;
end;

function TVersion.DoSaveToFile(const AFileName: TFileName): boolean;
var MyFile: integer;
    vTp: TVersionType;
begin
  Result := false;
  MyFile := FileCreate(AFileName);
  try
    if MyFile > 0 then
    begin
      vTp := VerType;
      FileWrite(MyFile,vTp,SizeOf(TVersionType));
      if IsVerDate then
        FileWrite(MyFile,FVerDate,SizeOf(FVerDate));
      if IsVerNumber then
        FileWrite(MyFile,FVerNumber,SizeOf(FVerNumber));
      Result := true;
    end;
  finally
    FileClose(MyFile);
  end;
end;

procedure TVersion.Generate;
var DateTmp: TDateTime;
begin
  Clear;
  DateTmp := Now;
  if IsVerDate then
    VerDate := DateTmp;
  if IsVerNumber then
    VerNumber := DateTimeToFileDate(DateTmp);
end;

function TVersion.GetVerDate: TDateTime;
begin
  if IsVerDate then
    Result := FVerDate
  else
    Result := Now;
end;

function TVersion.GetVerNumber: integer;
begin
  if IsVerNumber then
    Result := FVerNumber
  else
    Result := INVALID_VER_NUMBER;
end;

function TVersion.GetVerType: TVersionType;
begin
  Result := TVersionType(Integer(IsVerDate) +
    (Integer(IsVerNumber) + 1)*Integer(IsVerNumber));
end;

procedure TVersion.SetVerDate(const Value: TDateTime);
begin
  FVerDate := Value;
  IsVerDate := IsVerDate or AutoEnabled;
end;

procedure TVersion.SetVerNumber(const Value: integer);
begin
  IsVerNumber := (Value <> INVALID_VER_NUMBER) and (IsVerNumber or AutoEnabled);
  FVerNumber := Value;
end;

procedure TVersion.SetVerType(const Value: TVersionType);
begin
  IsVerDate := (Value = vtDate) or (Value = vtAll);
  IsVerNumber := (Value = vtNumber) or (Value = vtAll);
end;

end.
