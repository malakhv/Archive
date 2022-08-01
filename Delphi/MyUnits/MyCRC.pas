unit MyCRC;

interface

uses SysUtils;

function GetCRC32(FileName: TFileName): Cardinal;

implementation

uses Classes, IdHashCRC;

function GetCRC32(FileName: TFileName): Cardinal;
var
  CRC32: TIdHashCRC32;
  Stream: TFileStream;
begin

  if not FileExists(FileName)  then
  begin
    Result := 0;
    Exit;
  end;

  Stream := TFileStream.Create(FileName,fmShareDenyNone);
  try
    CRC32 := TIdHashCRC32.Create;
    try
      Result := Abs(CRC32.HashValue(Stream));
    finally
      CRC32.Free;
    end;
  finally
    Stream.Free;
  end;
end;

end.
