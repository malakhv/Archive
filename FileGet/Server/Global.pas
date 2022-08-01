unit  Global;
interface
uses  SysUtils, WinSock, ComCtrls;

const Def_Port = 5320;

type  TMes = record
        Cmd: integer;
        Param: string[200];
      end;

var   WSAData: TWSAData;
      WSAEnabled: boolean = false;


procedure StartWSA;
procedure StopWSA;
function  GetAddrString(const addr:TSockAddr): string;
function GetNameByAddress(const addr:TSockAddr): string;

implementation

procedure StartWSA;
begin
  WSAEnabled := WSAStartup($101,WSAData) <> -1;
end;

procedure StopWSA;
begin
  if not WSAEnabled then Exit;
  WSACleanup;
  WSAEnabled := false;
end;

function GetAddrString(const addr:TSockAddr): string;
begin
  Result := IntToStr(byte(addr.sin_addr.s_un_b.s_b1))+'.'+
            IntToStr(byte(addr.sin_addr.s_un_b.s_b2))+'.'+
            IntToStr(byte(addr.sin_addr.s_un_b.s_b3))+'.'+
            IntToStr(byte(addr.sin_addr.s_un_b.s_b4));
end;

function GetNameByAddress(const addr:TSockAddr): string;
var HostEnt: PHostEnt;
begin
  Result := '';
  if not WSAEnabled then Exit;
  HostEnt:= GetHostByAddr(@addr.sin_addr.S_addr,4,AF_INET);
  if HostEnt <> nil then Result := StrPas(Hostent^.h_name);
end;

end.
