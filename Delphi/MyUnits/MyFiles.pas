unit MyFiles;

interface

uses SysUtils, Classes;

type

  { Тип для описания информации о файле }

  TCustomFileInfo = class(TPersistent)
  private
    EPath: TFileName;
    EFileData: TSearchRec;
    EAutoUpdateInfo: boolean;
    function GetDrectory: TFileName;
    function GetDrive: TFileName;
    function GetExtension: TFileName;
    function GetPath: TFileName;
    function GetShortName: TFileName;
    procedure SetAttribute(const Value: integer);
    procedure SetExtension(const Value: TFileName);
    procedure SetFullName(const Value: TFileName);
    function GetInAnyFile: boolean;
    function GetInArchive: boolean;
    function GetInDirectory: boolean;
    function GetInHidden: boolean;
    function GetInReadOnly: boolean;
    function GetInSysFile: boolean;
    function GetInVolumeID: boolean;
    function GetSearchRec: TSearchRec;
    procedure SetSearchRec(const Value: TSearchRec);
    function GetAttribute: integer;
    function GetFullName: TFileName;
    function GetFileDate: TDateTime;
    function GetSize: int64;
    procedure SetFileDate(const Value: TDateTime);
    procedure SetSize(const Value: int64);
    function GetInNormal: boolean;
  protected
    property AutoUpdateInfo: boolean read EAutoUpdateInfo write EAutoUpdateInfo;
    property FullName: TFileName read GetFullName write SetFullName;
    property Attribute: integer read GetAttribute write SetAttribute;
    property FileDate: TDateTime read GetFileDate write SetFileDate;
    property Size: int64 read GetSize write SetSize;
    property Drectory : TFileName read GetDrectory;
    property Drive: TFileName read GetDrive;
    property Extension: TFileName read GetExtension write SetExtension;
    property ShortName: TFileName read GetShortName;
    property Path: TFileName read GetPath;
    property SearchRec: TSearchRec read GetSearchRec write SetSearchRec;
    property InReadOnly: boolean read GetInReadOnly;
    property InHidden: boolean read GetInHidden;
    property InSysFile: boolean read GetInSysFile;
    property InVolumeID: boolean read GetInVolumeID;
    property InDirectory: boolean read GetInDirectory;
    property InArchive: boolean read GetInArchive;
    property InNormal: boolean read GetInNormal;
    property InAnyFile: boolean read GetInAnyFile;
    procedure UpdateInfo;
  public
    function CopyTo(AFileName: TFileName; FailIfExists: boolean = false): boolean;
    function Delete: boolean;
    function GetCRC32: Cardinal;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    procedure Clear;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TFileInfo = class(TCustomFileInfo)
  public
    property AutoUpdateInfo;
    property FullName;
    property Attribute;
    property FileDate;
    property Size;
    property Drectory;
    property Drive;
    property Extension;
    property ShortName;
    property Path;
    property SearchRec;
    property InReadOnly;
    property InHidden;
    property InSysFile;
    property InVolumeID;
    property InDirectory;
    property InArchive;
    property InAnyFile;
    property InNormal;
  end;

type

  { Массив объектов, содержащих информацию о файлах }

  TFileInfoArray = array of TFileInfo;

  { Событие возникающее при добавлении элемента }

  TAddFileInfoEvent = procedure (Sender: TObject; Index: integer) of object;

  TFileList = class(TPersistent)
  private
    EItems: TFileInfoArray;
    EOnAdd: TAddFileInfoEvent;
    function GetCount: integer;
    function GetItem(Index: integer): TFileInfo;
    procedure SetItem(Index: integer; const Value: TFileInfo);
  public
    property Item[Index: integer]: TFileInfo read GetItem write SetItem; default;
    property Count: integer read GetCount;
    property OnAdd: TAddFileInfoEvent read EOnAdd write EOnAdd;
    function Add: integer; overload;
    function Add(FileInfo: TFileInfo): integer; overload;
    function Add(FullName: TFileName): integer; overload;
    function Add(SearchRec: TSearchRec; Path: TFileName = ''): integer; overload;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    procedure Clear; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

type

  { Класс для работы с директорией }

  TDirectory = class(TFileList)
  private
    EAttribute: integer;
    EAutoUpdate: boolean;
    EDirectory: TFileName;
    EMask: TFileName;
    EOnUpdate: TNotifyEvent;
    procedure SetDirectory(const Value: TFileName);
    procedure SetMask(const Value: TFileName);
    procedure SetAttribute(const Value: integer);
  protected
    procedure UpdateFileList; virtual;
  public
    property Attribute: integer read EAttribute write SetAttribute;
    property AutoUpdate: boolean read EAutoUpdate write EAutoUpdate;
    property Directory: TFileName read EDirectory write SetDirectory;
    property Mask: TFileName read EMask write SetMask;
    property OnUpdate: TNotifyEvent read EOnUpdate write EOnUpdate;
    procedure Clear; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    constructor Create; override;
  end;

implementation

uses Windows, MyCRC;

{ TCustomFile }

procedure TCustomFileInfo.Assign(Source: TPersistent);
begin
  inherited;
  if Assigned(Source) then
  begin
    SearchRec := (Source as TCustomFileInfo).SearchRec;
    AutoUpdateInfo := (Source as TCustomFileInfo).AutoUpdateInfo;
    EPath := (Source as TCustomFileInfo).EPath;
  end;
end;

procedure TCustomFileInfo.AssignTo(Des: TPersistent);
begin
  inherited;
  if Assigned(Des) then
  begin
    (Des as TCustomFileInfo).SearchRec := SearchRec;
    (Des as TCustomFileInfo).EPath := EPath;
    (Des as TCustomFileInfo).AutoUpdateInfo := AutoUpdateInfo;
  end;
end;

procedure TCustomFileInfo.Clear;
begin
  with EFileData do
  begin
    Time := 0;
    Size := 0;
    Attr := faAnyFile;
    Name := '';
    ExcludeAttr := 0;
    FindHandle := 0;
  end;
  EPath := '';
end;

function TCustomFileInfo.CopyTo(AFileName: TFileName;
  FailIfExists: boolean): boolean;
begin
  Result := false;
  if not FileExists(FullName) then Exit;
  if Integer( CopyFile(PChar(FullName),PChar(AFileName),FailIfExists) ) <> 0 then
    Result := true;
end;

constructor TCustomFileInfo.Create;
begin
  inherited;
  Clear;
  AutoUpdateInfo := true;
end;

function TCustomFileInfo.Delete: boolean;
begin
  Result := SysUtils.DeleteFile(FullName);
  if Result then Clear;
end;

destructor TCustomFileInfo.Destroy;
begin
  inherited;
end;

function TCustomFileInfo.GetAttribute: integer;
begin
  Result := EFileData.Attr;
end;

function TCustomFileInfo.GetCRC32: Cardinal;
begin
  if FileExists(FullName) then
    Result := MyCRC.GetCRC32(FullName)
  else
    Result := 0;
end;

function TCustomFileInfo.GetDrectory: TFileName;
begin
  Result := ExtractFileDir(EPath);
end;

function TCustomFileInfo.GetDrive: TFileName;
begin
  Result := ExtractFileDrive(EPath);
end;

function TCustomFileInfo.GetExtension: TFileName;
begin
  Result := ExtractFileExt(EFileData.Name);
end;

function TCustomFileInfo.GetFileDate: TDateTime;
begin
  if EFileData.Time <> 0 then
    Result := FileDateToDateTime(EFileData.Time)
  else
    Result := Now;
end;

function TCustomFileInfo.GetFullName: TFileName;
begin
  Result := EPath + EFileData.Name;
end;

function TCustomFileInfo.GetInAnyFile: boolean;
begin
  Result := (EFileData.Attr and faAnyFile) <> 0;
end;

function TCustomFileInfo.GetInArchive: boolean;
begin
  Result := (EFileData.Attr and faArchive) <> 0;
end;

function TCustomFileInfo.GetInDirectory: boolean;
begin
  Result := (EFileData.Attr and faDirectory) <> 0;
end;

function TCustomFileInfo.GetInHidden: boolean;
begin
  Result := (EFileData.Attr and faHidden) <> 0;
end;

function TCustomFileInfo.GetInNormal: boolean;
begin
  Result := (EFileData.Attr and faNormal) <> 0;
end;

function TCustomFileInfo.GetInReadOnly: boolean;
begin
  Result := (EFileData.Attr and faReadOnly) <> 0;
end;

function TCustomFileInfo.GetInSysFile: boolean;
begin
  Result := (EFileData.Attr and faSysFile) <> 0;
end;

function TCustomFileInfo.GetInVolumeID: boolean;
begin
  Result := (EFileData.Attr and faVolumeID) <> 0;
end;

function TCustomFileInfo.GetPath: TFileName;
begin
  Result := EPath;
end;

function TCustomFileInfo.GetSearchRec: TSearchRec;
begin
  Result := EFileData;
end;

function TCustomFileInfo.GetShortName: TFileName;
begin
  Result := EFileData.Name;
end;

function TCustomFileInfo.GetSize: int64;
begin
  Result := EFileData.Size;
end;

procedure TCustomFileInfo.SetAttribute(const Value: integer);
begin
  EFileData.Attr := Value;
end;

procedure TCustomFileInfo.SetExtension(const Value: TFileName);
begin
  ChangeFileExt(EFileData.Name,Value);
end;

procedure TCustomFileInfo.SetFileDate(const Value: TDateTime);
begin
  EFileData.Time := DateTimeToFileDate(Value);
end;

procedure TCustomFileInfo.SetFullName(const Value: TFileName);
begin
  EFileData.Name := ExtractFileName(Value);
  EPath := ExtractFilePath(Value);
  if AutoUpdateInfo then
    UpdateInfo;
end;

procedure TCustomFileInfo.SetSearchRec(const Value: TSearchRec);
begin
  EFileData := Value;
end;

procedure TCustomFileInfo.SetSize(const Value: int64);
begin
  if Value >=0 then
    EFileData.Size := Value
  else
    EFileData.Size := 0;
end;

procedure TCustomFileInfo.UpdateInfo;
var SRec: TSearchRec;
begin
  if FindFirst(FullName,faAnyFile,SRec) = 0 then
    SearchRec := SRec
  else
    Clear;
  SysUtils.FindClose(SRec);
end;

{ TFileList }

function TFileList.Add(FullName: TFileName): integer;
begin
  EItems[Add].FullName := FullName;
  Result := Count - 1;
end;

function TFileList.Add(SearchRec: TSearchRec; Path: TFileName): integer;
begin
  EItems[Add].SearchRec := SearchRec;
  Result := Count - 1;
  if Path <> '' then
    EItems[Result].EPath := Path;
end;

function TFileList.Add: integer;
begin
  Result := Count;
  SetLength(EItems,Result + 1);
  EItems[Result] := TFileInfo.Create;
  if Assigned(EOnAdd) then EOnAdd(Self,Result);
end;

function TFileList.Add(FileInfo: TFileInfo): integer;
begin
  EItems[Add].Assign(FileInfo);
  Result := Count - 1;
end;

procedure TFileList.Assign(Source: TPersistent);
var i: integer;
begin
  inherited;
  Clear;
  if Source is TFileList then
    for i := 0 to (Source as TFileList).Count - 1 do
      Add((Source as TFileList)[i]);
end;

procedure TFileList.AssignTo(Des: TPersistent);
var i: integer;
begin
  inherited;
  if Des is TFileList then
  begin
    (Des as TFileList).Clear;
    for i := 0 to Count - 1 do
      (Des as TFileList).Add(Item[i]);
  end;
end;

procedure TFileList.Clear;
var i: integer;
begin
  for i := 0 to Count - 1 do
    EItems[i].Free;
  SetLength(EItems,0);
end;

constructor TFileList.Create;
begin
  inherited;
end;

destructor TFileList.Destroy;
begin
  Clear;
  inherited;
end;

function TFileList.GetCount: integer;
begin
  Result := Length(EItems);
end;

function TFileList.GetItem(Index: integer): TFileInfo;
begin
  Result := EItems[Index];
end;

procedure TFileList.SetItem(Index: integer; const Value: TFileInfo);
begin
  EItems[Index].Assign(Value);
end;

{ TDirectory }

procedure TDirectory.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TDirectory then
  begin
    EDirectory := (Source as TDirectory).Directory;
    EAutoUpdate := (Source as TDirectory).AutoUpdate;
  end;
end;

procedure TDirectory.AssignTo(Des: TPersistent);
begin
  inherited;
  if Des is TDirectory then
  begin
    (Des as TDirectory).EDirectory := Directory;
    (Des as TDirectory).EAutoUpdate := AutoUpdate;
  end;
end;

procedure TDirectory.Clear;
begin
  inherited;
  EDirectory := '';
end;

constructor TDirectory.Create;
begin
  inherited;
  EDirectory := '';
  EAutoUpdate := true;
  EMask := '*';
  EAttribute := faAnyFile;
end;

procedure TDirectory.SetAttribute(const Value: integer);
begin
  EAttribute := Value;
  if AutoUpdate then UpdateFileList;
end;

procedure TDirectory.SetDirectory(const Value: TFileName);
begin
  EDirectory := Value;
  if EDirectory[Length(EDirectory)] <> '\' then
    EDirectory := EDirectory + '\';
  if AutoUpdate then UpdateFileList;
end;

procedure TDirectory.SetMask(const Value: TFileName);
begin
  EMask := Trim(Value);
  if EMask = '' then EMask := '*';
  if AutoUpdate then UpdateFileList;
end;

procedure TDirectory.UpdateFileList;
var SRec: TSearchRec;
    FindResult: integer;
begin
  inherited Clear;
  FindResult := FindFirst(Directory + Mask,EAttribute,SRec);
  while FindResult = 0 do
  begin
    Add(SRec,Directory);
    FindResult := FindNext(SRec);
  end;
  SysUtils.FindClose(SRec);
  if Assigned(EOnUpdate) then EOnUpdate(Self);
end;

end.
