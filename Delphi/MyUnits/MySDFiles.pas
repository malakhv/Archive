unit MySDFiles;

interface

uses SysUtils, Classes, MyClasses, MyFiles;

type

  { Класс для работы со списком файлов }

  TSDFile = record
    Source: TFileName;
    Des: TFileName;
  end;

  TSDFileArray = array of TSDFile;

  TSDSaveMode = (smShort = 0, smFull = 1);

  TSDFiles = class(TCustomFileObject)
  private
    FItems: TSDFileArray;
    FSourcePath: TFileName;
    FDesPath: TFileName;
    FSaveMode: TSDSaveMode;
    FNameSep: string;
    function GetDes(Index: integer): TFileName;
    function GetDesInfo(Index: integer): TSearchRec;
    function GetItem(Index: integer): TSDFile;
    function GetSource(Index: integer): TFileName;
    function GetSourceInfo(Index: integer): TSearchRec;
    procedure SetDes(Index: integer; const Value: TFileName);
    procedure SetDesPath(const Value: TFileName);
    procedure SetItem(Index: integer; const Value: TSDFile);
    procedure SetSource(Index: integer; const Value: TFileName);
    procedure SetSourcePath(const Value: TFileName);
    function GetCount: integer;
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
    function GetSearchRec(AFileName: TFileName): TSearchRec;
    function SDFileCopy(SourceFile, DesFile: TFileName): boolean;
  public
    property Item[Index: integer]: TSDFile read GetItem write SetItem; default;
    property Source[Index: integer]: TFileName read GetSource write SetSource;
    property Des[Index: integer]: TFileName read GetDes write SetDes;
    property SourceInfo[Index: integer]: TSearchRec read GetSourceInfo;
    property DesInfo[Index: integer]: TSearchRec read GetDesInfo;
    property SourcePath: TFileName read FSourcePath write SetSourcePath;
    property DesPath: TFileName read FDesPath write SetDesPath;
    property Count: integer read GetCount;
    property SaveMode: TSDSaveMode read FSaveMode write FSaveMode;
    property NameSep: string read FNameSep write FNameSep; 
    function Add(SourceFile,DesFile: TFileName): integer; overload;
    function Add(SDFile: TSDFile): integer; overload;
    function CopyTo(Index: integer): boolean;
    function CopyFrom(Index: integer): boolean;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    procedure Clear;
    constructor Create(AFileName: TFileName = ''); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TSDFiles }

function TSDFiles.Add(SourceFile, DesFile: TFileName): integer;
begin
  Result := Count;
  SetLength(FItems,Result + 1);
  FItems[Result].Source := SourceFile;
  FItems[Result].Des := DesFile;
end;

function TSDFiles.Add(SDFile: TSDFile): integer;
begin
  Result := Add(SDFile.Source, SDFile.Des);
end;

procedure TSDFiles.Assign(Source: TPersistent);
begin
  inherited;
  Clear;
  if Source is TSDFiles then
  begin
    FItems := Copy( (Source as TSDFiles).FItems,0,Count);
    SourcePath := (Source as TSDFiles).SourcePath;
    DesPath := (Source as TSDFiles).DesPath;
    SaveMode := (Source as TSDFiles).SaveMode; 
    NameSep := (Source as TSDFiles).NameSep;
  end;
end;

procedure TSDFiles.AssignTo(Des: TPersistent);
begin
  inherited;
  if Des is TSDFiles then Des.Assign(Self);
end;

procedure TSDFiles.Clear;
begin
  SetLength(FItems,0);
end;

function TSDFiles.CopyFrom(Index: integer): boolean;
begin
  Result := SDFileCopy(Des[Index], Source[Index]);
end;

function TSDFiles.CopyTo(Index: integer): boolean;
begin
  Result := SDFileCopy(Source[Index], Des[Index]);
end;

constructor TSDFiles.Create(AFileName: TFileName);
begin
  inherited Create;
  FSourcePath := '';
  FDesPath := '';
  FSaveMode := smShort;
  FNameSep := '=';
  if AFileName <> '' then FileName := AFileName;
end;

destructor TSDFiles.Destroy;
begin
  Clear;
  inherited;
end;

function TSDFiles.DoLoadFromFile(const AFileName: TFileName): boolean;
var i: integer;
    SDFileList: TStringList;
begin
  Clear;
  SDFileList := TStringList.Create;
  try
    SDFileList.LoadFromFile(AFileName);
    for i := 0 to SDFileList.Count - 1 do
      if Trim(SDFileList[i]) <> '' then
        Add(SDFileList.Names[i], SDFileList.ValueFromIndex[i]);
  finally
    SDFileList.Free;
  end;
  Result := true;
end;

function TSDFiles.DoSaveToFile(const AFileName: TFileName): boolean;
var i: integer;
    SDFileList: TStringList;
begin
  SDFileList := TStringList.Create;
  try
    for i := 0 to Count - 1 do
      if SaveMode = smShort then
        SDFileList.Add(Item[i].Source + NameSep + Item[i].Des)
      else
        SDFileList.Add(Source[i] + NameSep + Des[i]);
    SDFileList.SaveToFile(AFileName);
  finally
    SDFileList.Free;
  end;
  Result := true;
end;

function TSDFiles.GetCount: integer;
begin
  Result := Length(FItems);
end;

function TSDFiles.GetDes(Index: integer): TFileName;
begin
  Result := DesPath + Item[Index].Des;
end;

function TSDFiles.GetDesInfo(Index: integer): TSearchRec;
begin
  Result := GetSearchRec(Des[Index]);
end;

function TSDFiles.GetItem(Index: integer): TSDFile;
begin
  Result := FItems[Index];
end;

function TSDFiles.GetSearchRec(AFileName: TFileName): TSearchRec;
var MyFile: TFileInfo;
begin
  MyFile := TFileInfo.Create;
  try
    MyFile.FullName := AFileName;
    Result := MyFile.SearchRec;
  finally
    MyFile.Free;
  end;
end;

function TSDFiles.GetSource(Index: integer): TFileName;
begin
  Result := SourcePath + Item[Index].Source;
end;

function TSDFiles.GetSourceInfo(Index: integer): TSearchRec;
begin
  Result := GetSearchRec(Source[Index]);
end;

function TSDFiles.SDFileCopy(SourceFile, DesFile: TFileName): boolean;
var MyFile: TFileInfo;
begin
  MyFile := TFileInfo.Create;
  try
    MyFile.FullName := SourceFile;
    Result := MyFile.CopyTo(DesFile);
  finally
    MyFile.Free;
  end;
end;

procedure TSDFiles.SetDes(Index: integer; const Value: TFileName);
begin
  FItems[Index].Des := Value;
end;

procedure TSDFiles.SetDesPath(const Value: TFileName);
begin
  FDesPath := Value;
end;

procedure TSDFiles.SetItem(Index: integer; const Value: TSDFile);
begin
  Item[Index] := Value;
end;

procedure TSDFiles.SetSource(Index: integer; const Value: TFileName);
begin
  FItems[Index].Source := Value;
end;

procedure TSDFiles.SetSourcePath(const Value: TFileName);
begin
  FSourcePath := Value;
end;

end.
