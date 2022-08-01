unit CompList;

interface

uses Windows;

type
  TMyString = string[255];

type
  TCompInfo = record
    dwScope      : DWORD;
    dwDisplayType: DWORD;
    dwType       : DWORD;
    dwUsage      : DWORD;
    LocalName    : TMyString;
    RemoteName   : TMyString;
    Comment      : TMyString;
    Provider     : TMyString;
  end;

type
  PCompInfo = ^TCompInfo;

type
  TCompList = array of TCompInfo;

type
  TNetCompList = class(TObject)
  private
    FComp: TCompList;
    function GetCount: integer;
    function GetComp(i: integer): TCompInfo;
    procedure AddCompInfo(NetRes: TNetResource);
    procedure CopyCompInfo(Source: TNetResource; var Info: TCompInfo);
    function EnumerateFunc(PNetRes: PNetResource): boolean;
  public
    property Comp[i: integer]: TCompInfo read GetComp;
    property Count: integer read GetCount;
    procedure Clear;
    procedure GetCompList;
    constructor Create(GetNetRes: boolean = false);
    destructor Destroy; override;
  end;

implementation

uses SysUtils;

{ TNetCompList }

constructor TNetCompList.Create(GetNetRes: boolean);
begin
  inherited Create;
  if GetNetRes then
    GetCompList;
end;

destructor TNetCompList.Destroy;
begin
  Clear;
  inherited;
end;

procedure TNetCompList.AddCompInfo(NetRes: TNetResource);
begin
  SetLength(FComp,Length(FComp)+1);
  CopyCompInfo(NetRes,FComp[Length(FComp)-1]);
end;

procedure TNetCompList.CopyCompInfo(Source: TNetResource; var Info: TCompInfo);
begin
  Info.dwScope       := Source.dwScope;
  Info.dwType        := Source.dwType;
  Info.dwDisplayType := Source.dwDisplayType;
  Info.dwUsage       := Source.dwUsage;
  Info.LocalName     := StrPas(Source.lpLocalName);
  Info.RemoteName    := StrPas(Source.lpRemoteName);
  Info.Comment       := StrPas(Source.lpComment);
  Info.Provider      := StrPas(Source.lpProvider);
end;

function TNetCompList.EnumerateFunc(PNetRes: PNetResource): boolean;

type
  TNetResArray = array [0..1023] of TNetResource;
  PNetResArray = ^TNetResArray;
  
var dwResult, dwResultEnum: DWORD;
    hEnum: THandle;
    cbBuffer, cEntries: DWORD;
    PNetResLocal: PNetResArray;
    i: integer;
    inf: TNetResource;
begin
  Result := false;

  dwResult := WNetOpenEnum(RESOURCE_GLOBALNET,RESOURCETYPE_ANY,
    RESOURCEUSAGE_CONTAINER, PNetResourceA(PNetRes), hEnum);
  if dwResult <> NO_ERROR then Exit;

  New(PNetResLocal);
  if PNetResLocal = nil then Exit;

  repeat
    cbBuffer := SizeOf(TNETRESOURCE)*1024;
    cEntries := 1;
    dwResultEnum := WNetEnumResource(hEnum, cEntries, PNetResLocal, cbBuffer);
    if dwResultEnum = NO_ERROR then
    begin
      for i := 0 to cEntries - 1 do
      begin
        Move(PNetResLocal^[i],inf,SizeOf(inf));
        AddCompInfo(inf);
        if (PNetResLocal^[i].dwDisplayType and RESOURCEUSAGE_CONTAINER ) =
          RESOURCEUSAGE_CONTAINER then
        begin
          EnumerateFunc(@PNetResLocal^[i]);
        end;
      end;
    end;
  until  dwResultEnum = ERROR_NO_MORE_ITEMS;
end;

procedure TNetCompList.Clear;
begin
  SetLength(FComp,0);
end;

function TNetCompList.GetComp(i: integer): TCompInfo;
begin
  Result := FComp[i];
end;

function TNetCompList.GetCount: integer;
begin
  Result := Length(FComp);
end;

procedure TNetCompList.GetCompList;
begin
  Clear;
  EnumerateFunc(nil);
end;

end.
