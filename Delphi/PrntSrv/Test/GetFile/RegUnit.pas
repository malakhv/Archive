unit RegUnit;

interface

uses Registry;

type
  TRMode = (rmNone = 0, rmRead = 1, rmWrite = 2, rmReadOrWrite = 3);

type
  TRegOptions = record
    DBFileName: string;
  end;

type
  TMyReg = class(TObject)
  private
    FReg: TRegistry;
    FRMode: TRMode;
    FRegOptions: TRegOptions;
    function GetDBPath: string;
    procedure SetDBPath(const Value: string);

  public
    property RMode: TRMode read FRMode;
    property DBPath: string read GetDBPath write SetDBPath;
    procedure LoadOptions;
    procedure SaveOptions;
    constructor Create(ARMode: TRMode; AutoLoad: boolean = true);
    destructor Destroy; override;
  end;

implementation

uses Windows;

const
  PrDBPath = 'DBPath';
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
        FRegOptions.DBFileName := FReg.ReadString(PrDBPath);
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
        FReg.WriteString(PrDBPath,FRegOptions.DBFileName);
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
    FRegOptions.DBFileName := Value;
end;

end.
