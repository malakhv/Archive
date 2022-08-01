unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ComCtrls, Buttons,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, IdAntiFreezeBase, IdAntiFreeze;

type
  TMainForm = class(TForm)
    LogBox: TListBox;
    btnRun: TButton;
    btnStop: TButton;
    btnExit: TButton;
    TrayIcon: TTrayIcon;
    PopupMenu1: TPopupMenu;
    mnShow: TMenuItem;
    mnSep1: TMenuItem;
    mnClose: TMenuItem;
    StatusBar: TStatusBar;
    btnWaitLog: TSpeedButton;
    btnAppLog: TSpeedButton;
    btnUpdateLog: TSpeedButton;
    Image: TImage;
    btnCopy: TButton;
    btnClearLog: TButton;
    FTP: TIdFTP;
    UpdateTimer: TTimer;
    IdAntiFreeze: TIdAntiFreeze;
    Timer: TTimer;
    procedure btnRunClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnShowClick(Sender: TObject);
    procedure mnCloseClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnWaitLogClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    function GetAppPath: TFileName;
    procedure ShellEvent(Sender: TObject);
    procedure AppExcept(Sender: TObject; Ex: Exception);
    procedure SysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
    function GetListFileName: TFileName;
    function GetCmdFileName: TFileName;
    procedure LoadOptions(Sender: TObject);
    procedure LogChange(Sender: TObject);
    procedure WaitStarted(Sender: TObject);
  public
    property AppPath: TFileName read GetAppPath;
    property ListFileName: TFileName read GetListFileName;
    property CmdFileName: TFileName read GetCmdFileName;
    procedure ShowLog(Sender: TObject);
    function StartWait: boolean;
    procedure StopWait;
    function ProgUpdate: boolean;
  end;

var
  MainForm: TMainForm;

implementation

uses MyClasses, MySDFiles,  ShellNotify, ProgOptions, OsmpLog, OSMPInt;

{$R *.dfm}

var
  Wait: TShellNotify;
  Log: TOSMPLog;

procedure OSMPWrk(AFileName, AMsg: PChar; WrkResult: boolean = true);
var TmpStr: string;
begin
  TmpStr := StrPas(AMsg) + ' ' + StrPas(AFileName);
  if not WrkResult then
    TmpStr := TmpStr + ' Error ';
  Log.Add(ltWait,StrPas(AMsg) + ' ' + StrPas(AFileName));
end;

procedure TMainForm.AppExcept(Sender: TObject; Ex: Exception);
begin
  // Добавление к файлу лога кода ошибки
  Log.Add(ltApp, lAppError + Ex.Message);
end;

procedure TMainForm.btnClearLogClick(Sender: TObject);
begin
  // Очистка лога
  Log.Clear;
end;

procedure TMainForm.btnCopyClick(Sender: TObject);
begin
  ShellEvent(btnCopy);
end;

procedure TMainForm.btnExitClick(Sender: TObject);
begin
  mnCloseClick(Sender);
end;

procedure TMainForm.btnRunClick(Sender: TObject);
begin
  StartWait; // Запуск наблюдения
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  StopWait;  // Остановка наблюдения
end;

procedure TMainForm.btnWaitLogClick(Sender: TObject);
begin
  // Установка типа файла лога
  Log.LogType := TLogType( (Sender as TSpeedButton).Tag );
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle,SW_HIDE);
  ShowWindow(Self.Handle, SW_HIDE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем обработчик ошибок
  Application.OnException := AppExcept;
  // Работа с настройками
  Options.OnLoad := LoadOptions;
  Options.FileName := AppPath + nOptFile;
  // Лог файл
  Log := TOSMPLog.Create(AppPath);
  Log.OnChange := LogChange;
  Log.MaxCount := 100;
  Log.Add(ltApp, lAppStart);

  // Если авто наблюдение, запуск процесса наблюдения
  if Options.AutoWait then
  begin
    //ShellEvent(Self);
    //StartWait;
    ShellEvent(btnCopy);
    Timer.Interval := Options.CopyInterval;
    Timer.Enabled :=  true;
  end;
  // Если автообновление, запуск процесса обновления
  if Options.AutoUpdate then
  begin
    UpdateTimerTimer(nil);
    UpdateTimer.Interval := Options.UpdateInterval;
    UpdateTimer.Enabled := true;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  StopWait;
  Options.Save;
  Log.Add(ltApp, lAppEnd);
  Log.Free;
end;

function TMainForm.GetAppPath: TFileName;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

function TMainForm.GetCmdFileName: TFileName;
begin
  Result := AppPath + 'Osmp Files\cmd.ini';
end;

function TMainForm.GetListFileName: TFileName;
begin
  Result := AppPath + 'Osmp Files\FileList.ini';
end;

procedure TMainForm.LoadOptions(Sender: TObject);
begin
  // Update Timer Work
  UpdateTimer.Interval := Options.UpdateInterval;
  UpdateTimer.Enabled := Options.AutoUpdate;
  // FTP Work
  FTP.Host := Options.Host;
  FTP.Port := Word(Options.Port);
  FTP.Username := Options.UserName;
  FTP.Password := Options.Password;
end;

procedure TMainForm.LogChange(Sender: TObject);
begin
  LogBox.Items.Assign(Log.Data);
  StatusBar.SimpleText := Log.LogName;
end;

procedure TMainForm.mnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.mnShowClick(Sender: TObject);
begin
  ShowWindow(Self.Handle,SW_SHOW);
end;

function TMainForm.ProgUpdate: boolean;
const
  UpdDir = 'scn';
  UpdtFileList = 'updtfiles';
  VerFile = 'updt.ver';

var
  Ver: TVersion;
  SDFIles: TSDFiles;
  i: integer;

begin
  Result := true;
  try
    FTP.Connect;
    try
      if FTP.Connected then
      begin
        FTP.ChangeDir(UpdDir);
        FTP.Get(VerFile,AppPath + VerFile,true);
        Ver := TVersion.Create;
        try
          Ver.LoadFromFile(AppPath + VerFile);
          if Options.UpdateVer < Ver.VerNumber then
          begin
            // Добавление информации в лог
            Log.Add(ltUpdt, lUpdtEnabled);
            // Загрузка списка файлов
            FTP.Get(UpdtFileList, AppPath + UpdtFileList, true);
            SDFiles := TSDFiles.Create(AppPath + UpdtFileList);
            try
              SDFiles.DesPath := AppPath;
              // Загрузка файлов
              for i := 0 to SDFiles.Count - 1 do
                FTP.Get(SDFiles.Source[i],SDFiles.Des[i],true);
            // Сохранение информации о версии обновления
            Options.UpdateVer := Ver.VerNumber;
            finally
              SDFiles.Free;
            end;
          end else
          begin
            Log.Add(ltUpdt, lUpdtDisabled);
          end;
        finally
          Ver.Free;
        end;
      end;
    finally
      FTP.Disconnect;
    end;
  except
    Result := false;
  end;
end;

procedure TMainForm.ShowLog(Sender: TObject);
begin
  if Sender is TOSMPLog then
    LogBox.Items.Assign( (Sender as TOSMPLog).Data );
end;

function TMainForm.StartWait: boolean;
begin
  StopWait;
  Result := true;
  try
    Wait := TShellNotify.Create;
    with Wait do
    begin
      NotifyFilter := fncLastWrite or fncSize;
      Path := Options.SiteDir;
      OnShellEvent := ShellEvent;
      OnStarted := WaitStarted;
      Resume;
    end;
  except
    Log.Add(ltWait, lWaitStartError);
    Result := false;
  end;
end;

procedure TMainForm.StopWait;
begin
  try
    if Assigned(Wait) then
      if not Wait.Terminated then
      begin
        Wait.Terminate;
        Wait := nil;
        Log.Add(ltWait, lWaitStop);
      end;
  except
    Log.Add(ltWait, lWaitStopError);
  end;
end;

procedure TMainForm.SysCommand(var Msg: TMessage);
begin
  // При минимизации окна, скрываем его
  if Msg.WParam = SC_MINIMIZE then
    ShowWindow(Self.Handle, SW_HIDE)
  else
    inherited;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  ShellEvent(btnCopy);
end;

procedure TMainForm.UpdateTimerTimer(Sender: TObject);
begin
  if ProgUpdate then
  begin
    Log.Add(ltUpdt, lUpdtOK);
    Options.Save;
    //ShellEvent(btnCopy);
  end else
    Log.Add(ltUpdt, lUpdtError);
end;

procedure TMainForm.WaitStarted(Sender: TObject);
begin
  Log.Add(ltWait, lWaitStart);
end;

procedure TMainForm.ShellEvent(Sender: TObject);
var
  LibHandle: THandle;
  OSMPWork: TOSMPWork;
begin
  LibHandle := LoadLibrary( PWideChar(AppPath + 'osmpdll.dll') );
  try
    if LibHandle <> 0 then
    begin
      @OSMPWork := GetProcAddress(LibHandle,'OsmpWork');
      if @OSMPWork <> nil then
        OSMPWork(PChar(AppPath), PChar(Options.SiteDir), Sender = btnCopy, OSMPWrk)
      else
        RaiseLastOSError;
    end else
      Log.Add(ltApp, lAppLoadLibrError);
  finally
    FreeLibrary(LibHandle);
  end;
end;

end.
