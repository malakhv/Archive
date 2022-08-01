
{*******************************************************}
{                                                       }
{       Borland Delphi Run-time Library                 }
{       Win32 printer API Interface Unit                }
{                                                       }
{       Copyright (c) Малахов Михаил 2006               }
{                                                       }
{       Translator: Малахов Михаил                      }
{                                                       }
{*******************************************************}

unit netapi32;

interface

uses Windows;

const
  nil_str: PWideChar = '';

const
   NERR_BASE = 2100;
   NERR_NAMENOTFOUND = NERR_BASE + 173;
   NERR_NETWORKERROR = NERR_BASE + 36;
   NERR_SUCCESS      = 0;

type
  LPBYTE = ^byte;

type
  WKSTA_USER_INFO_0 = packed record
    wkui0_username: PWideChar;
  end;

type
  PWKSTA_USER_INFO_0 = ^WKSTA_USER_INFO_0;

type
  WKSTA_USER_INFO_1 = packed record
    wkui1_username    : PWideChar;
    wkui1_logon_domain: PWideChar;
    wkui1_oth_domains : PWideChar;
    wkui1_logon_server: PWideChar;
  end;

type
  PWKSTA_USER_INFO_1 = ^WKSTA_USER_INFO_1;

type
  WKSTA_USER_INFO_1101 = packed record
    wkui1101_oth_domains: PWideChar;
  end;

type
  PWKSTA_USER_INFO_1101 = ^WKSTA_USER_INFO_1101;

type
  WKSTA_INFO_100 = packed record
    wki100_platform_id : DWORD;
    wki100_computername: PWideChar;
    wki100_langroup    : PWideChar;
    wki100_ver_major   : DWORD;
    wki100_ver_minor   : DWORD;
  end;

type
  PWKSTA_INFO_100 = ^WKSTA_INFO_100;

type
  WKSTA_INFO_101 = packed record
    wki101_platform_id : DWORD;
    wki101_computername: PWideChar;
    wki101_langroup    : PWideChar;
    wki101_ver_major   : DWORD;
    wki101_ver_minor   : DWORD;
    wki101_lanroot     : PWideChar;
  end;

type
  PWKSTA_INFO_101 = ^WKSTA_INFO_101;

type
  WKSTA_INFO_102 = packed record
    wki102_platform_id : DWORD;
    wki102_computername: PWideChar;
    wki102_langroup    : PWideChar;
    wki102_ver_major   : DWORD;
    wki102_ver_minor   : DWORD;
    wki102_lanroot     : PWideChar;
    wki102_logged_on_users: DWORD;
  end;

type
  PWKSTA_INFO_102 = ^WKSTA_INFO_102;

type
  NET_DISPLAY_GROUP = packed record
    grpi3_name   : LPWSTR;
    grpi3_comment: LPWSTR;
    grpi3_group_id  : DWORD;
    grpi3_attributes: DWORD;
    grpi3_next_index: DWORD;
  end;

type
  PNET_DISPLAY_GROUP = ^NET_DISPLAY_GROUP;

{NetWkstaUserGetInfo - Информация о залогиневшемся пользователе
  Reserved
    Этот параметр должен быть установлен в nil

  Level
    Определяет уровень(тип) возвращаемой информации. Может быть:
      0       параметр BufPtr указывает на структуру WKSTA_USER_INFO_0
      1       параметр BufPtr указывает на структуру WKSTA_USER_INFO_1
      1101    параметр BufPtr указывает на структуру WKSTA_USER_INFO_1101

  var BufPtr
    Указатель на структуру}
{$EXTERNALSYM NetWkstaUserGetInfo}
function NetWkstaUserGetInfo(Reserved: LPTSTR; Level: DWORD;
  var BufPtr: LPBYTE):DWORD;stdcall;

{NetWkstaGetInfo - Информация об элементах конфигурации рабочей станции
  ServerName
    Имя удаленного сервера, на котором должна выполниться функция.
    Если параметр равен nil, то выполняется на локальном компьютере

  Level
    Определяет уровень(тип) возвращаемой информации. Может быть:
      100     параметр BufPtr указывает на структуру WKSTA_INFO_100
      101     параметр BufPtr указывает на структуру WKSTA_INFO_101
      102     параметр BufPtr указывает на структуру WKSTA_INFO_102
      302     параметр BufPtr указывает на структуру WKSTA_INFO_302
      402     параметр BufPtr указывает на структуру WKSTA_INFO_402

  var BufPtr
    Указатель на структуру}
{$EXTERNALSYM NetWkstaGetInfo}
function NetWkstaGetInfo(ServerName: LPTSTR; Level: DWORD;
  var BufPtr: LPBYTE):DWORD;stdcall;

function NetWkstaSetInfo(ServerName: LPTSTR; Level: DWORD;
  var BufPtr: LPBYTE; ParmNum: DWORD; var ParErr: PDWORD):DWORD;stdcall;

{$EXTERNALSYM NetWkstaUserEnum}
function NetWkstaUserEnum(ServerName: LPTSTR; Level: DWORD;
  var BufPtr: LPBYTE; PrefMaxLen: DWORD; var EntriesRead: PDWORD;
  var TotalEntries: PDWORD; var ResumeHandle: PDWORD):DWORD;

{$EXTERNALSYM NetMessageBufferSend}
function NetMessageBufferSend(ServerName: LPCWSTR; MsgName: LPCWSTR;
  FromName: LPCWSTR; Buf: LPBYTE; BufLen: DWORD): DWORD;stdcall;

{$EXTERNALSYM NetMessageNameAdd}
function NetMessageNameAdd(ServerName: LPCWSTR;
  MsgName: LPCWSTR): DWORD; stdcall;

{$EXTERNALSYM NetMessageNameDel}
function NetMessageNameDel(ServerName: LPCWSTR;
  MsgName: LPCWSTR): DWORD stdcall;

implementation

const netapi = 'netapi32.dll';

function NetWkstaUserGetInfo;  external netapi name 'NetWkstaUserGetInfo';
function NetWkstaGetInfo;      external netapi name 'NetWkstaGetInfo';
function NetWkstaSetInfo;      external netapi name 'NetWkstaSetInfo';
function NetWkstaUserEnum;     external netapi name 'NetWkstaUserEnum';
function NetMessageBufferSend; external netapi name 'NetMessageBufferSend';
function NetMessageNameAdd;    external netapi name 'NetMessageNameAdd';
function NetMessageNameDel;    external netapi name 'NetMessageNameDel';

end.
