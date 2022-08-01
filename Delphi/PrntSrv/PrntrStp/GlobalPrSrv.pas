unit GlobalPrSrv;

interface

uses Classes, Windows, Messages, WinSpool;

const
  ConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source= ';
  LimitDBName      = 'Limits.mdb';

const
  DM_SETPAGEPRINTD = WM_USER + 200; // wParam - ������ ������������ � �������, lParam - TSetPagePrintdMesInfo
  DM_WRITEDBPAGEPR = WM_USER + 201; // wParam - ID ������������, lParam - TSetPagePrintdMesInfo
  DM_LOADUSERSINFO = WM_USER + 202;
  PM_STOPWAITPRNT  = WM_USER + 203;
  PM_STRTWAITPRNT  = WM_USER + 205;


type
  TPrinterName = string[250];
  TUserName    = string[250];
  TMachineName = string[250];


type
  TPrinterInfo = record
    ID: Integer;
    Handle: THandle;
    PName: TPrinterName;
    MName: TMachineName;
  end;

type
  TThreadStatus = (tsNone = 0, tsNormal = 1, tsWait = 2,
  tsCritical = 3, tsTerminating = 4);

type
  TInterval = record
    ID: Integer;
    T1: TDateTime;
    T2: TDateTime;
  end;

type
  TIntervals = array of TInterval;    // ������ ���������� �������

type
  TLimit = record                     // ����� ������������
    ID: Integer;
    LType: byte;
    PageLimit  : Integer;
    PagePrinted: Integer;
    LPrinter: TPrinterInfo;
    Intervals: TIntervals;
  end;

type
  TLimits = array of TLimit;          // ������ ������� ������������

type
  TUserInfo = record                  // ���������� � ������������
    ID: integer;                      // ID � ������� ��
    UserName: string[255];            // ��� ������������
    PagePrinted: Integer;             // ������� ����������
    Limits   : TLimits;                // ����� ������
  end;

type
  TUsersInfo = array of TUserInfo;


type
  TPrintedOptions = record            // ��������� ������
    UnUserPrinted: boolean;           // true - ��������� ������ �������������,
                                      // ������� ���� � ���� ������,
                                      // false - �������� ���� ������������,
                                      // ������� ���� � ���� ������
  end;

type
  TJob = JOB_INFO_1;
type
  PJob = ^TJob;

type
  TSetPagePrintdMesInfo = record
    PID: integer;       // ID ��������
    PageCount: integer; // ���-�� ������������ �������
    Job: PJob;
  end;

type
  PSetPagePrintdMesInfo = ^TSetPagePrintdMesInfo;


var
  Users: TUsersInfo;
  PrintedOptions: TPrintedOptions;
  CS: TRTLCriticalSection;
  MachineName: TMachineName;

procedure LoafDefOptions;

function GetMachineName:TMachineName;
function GetPrinterHandle(PrName: string; var hPrinter: THandle): boolean;



implementation

uses netapi32;

procedure LoafDefOptions;
begin
  PrintedOptions.UnUserPrinted := false;
end;

function GetMachineName:TMachineName;
var inf: PWKSTA_INFO_100;
    tmp: LPBYTE;
begin
  Result := '';
  NetWkstaGetInfo(nil,100,tmp);
  inf := PWKSTA_INFO_100(tmp);
  if inf = nil then Exit;
  Result :=  string(inf^.wki100_computername); 
end;

function GetPrinterHandle(PrName: string; var hPrinter: THandle): boolean;
begin
  Result := false;
  if OpenPrinter(PChar(PrName),hPrinter,nil) then Result := true;
end;

end.
