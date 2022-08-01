unit Global;

interface

uses
  Windows, SysUtils;

var
  AppDir: TFileName;

function NetSend(Comp,Msg: string; MsgName: string = ''): DWORD;

implementation

uses NetApi32;

function NetSend(Comp, Msg: string; MsgName: string = ''): DWORD;
var wMsg, wComp, wMsgName: PWideChar;
    MsgSize,CmpSize,MsgNmSize: longint;
begin
  wMsg     := nil;
  wComp    := nil;
  wMsgName := nil;

  MsgSize   := Length(Msg) * SizeOf(WideChar) + 1;
  CmpSize   := Length(Comp) * SizeOf(WideChar) + 1;

  GetMem(wMsg,MsgSize);
  GetMem(wComp,CmpSize);

  StringToWideChar(Msg, wMsg, Length(Msg) + 1);
  StringToWideChar(Comp, wComp, Length(Comp) + 1);

  if MsgName <> '' then
  begin
    MsgNmSize := Length(MsgName) * Sizeof(WideChar) + 1;
    GetMem(wMsgName,MsgNmSize);
    StringToWideChar(MsgName,wMsgName,Length(MsgName) + 1);
    NetMessageNameAdd(nil,wMsgName);
  end;

  Result := NetMessageBufferSend(nil,wComp,wMsgName,LPBYTE(wMsg),MsgSize);

  if MsgName <> '' then
    NetMessageNameDel(nil,wMsgName);

  FreeMem(wMsg,MsgSize);
  FreeMem(wComp,CmpSize);
end;

initialization
begin
  AppDir := '';
end;

end.
