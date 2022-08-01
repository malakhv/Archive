unit OSMPLog;

interface

uses SysUtils, MyLog;

type

  TLogType = (ltNone = 0, ltWait = 1, ltApp = 2, ltUpdt = 3);

const

  { Строковые константы для добавления информаци в лог файл }

  { Лог Приложения }

  lAppError = 'Ошибка приложения: ';
  lAppStart = 'Приложение запущено';
  lAppEnd = 'Завершение работы';
  lAppLoadLibrError = 'Ошибка загрузки библотеки';

  { Лог Обновления }

  lUpdtOK = 'Update OK';
  lUpdtError = 'Update Error';
  lUpdtEnabled = 'Обновления найдены';
  lUpdtDisabled = 'Обновления не найдены';

  { Лог Наблдения }

  lWaitStart = 'Wait Start';
  lWaitStartError = 'Wait Start Error';
  lWaitStop = 'Wait Stop';
  lWaitStopError = 'Wait Stop Error';
  lFileCopy = 'File Copy ';
  lCopyError = 'Copy Error ';
  lFileListNotFound = 'FileList not found';

type
  TOSMPLog = class(TCustomLog)
  private
    ELogType: TLogType;
    ELogDir: TFileName;
    procedure SetLogDir(const Value: TFileName);
    procedure SetLogType(const Value: TLogType);
    function GetLogName: string;
  protected
    function GetFileName(ALogType: TLogType): TFileName;
  public
    property LogDir: TFileName read ELogDir write SetLogDir;
    property LogType: TLogType read ELogType write SetLogType;
    property LogName: string read GetLogName;
    procedure Add(ALogType: TLogType; Str: string); overload;
    constructor Create(ALogDir: TFileName = '');
  end;

implementation

const

  LogFiles: array[0..3] of TFileName = ('', 'wait.log', 'app.log', 'updt.log');
  LogNames: array[0..3] of string = ('', 'Наблюдение', 'Приложение', 'Обновление');

{ TOSMPLog }

procedure TOSMPLog.Add(ALogType: TLogType; Str: string);
begin
  LogType := ALogType;
  Add(Str);
end;

constructor TOSMPLog.Create(ALogDir: TFileName);
begin
  inherited Create();
  AutoLoad := true;
  AutoSave := true;
  ELogType := ltNone;
  if ALogDir <> '' then LogDir := ALogDir;
end;

function TOSMPLog.GetFileName(ALogType: TLogType): TFileName;
begin
  Result := LogDir + LogFiles[Integer(ALogType)];
end;

function TOSMPLog.GetLogName: string;
begin
  Result := LogNames[Integer(ELogType)];
end;

procedure TOSMPLog.SetLogDir(const Value: TFileName);
begin
  if DirectoryExists(Value) then
  begin
    ELogDir := Value;
    if LogType <> ltNone then
      FileName := GetFileName(ELogType);
  end else
    Exception.Create('Папка не найдена');
end;

procedure TOSMPLog.SetLogType(const Value: TLogType);
begin
  ELogType := Value;
  if LogType <> ltNone then
    FileName := GetFileName(ELogType)
end;

end.
