unit MNameUnit;

interface

var
  MachineName: string;

implementation

uses SysUtils, netapi32;

function GetMachineName: string;
var inf: PWKSTA_INFO_100;
    tmp: LPBYTE;
begin
  Result := '';
  NetWkstaGetInfo(nil,100,tmp);
  inf := PWKSTA_INFO_100(tmp);
  if inf = nil then Exit;
  Result :=  string(inf^.wki100_computername);
end;

initialization
begin
  MachineName := GetMachineName;
end;

end.
