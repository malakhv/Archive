
{*******************************************************}
{                                                       }
{       TPrinterNotificationThread Class                }
{       Unit                                            }
{                                                       }
{       Copyright (c) Малахов Михаил 2006               }
{                                                       }
{*******************************************************}

unit PrntNtfcThr;

interface

uses
  Classes, SyncObjs, WinSpool, GlPrSrv;
                     
type
  TPrinterNotificationThread = class(TThread)
  private
    FPrinter: TPrinterInfo;
    FMHandle: THandle;
    NotifyOption: TPrinterNotifyOptions;
    NotifyTipes: TPrinterNotifyOptionsType;
    NotifyInfo: PPrinterNotifyInfo;
    //NotifyInfoData: TPrinterNotifyInfoData;
    hWait: THandle;
    hNotification: THandle;
  protected
    procedure Execute; override;
  public
    constructor Create(APrinter: TPrinterInfo; AMHandle: THandle);
    procedure OnClose(Sender: TObject);
    procedure StopWait;
  end;

implementation

uses SysUtils, Windows,WinProcs, MsgPrSrv;

{ TPrinterNotificationThread }

const
  {jobfields : Array [1..9] of Word = (JOB_NOTIFY_FIELD_MACHINE_NAME,
    JOB_NOTIFY_FIELD_USER_NAME,JOB_NOTIFY_FIELD_DOCUMENT,
    JOB_NOTIFY_FIELD_TOTAL_PAGES,JOB_NOTIFY_FIELD_TOTAL_BYTES,
    JOB_NOTIFY_FIELD_BYTES_PRINTED,JOB_NOTIFY_FIELD_PAGES_PRINTED,
    JOB_NOTIFY_FIELD_STATUS,JOB_NOTIFY_FIELD_DEVMODE );   }
  jobfields : Array [1..5] of Word = (JOB_NOTIFY_FIELD_USER_NAME,
    JOB_NOTIFY_FIELD_TOTAL_PAGES,JOB_NOTIFY_FIELD_PAGES_PRINTED,
    JOB_NOTIFY_FIELD_STATUS,JOB_NOTIFY_FIELD_DEVMODE);

type
  TJobInfo = record
    //MachineName  : string[255];
    UserName     : string[50];
    //Document     : string[255];
    TotalPages   : integer;
    //TotalBytes   : integer;
    //BytesPrinted : integer;
    PagesPrinted : integer;
    Status       : integer;
    Copies       : integer;
  end;


constructor TPrinterNotificationThread.Create(APrinter: TPrinterInfo; AMHandle: THandle);
begin
  Inherited Create(true);
  Self.Priority := tpHighest;
  FPrinter := APrinter;
  FMHandle := AMHandle;
  Self.FreeOnTerminate := true;
  Self.OnTerminate := OnClose;
  Self.Resume;
end;

procedure TPrinterNotificationThread.Execute;
// Последнее обработанное и удаленное задание
var FLastJobID, FLastDelJob: Integer;
// Изменение в очереди печати
var pdwChange: Cardinal;
// Результат функции FindNextPrinterChangeNotification
var fResult: LongBool;
// Информация о задании
var pcNeed: PDWORD;
    jId: THandle;
    job,MsJob: PJob;
// Структура TjobInfo
var jobInfo: TjobInfo;

  function ReasonWas(flag: Cardinal): boolean;
  begin
    Result := (flag and pdwChange) <> 0;
  end; { ReasonWas }

  function StatusIs(Status,flag: Cardinal): Boolean;
  begin
    Result := (flag and Status) <> 0;
  end; { StatusIs }

  function GetJobInfo: boolean;
    function DataString(index: Integer): String;
    begin
      Result := Pchar(NotifyInfo^.aData[index].NotifyData.Data.pBuf)
    end;
    function DataValue(index: Integer): Cardinal;
    begin
      Result := NotifyInfo^.aData[index].NotifyData.adwData[0];
    end;
    function GetPrinterNumCopies(index: Integer):Cardinal;
    begin
      Result :=
        PDeviceMode(NotifyInfo^.aData[index].NotifyData.Data.pBuf)^.dmCopies;
    end;
  var i: integer;
  begin
    Result := false;
    if NotifyInfo^.Count = 0 then Exit;
    Result := true;
    jId := NotifyInfo^.aData[0].Id;
    for i := 0 to NotifyInfo^.Count - 1 do
      case NotifyInfo^.aData[i].Field of
        //JOB_NOTIFY_FIELD_MACHINE_NAME:
          //jobInfo.MachineName := Datastring(i);
        JOB_NOTIFY_FIELD_USER_NAME:
          jobInfo.UserName := Datastring(i);
        //JOB_NOTIFY_FIELD_DOCUMENT:
          //jobInfo.Document := Datastring(i);
        JOB_NOTIFY_FIELD_TOTAL_PAGES:
          jobInfo.TotalPages := Datavalue(i);
        //JOB_NOTIFY_FIELD_TOTAL_BYTES:
          //jobInfo.Totalbytes := Datavalue(i);
        //JOB_NOTIFY_FIELD_BYTES_PRINTED:
          //jobInfo.BytesPrinted := Datavalue(i);
        JOB_NOTIFY_FIELD_PAGES_PRINTED:
          jobInfo.PagesPrinted := Datavalue(i);
        JOB_NOTIFY_FIELD_DEVMODE:
          jobInfo.Copies := GetPrinterNumCopies(i);
      end; { Case }
  end;

begin
  FLastJobID  := -1;
  FLastDelJob := -1;
  New(pcNeed);

  NotifyOption.Version := 2;
  NotifyOption.Count := 1;
  NotifyOption.Flags := PRINTER_CHANGE_SET_JOB or PRINTER_CHANGE_WRITE_JOB;
  NotifyOption.pTypes := @NotifyTipes;

  FillChar(NotifyTipes,sizeof(NotifyTipes),0);

  NotifyTipes.wType := JOB_NOTIFY_TYPE;
  NotifyTipes.Reserved0 := 0;
  NotifyTipes.Reserved1 := 0;
  NotifyTipes.Reserved2 := 0;
  NotifyTipes.pFields := @jobfields;
  NotifyTipes.Count := High(jobfields)- Low(jobfields) + 1;

  hNotification := FindFirstPrinterChangeNotification(FPrinter.Handle,
    PRINTER_CHANGE_SET_JOB or PRINTER_CHANGE_WRITE_JOB,0,@NotifyOption);
  if hNotification = INVALID_HANDLE_VALUE then
  begin
    // Сообщить основной программе о неудаче, завершить работы потока
    Exit;
  end;

  NotifyOption.Flags := PRINTER_NOTIFY_OPTIONS_REFRESH;

  while not Self.Terminated do
  begin
    hWait := WaitForSingleObject(hNotification,INFINITE);
    if hWait <> WAIT_OBJECT_0 then Continue;
    fResult := FindNextPrinterChangeNotification(hNotification,
      pdwChange,@NotifyOption,Pointer(NotifyInfo));

    if Self.Terminated then break;

    if fResult then
    begin
      if NotifyInfo = nil then Continue;
  
      if ReasonWas(PRINTER_CHANGE_WRITE_JOB) then
      begin
        GetJobInfo;
        GetJob(FPrinter.Handle,jId,1,job,0,pcNeed);
        job := AllocMem(pcNeed^);
        if GetJob(FPrinter.Handle,jId,1,job,pcNeed^,pcNeed) then
        begin
          //SetJob(FPrinter.Handle,jId,1,job,JOB_CONTROL_PAUSE);
          if Printing(jobInfo.UserName,FPrinter.PName,jobInfo.TotalPages * jobInfo.Copies) then
            //SetJob(FPrinter.Handle,jId,1,job,JOB_CONTROL_RESUME)
          else begin
            FLastDelJob := jId;
            //job^.Status := JOB_CONTROL_CANCEL;
            if not SetJob(FPrinter.Handle,jId,1,job,JOB_CONTROL_CANCEL) then
            begin
              WinProcs.AbortDoc(FPrinter.Handle);
              FLastDelJob := jId;
            end;
          end;
        end;
      end;

      if ReasonWas(PRINTER_CHANGE_SET_JOB) then
      begin
        GetJobInfo;
        GetJob(FPrinter.Handle,jId,1,nil,0,pcNeed);
        job := AllocMem(pcNeed^);
        Sleep(0);
        if GetJob(FPrinter.Handle,jId,1,job,pcNeed^,pcNeed) then
        begin
          //SetJob(FPrinter.Handle,jId,1,job,JOB_CONTROL_PAUSE);

          if StatusIs(job^.Status,JOB_STATUS_PRINTED) then
          begin
            if jId = Cardinal(FLastJobID) then continue;
            if jId = Cardinal(FLastDelJob) then continue;
            FLastJobID := jID;
            MsJob := AllocMem(pcNeed^);
            MsJob^ := job^;
            MsJob^.PagesPrinted := jobinfo.TotalPages * jobinfo.Copies;
            PostMessage(FMHandle,DM_SETPAGEPRINTD,FPrinter.ID,Integer(MsJob));
          end;

          //SetJob(FPrinter.Handle,jId,1,job,JOB_CONTROL_RESUME);
        end;
      end;

    end; // fResult
  end; // while
  Dispose(pcNeed);
end;

procedure TPrinterNotificationThread.OnClose(Sender: TObject);
begin
  FreePrinterNotifyInfo(NotifyInfo);
  FindClosePrinterChangeNotification(hNotification);
end;

procedure TPrinterNotificationThread.StopWait;
begin
  FreePrinterNotifyInfo(NotifyInfo);
  FindClosePrinterChangeNotification(hNotification);
  Self.Terminate;
end;

end.
