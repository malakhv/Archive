// Misha. SoftLine
unit Files;

interface
uses Classes,SysUtils;

type TFileInfo = record
       FullName: TFileName;
       Name:     TFileName;
       FileSize: LongInt;
     end;

type TArrayResult = array of TFileInfo;

var faFileType: integer = faAnyFile-faHidden-faSysFile-faDirectory;
    Info:TFileInfo;
    FileCount: LongInt = 0;
    ArrayResult: TArrayResult;

procedure AddFileInfo(Inf:TFileInfo);
procedure ResetArrayResult;
function FindFile(Dir:TFileName;Mask:string):integer;
function FindFileAllDir(Dir:TFileName;Mask:string):integer;

implementation

procedure AddFileInfo(Inf:TFileInfo);
begin
 SetLength(ArrayResult,Length(ArrayResult)+1);
 ArrayResult[Length(ArrayResult)-1].FullName := inf.FullName;
 ArrayResult[Length(ArrayResult)-1].Name := inf.Name;
 ArrayResult[Length(ArrayResult)-1].FileSize := inf.FileSize;
 FileCount := FileCount + 1;
end;

procedure ResetArrayResult;
begin
 SetLength(ArrayResult,0);
 FileCount := 0;
end;

function FindFile(Dir:TFileName;Mask:string):integer;
var FSearchRec:TSearchRec; FindResult:integer;
begin
 Result := 0;
 try
  faFileType := faAnyFile-faHidden-faSysFile-faDirectory;
  if Dir[Length(Dir)]<>'\'then Dir := Dir + '\';
  FindResult := FindFirst(Dir+Mask,faFileType,FSearchRec);
  while FindResult = 0 do
  begin
   Info.FullName := Dir + FSearchRec.Name;
   Info.Name := FSearchRec.Name;
   Info.FileSize := FSearchRec.Size;
   AddFileInfo(Info);
   FindResult := FindNext(FSearchRec);
  end;
  finally
   FindClose(FSearchRec);
  end;
end;

function FindFileAllDir(Dir:TFileName;Mask:string):integer;
 function IsDirNotation(ADirName:string):boolean;
 begin
   Result := (ADirName = '.')or(ADirName = '..');
 end;
var FSearchRec,DSearchRec:TSearchRec; FindResult:integer;
begin
  if Dir[Length(Dir)]<>'\'then Dir := Dir + '\';
  Result := 0;
  FindResult := FindFirst(Dir+Mask,faFileType,FSearchRec);
  try
    while FindResult = 0 do
    begin
      Info.FullName := Dir + FSearchRec.Name;
      Info.Name := FSearchRec.Name;
      Info.FileSize := FSearchRec.Size;
      AddFileInfo(Info);
      FindResult := FindNext(FSearchRec);
    end;
    FindResult := FindFirst(Dir+'*',faDirectory,DSearchRec);
    while FindResult = 0 do
    begin
      if((DSearchRec.Attr and faDirectory)=faDirectory)
         and(not IsDirNotation(DSearchRec.Name)) then
      begin
       FindFileAllDir(Dir+DSearchRec.Name,Mask);
      end;
      FindResult := FindNext(DSearchRec);
    end;
  finally
    FindClose(FSearchRec);
  end;
end;

end.
