// Misha. SoftLine
// Получение информации о доступных устройствах
unit Drives;
interface
uses Classes,SysUtils,Windows;

type TDriveInfo = record
       RootPath  : string[200];    // Путь корневого каталога диска
       DriveType : integer;      // Тип устройства
       SectorsPerCluster: DWord; // Число секторов в кластере
       BytesPerSector  : DWord;  // Число байт в секторе
       NumFreeClusters : DWord;  // Число свободных кластеров
       TotalClusters   : DWord;  // Общее число кластеров
       FreeSpace : int64;        // Свободное пространство на диске
       TotalSpace: int64;        // Размер диска
       DriveByte : byte;         // Значение байта устройства
     end;

const Len_DriveInfo = sizeof(TDriveInfo);

type TArrayDrive = array of TDriveInfo;

var DriveList : TArrayDrive;
    DriveCount: integer = 0;
    DriveInfo : TDriveInfo;

procedure FreeDriveList;
procedure AddDriveInfo(const DInfo: TDriveInfo);
procedure FreeDriveInfo(var DInfo: TDriveInfo);
function GetDriveFreeSpace(var DInfo: TDriveInfo): boolean;
function GetDrive: integer;

implementation

procedure FreeDriveList;
begin
  SetLength(DriveList,0);
  DriveCount := 0; 
end;

procedure AddDriveInfo(const DInfo: TDriveInfo);
begin
  SetLength(DriveList,Length(DriveList)+1);
  DriveList[Length(DriveList)-1].RootPath   := DInfo.RootPath;
  DriveList[Length(DriveList)-1].DriveType  := DInfo.DriveType;
  DriveList[Length(DriveList)-1].SectorsPerCluster := DInfo.SectorsPerCluster;
  DriveList[Length(DriveList)-1].BytesPerSector    := DInfo.BytesPerSector;
  DriveList[Length(DriveList)-1].NumFreeClusters   := DInfo.NumFreeClusters;
  DriveList[Length(DriveList)-1].TotalClusters     := DInfo.TotalClusters;
  DriveList[Length(DriveList)-1].FreeSpace  := DInfo.FreeSpace;
  DriveList[Length(DriveList)-1].TotalSpace := DInfo.TotalSpace;
  DriveList[Length(DriveList)-1].DriveByte := DInfo.DriveByte;
  inc(DriveCount);
end;

procedure FreeDriveInfo(var DInfo: TDriveInfo);
begin
  DInfo.RootPath := '';          DInfo.DriveType := 0;
  DInfo.SectorsPerCluster := 0;   DInfo.BytesPerSector := 0;
  DInfo.NumFreeClusters := 0;    DInfo.TotalClusters := 0;
  DInfo.FreeSpace := 0;          DInfo.TotalSpace := 0;
  DInfo.DriveByte := 0;
end;

function GetDriveFreeSpace(var DInfo: TDriveInfo): boolean;
var str: string;
begin
  Result := false;
  if DInfo.DriveByte = 1 then exit; // исключаем дискеты
  str := DInfo.RootPath;
  if GetDiskFreeSpace(PChar(str),DInfo.SectorsPerCluster,DInfo.BytesPerSector,
                        DInfo.NumFreeClusters,DInfo.TotalClusters) then
  begin
    DInfo.FreeSpace  := DiskFree(DInfo.DriveByte);
    DInfo.TotalSpace := DiskSize(DInfo.DriveByte);
    Result := true; 
  end;
end;

function GetDrive: integer;
var i,DType: integer; str:string;
begin
  Result := 0;
  for i := 65 to 90 do
  begin
    FreeDriveInfo(DriveInfo);
    str := chr(i) + ':\';
    DType := GetDriveType(PChar(str));
    if(DType = DRIVE_REMOVABLE)or(DType = DRIVE_FIXED)or(DType = DRIVE_REMOTE)
            or(DType = DRIVE_CDROM) then
    begin
      DriveInfo.RootPath := str;
      DriveInfo.DriveType := DType;
      DriveInfo.DriveByte := i - 64;
      if GetDriveFreeSpace(DriveInfo) then AddDriveInfo(DriveInfo);
    end;
  end;
end;

end.
