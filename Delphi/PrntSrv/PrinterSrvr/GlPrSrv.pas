unit GlPrSrv;

interface

uses Windows, Classes, WinSpool;

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
  TInterval = record                  // Интервал времени
    ID: Integer;
    T1: TDateTime;
    T2: TDateTime;
  end;

type
  TIntervals = array of TInterval;    // Массив интервалов времени  

type
  TLimit = record                     // Лимит пользователя
    ID: Integer;                      // ID пользователя
    LType: byte;                      // Тип лимита
    PageLimit  : Integer;             // Лимит страниц
    PagePrinted: Integer;             // Страниц отпечатанно
    LPrinter: TPrinterInfo;           // Информация о принтере
    Printing: boolean;                // Можно печатать или нет
    Intervals: TIntervals;            // Интервалы
  end;

type
  TLimits = array of TLimit;          // Массив Лимитов пользователя

type
  TUserInfo = record                  // Информация о пользователе
    ID: integer;                      // ID в таблице БД
    UserName: TUserName;              // Имя пользователя
    PageCount: integer;               // Скока страниц может печатать
    PagePrinted: Integer;             // Страниц отпечатано
    Limits   : TLimits;               // Лимит печати
  end;

type
  TUsersInfo = array of TUserInfo;

type
  TJob = JOB_INFO_1;
  
type
  PJob = ^TJob;

var
  Users: TUsersInfo;
  CS: TRTLCriticalSection;

function GetPrinterHandle(PrName: string; var hPrinter: THandle): boolean;

procedure ClearUsers;
procedure LoadUsers(AUsr: TUsersInfo);
function GetUserIDByName(AName: string): integer;
function GetUserIndexByName(AName: string): integer;
function GetUserByName(const AName: string; var User: TUserInfo): boolean;
function GetUser(Index: integer): TUserInfo; overload;
function GetUser(AName: string): integer; overload;
procedure UpdatePrintedPage(UIndex,PID,APage: integer);

function Printing(UName,PName: string; PgCount: integer): boolean;

implementation

uses SysUtils;

function GetPrinterHandle(PrName: string; var hPrinter: THandle): boolean;
begin
  Result := false;
  if OpenPrinter(PChar(PrName),hPrinter,nil) then Result := true;
end;

procedure ClearUsers;
var i,j: integer;
begin
  //EnterCriticalSection(CS);
  for i := 0 to Length(Users) - 1 do
  begin
    for j := 0 to Length(Users[i].Limits)-1 do
    begin
      SetLength(Users[i].Limits[j].Intervals,0);
    end;
    SetLength(Users[i].Limits,0);
  end;
  SetLength(Users,0);
  //LeaveCriticalSection(CS);
end;

procedure LoadUsers(AUsr: TUsersInfo);
begin
  //EnterCriticalSection(CS);
  ClearUsers;
  Users :=  Copy(AUsr);
  //LeaveCriticalSection(CS);
end;

function GetUserIDByName(AName: string): integer;
var i: integer;
begin
  Result := -1;
  //EnterCriticalSection(CS);
  for i := 0 to Length(Users) - 1 do
  begin
    if Users[i].UserName = AName then
    begin
      Result := Users[i].ID;
      break;
    end;
  end;
 //LeaveCriticalSection(CS);
end;

function GetUserIndexByName(AName: string): integer;
var i: integer;
begin
  Result := -1;
  //EnterCriticalSection(CS);
  for i := 0 to Length(Users) - 1 do
  begin
    if Users[i].UserName = AName then
    begin
      Result := i;
      break;
    end;
  end;
 //LeaveCriticalSection(CS);
end;

function GetUserByName(const AName: string; var User: TUserInfo): boolean;
var i: integer;
begin
  Result := false;
  //EnterCriticalSection(CS);
  for i := 0 to Length(Users) - 1 do
  begin
    if Users[i].UserName = AName then
    begin
      User := Users[i];
      User.Limits := Copy(Users[i].Limits);
      Result := true;
      break;
    end;
  end;
  //LeaveCriticalSection(CS);
end;

function GetUser(Index: integer): TUserInfo;
begin
  //EnterCriticalSection(CS);
  Result := Users[Index];
  //LeaveCriticalSection(CS);
end;

procedure UpdatePrintedPage(UIndex,PID,APage: integer);
var i: integer;
begin
  //EnterCriticalSection(CS);
    for i := 0 to Length(Users[UIndex].Limits) - 1 do
    begin
      if Users[UIndex].Limits[i].LPrinter.ID = PID then
      begin
        Inc(Users[UIndex].Limits[i].PagePrinted,APage);
      end;
    end;
  //LeaveCriticalSection(CS);
end;

function GetUser(AName: string): integer; overload;
var i: integer;
begin
  Result := -1;
  //EnterCriticalSection(CS);
  for i := 0 to Length(Users) - 1 do
  begin
    if Users[i].UserName = AName then
    begin
      Result := i;
      break;
    end;
  end;
  //LeaveCriticalSection(CS);
end;

function Printing(UName,PName: string; PgCount: integer): boolean;
var i,j, index: integer; CurTime: TDateTime;
begin
  // Проверяем есть ли информация о пользователе
  index := GetUser(UName);
  // Если нету - разрешаем печать и выходим
  if index = -1 then begin Result := true; Exit; end;

  CurTime := Time;
  // Предположим, что печатать можно
  Result := true;

  //EnterCriticalSection(CS);
  for i := 0 to Length(Users[index].Limits) - 1 do
  begin
    // Если лимит на другой принтер, то переходим к следующей итерации цикла
    if Users[index].Limits[i].LPrinter.PName <> PName then Continue;
    // Если тип лимита = 1 или 2 (кол-во страниц имеет значение) то
    if(Users[index].Limits[i].LType = 1)or(Users[index].Limits[i].LType = 2)then
    begin
      // Кол-во отпечаьанных страниц + кол-во страниц должно быть меньше или равно
      // количеству чтраниц лимита печати
      Result := Result and ((Users[index].Limits[i].PagePrinted + PgCount) <=
        Users[index].Limits[i].PageLimit);
    end;
    // Если уже изя печатать, то выходим из цикла
    if Result = false then break;
    // Если тип лимита = 2 или 3 (время имеет значение) то
    if(Users[index].Limits[i].LType = 2)or(Users[index].Limits[i].LType = 3)then
    begin
      for j := 0 to Length(Users[index].Limits[i].Intervals) - 1 do
      begin
        Result := (CurTime > Users[index].Limits[i].Intervals[j].T1) and
          (CurTime < Users[index].Limits[i].Intervals[j].T2);
        if not Result then break;
      end;
    end;
    // Если уже изя печатать, то выходим из цикла
    if Result = false then break;
  end;
  //LeaveCriticalSection(CS);
end;

initialization
begin
  SetLength(Users,0);
  //InitializeCriticalSection(CS);
end;

finalization
begin
  ClearUsers;
  //DeleteCriticalSection(CS);
end;

end.
