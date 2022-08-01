unit ShellNotify;

interface

uses
  Windows, SysUtils,  Classes;

const

  { File Notify Change }

  fncFileName = FILE_NOTIFY_CHANGE_FILE_NAME;
  fncDirName = FILE_NOTIFY_CHANGE_DIR_NAME;
  fncAttributes = FILE_NOTIFY_CHANGE_ATTRIBUTES;
  fncSize = FILE_NOTIFY_CHANGE_SIZE;
  fncLastWrite = FILE_NOTIFY_CHANGE_LAST_WRITE;
  fncSecurity = FILE_NOTIFY_CHANGE_SECURITY;

type

  { тип для хранения значений фильтра }

  TShellNotifyFilter = DWORD;

type
  TShellNotify = class(TThread)
  private
    EWaitObject: THandle;
    ENotifyFilter: TShellNotifyFilter;
    EPath: TFileName;
    EOnShellEvent: TNotifyEvent;
    EOnFinished: TNotifyEvent;
    EOnStarted: TNotifyEvent;
    procedure SetPath(const Value: TFileName);
  protected
    procedure Execute; override;
    procedure DoShellEvent;
    procedure DoFinished; virtual;
    procedure DoStarted; virtual;
  public
    property NotifyFilter: TShellNotifyFilter read ENotifyFilter write ENotifyFilter;
    property Path: TFileName read EPath write SetPath;
    property OnShellEvent: TNotifyEvent read EOnShellEvent write EOnShellEvent;
    property OnFinished: TNotifyEvent read EOnFinished write EOnFinished;
    property OnStarted: TNotifyEvent read EOnStarted write EOnStarted;
    property Terminated;
    constructor Create;
  end;

implementation

{ TFileNotificationsThread }

constructor TShellNotify.Create;
begin
  inherited Create(true);
  // Начальные присвоения
  EWaitObject := INVALID_HANDLE_VALUE;
end;

procedure TShellNotify.DoFinished;
begin
  if Assigned(EOnFinished) then EOnFinished(Self);
end;

procedure TShellNotify.DoShellEvent;
begin
  if Assigned(EOnShellEvent) then EOnShellEvent(Self);
end;

procedure TShellNotify.DoStarted;
begin
  if Assigned(EOnStarted) then EOnStarted(Self);
end;

procedure TShellNotify.Execute;
var WaitResult: DWORD;
begin
  FreeOnTerminate := true;

  // OnStarted
  Synchronize(DoStarted);

  // Получение дескриптора обьекта уведомления
  EWaitObject := FindFirstChangeNotification(PChar(EPath), true,ENotifyFilter);

  // Если дескриптор объекта неверный, то завершаем работу потока
  if EWaitObject = INVALID_HANDLE_VALUE then Terminate;

  // Пока поток работает
  while not Terminated do
  begin
    // Ждем возникновения объекта события
    WaitResult := WaitForSingleObject(EWaitObject,100);

    if WaitResult = WAIT_OBJECT_0 then
    begin
      Synchronize(DoShellEvent);
      if FindNextChangeNotification(EWaitObject) = false then break;
    end;
    if WaitResult = WAIT_FAILED then break;
  end;

  // Освобождение дескриптора объекта
  FindCloseChangeNotification(EWaitObject);

  // OnFinished
  Synchronize(DoFinished);
end;

procedure TShellNotify.SetPath(const Value: TFileName);
begin
  EPath := Trim(Value);
end;

end.
