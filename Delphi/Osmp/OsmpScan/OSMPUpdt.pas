unit OSMPUpdt;

interface

uses SysUtils, MyClasses;

type
  TUpdateFile = class(TCustomFileObject)
  private
    EUpdtDate: TDateTime;
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property UpdtDate: TDateTime read EUpdtDate write EUpdtDate;
    function Compare(AFileName: TFileName): integer;
    constructor Create; override;
  end;

implementation

uses Windows;

{ TUpdateFile }

function TUpdateFile.Compare(AFileName: TFileName): integer;
var Source: TUpdateFile;
begin
  Result := 0;
  Source := TUpdateFile.Create;
  try
    Source.FileName := AFileName;
    if UpdtDate > Source.UpdtDate then Result := 1;
    if UpdtDate < Source.UpdtDate then Result := -1;
    if UpdtDate = Source.UpdtDate then Result := 0;
  finally
    Source.Free;
  end;
end;

constructor TUpdateFile.Create;
begin
  inherited;
  EUpdtDate := StrToDateTime('01.01.01 00:00:00');
end;

function TUpdateFile.DoLoadFromFile(const AFileName: TFileName): boolean;
var MyFile: integer;
begin
  Result := false;
  MyFile := FileOpen(AFileName,fmOpenRead);
  if MyFile <> 0 then
    Result := FileRead(MyFile,EUpdtDate, SizeOf(EUpdtDate) ) = SizeOf(EUpdtDate);
  SysUtils.FileClose(MyFile);
end;

function TUpdateFile.DoSaveToFile(const AFileName: TFileName): boolean;
var MyFile: integer;
begin
  Result := false;
  MyFile := FileOpen(AFileName,fmOpenWrite);
  if MyFile <> 0 then
    Result := FileWrite(MyFile,EUpdtDate, SizeOf(EUpdtDate) ) = SizeOf(EUpdtDate);
  FileClose(MyFile);
end;

end.
