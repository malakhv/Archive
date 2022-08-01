library osmpdll;
{$DEFINE OSMPDLL}

uses
  SysUtils, Classes, MyFiles, MySDFiles, OSMPInt;

function InsertCode(AFileName,FindText,Code: PChar): boolean;
var
  List: TStringList;
  fIndex: integer;

  function FindStr(Str: string): integer;
  var i: integer;
  begin
    Result := -1;
    for i := 0 to List.Count - 1 do
      if Pos(Str,List[i]) > 0 then
      begin
        Result := i;
        break;
      end;
  end;

begin
  Result := false;
  if not FileExists(AFileName) then Exit;
  List := TStringList.Create;
  try
    List.LoadFromFile(StrPas(AFileName));
    if FindStr('MYCODE') = -1 then
    begin
      fIndex := FindStr( StrPas(FindText) );
      if fIndex <> -1 then
      begin
        List.Insert(fIndex, '  //MYCODE' );
        List.Insert(fIndex + 1, StrPas(Code));
        List.Insert(fIndex + 2,' ');
        List.SaveToFile(StrPas(AFileName));
        Result := true;
      end;
    end;
  finally
    List.Free;
  end;
end;

function OsmpWork(AppDir, SiteDir: PChar; IsCopy: boolean = false;
  OSMPWrkProg: TOSMPWrkProg = nil): boolean; StdCall;
const
  dOSMP = 'Osmp Files\';
  nOsmpFileList = 'FileList.ini';
  sCode = '  if (prv_folder == "abricos_tv") { document.ff.action = value[prv_value]["prv_page"]; ff.submit(); return;}';
var
  i: integer;
  SDFiles: TSDFiles;
begin
  Result := false;
  // Копирование файлов
  SDFiles := TSDFiles.Create(StrPas(AppDir) + dOSMP + nOsmpFileList);
  try
    SDFiles.SourcePath := StrPas(AppDir) + dOSMP;
    SDFiles.DesPath := StrPas(SiteDir);
    for i := 0 to SDFiles.Count - 1 do
      with SDFiles.SourceInfo[i] do
        if (Size <> SDFiles.DesInfo[i].Size) or IsCopy then
        //if (GetCRC32(SDFiles.Source[i]) <> GetCRC32(SDFiles.Des[i])) or IsCopy then
        begin
          Result :=  SDFiles.CopyTo(i);
          if Assigned(OSMPWrkProg) then
            OSMPWrkProg(PChar(ExtractFileName(SDFiles[i].Source)),PChar('Copy File'), Result);
          if not Result then
            break;
        end;
  finally
    SDFiles.Free
  end;
  // Изменение файлов
  if InsertCode( PChar( StrPas(SiteDir) + 'func\engine\redirect.js' ),PChar('"tv"'), PChar(sCode) ) then
    if Assigned(OSMPWrkProg) then
      OSMPWrkProg(PChar('redirect.js'),PChar('Insert Code'),true);
end;

exports
  OsmpWork;
end.
