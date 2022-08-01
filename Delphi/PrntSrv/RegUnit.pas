unit RegUnit;

interface

uses Registry;

type
  TRMode = (rmNone = 0, rmRead = 1, rmWrite = 2, rmReadOrWrite = 3);

type
  TFName = string[100];

type
  TRegOptions = record
    UDB: TDateTime;
    DBPath: TFName;
    DBFileName: TFName;
  end;

type
  TMyReg = class(TObject)
  private
    FReg: TRegistry;
    FRMode: TRMode;
    FRegOptions: TRegOptions;
    function GetDBPath: string;
    procedure SetDBPath(const Value: string);
    function GetUDBDate: TDateTime;
    procedure SetUDBDate(const Value: TDateTime);
    function GetDBFileName: string;
    procedure SetDBFileName(const Value: string);

  public
    property RMode: TRMode read FRMode;
    property DBPath: string read GetDBPath write SetDBPath;
    property DBFileName: string read GetDBFileName write SetDBFileName;
    property UDBDate: TDateTime read GetUDBDate write SetUDBDate;
    procedure LoadOptions;
    procedure SaveOptions;
    constructor Create(ARMode: TRMode; AutoLoad: boolean = true);
    destructor Destroy; override;
  end;

implementation

uses Windows,SysUtils, DateUtils;

const
  rDBPath     = 'DBPath';
  rDBFileName = 'DBFileName';
  rUDBDate    = 'UDBDate';
  RKey  = '\Software\MSoft\PrntSrvc';

{ TMyReg }

constructor TMyReg.Create(ARMode: TRMode; AutoLoad: boolean = true);
begin
  inherited Create;
  FRMode := ARMode;
  if AutoLoad then LoadOptions;
end;

destructor TMyReg.Destroy;
begin
  inherited;
end;

function TMyReg.GetDBPath: string;
begin
  Result := FRegOptions.DBFileName;
end;

procedure TMyReg.LoadOptions;
begin
  if (FRMode = rmRead)or(FRMode = rmReadOrWrite) then
  begin
    // Чтение данных из реестра
    FReg := TRegistry.Create;
    try
      FReg.RootKey := HKEY_LOCAL_MACHINE;
      if FReg.OpenKey(RKey,false) then
      begin
        FRegOptions.DBFileName := FReg.ReadString(rDBPath);
        FRegOptions.DBFileName := FReg.ReadString(rDBFileName);
        FRegOptions.UDB := FReg.ReadDate(rUDBDate);
        FReg.CloseKey;
      end;
    finally
      FReg.Free;
    end;
  end;
end;

procedure TMyReg.SaveOptions;
begin
  if (FRMode = rmWrite)or(FRMode = rmReadOrWrite) then
  begin
    // Запись данных в реестр
    FReg := TRegistry.Create;
    try
      FReg.RootKey := HKEY_LOCAL_MACHINE;
      // Если такого раздела нет, то он будет создан
      if FReg.OpenKey(RKey,true) then
      begin
        FReg.WriteString(rDBPath,FRegOptions.DBPath);
        FReg.WriteString(rDBFileName,FRegOptions.DBFileName);
        FReg.WriteDate(rUDBDate,FRegOptions.UDB);
        FReg.CloseKey;
      end;
    finally
      FReg.Free;
    end;
  end;
end;

procedure TMyReg.SetDBPath(const Value: string);
begin
  if (FRMode = rmWrite)or(FRMode = rmReadOrWrite) then
    FRegOptions.DBPath := Value;
end;

function TMyReg.GetUDBDate: TDateTime;
begin
  if (FRMode = rmRead) or (FRMode = rmReadOrWrite) then
    Result := FRegOptions.UDB;
end;

procedure TMyReg.SetUDBDate(const Value: TDateTime);
begin
  if (FRMode = rmWrite)or(FRMode = rmReadOrWrite) then
    FRegOptions.UDB := DateOf(Value);
end;

function TMyReg.GetDBFileName: string;
begin
  if (FRMode = rmRead) or (FRMode = rmReadOrWrite) then
    Result := FRegOptions.DBFileName;
end;

procedure TMyReg.SetDBFileName(const Value: string);
begin
  if Trim(Value) = '' then Exit;
  if (FRMode = rmWrite)or(FRMode = rmReadOrWrite) then
    FRegOptions.DBFileName := Value;
end;

end.
