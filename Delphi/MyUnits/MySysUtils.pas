unit MySysUtils;

interface

uses Windows, SysUtils;

  { ������� ���������� ��� ���������� ����� (C:) }

  function GetSystemDisk: TFileName;

  { ������� ���������� ���� � ����������� ��������� ������ }

  function GetSpecialFolderPath(hWnd: HWND; nFolder: integer; fCreate: boolean): TFileName;

  { ������� ���������� ���� � ����� ����������� }

  function GetAutoStartPath(hWnd: HWND = 0): TFileName;

  { ������� ��������� ���� � ������������ }

  function AddAutoStart(FileName: TFileName; LinkName: TFileName = ''): boolean;

implementation

uses ActiveX, ComObj, ShlObj;

function GetSystemDisk: TFileName;
var buf: PChar; Res: Cardinal;
begin
  buf := StrAlloc(MAX_PATH);
  try
    Res := GetWindowsDirectory(buf,MAX_PATH);
    if Res > 0 then
      Result := ExtractFileDrive(StrPas(buf))
    else
      Result := '';
  finally
    StrDispose(buf);
  end;
end;

function GetSpecialFolderPath(hWnd: HWND; nFolder: integer; fCreate: boolean): TFileName;
var buf: PWideChar;
begin
  buf := StrAlloc(MAX_PATH);
  try
    SHGetSpecialFolderPath(hWnd,buf,nFolder,fCreate);
    Result := TFileName(StrPas(buf));
  finally
    StrDispose(buf);
  end;
end;

function GetAutoStartPath(hWnd: HWND): TFileName;
begin
  Result := GetSpecialFolderPath(hWnd,CSIDL_COMMON_STARTUP,false);
end;

function AddAutoStart(FileName,LinkName: TFileName): boolean;
var SL: IShellLink;
    PF: IPersistFile;
    ALinkName: WideString;
begin
  Result := true;
  if LinkName <> '' then
    ALinkName := WideString( ChangeFileExt( WideString(LinkName), '.lnk') )
  else
    ALinkName := WideString( ChangeFileExt( ExtractFileName(FileName), '.lnk') );
  try
    OleCheck(CoCreateInstance(CLSID_ShellLink,nil,CLSCTX_INPROC_SERVER,IShellLink, SL));
    PF := SL as IPersistFile;
    OleCheck(SL.SetPath(PChar(FileName)));
    ALinkName := WideString(GetAutoStartPath) + '\' + ALinkName;
    PF.Save(PWideChar(ALinkName),true);
  except
    Result := false;
  end;
end;

end.
