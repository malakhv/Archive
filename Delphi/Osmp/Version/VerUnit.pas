unit VerUnit;

interface

uses MyClasses;

var
  Ver: TVersion;

implementation

initialization
begin
  Ver := TVersion.Create;
end;

finalization
begin
  Ver.Free;
end;

end.
