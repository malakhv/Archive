unit NetRes;

interface

uses Windows;

type
  TStrRes = string[255];

type
  TNetResInfo = record
    dwScope      : DWORD;
    dwDisplayType: DWORD;
    dwType       : DWORD;
    dwUsage      : DWORD;
    LocalName    : TStrRes;
    RemoteName   : TStrRes;
    Comment      : TStrRes;
    Provider     : TStrRes;
  end;

type
  TNetResCollection = array of TNetResInfo;

type
  TNetResList = class(TObject)
  private
    FNetRes: TNetResCollection;
    FResScope: LongWord;
    FResType: LongWord;
    FResUsage: LongWord;
    function GetCount: integer;
    function GetRes(i: integer): TNetResInfo;
    procedure AddCompInfo(NetRes: TNetResource);
    function EnumerateFunc(PNetRes: PNetResource): boolean;
    procedure CopyNetRes(Source: TNetResource; var Dest: TNetResInfo);
  public
    property ResScope: LongWord read FResScope write FResScope;
    property ResType : LongWord read FResType  write FResType;
    property ResUsage: LongWord read FResUsage write FResUsage;
    property Items[i: integer]: TNetResInfo read GetRes;
    property Count: integer read GetCount;
    procedure Clear;
    procedure CreateResList;
    constructor Create(GetNetRes: boolean = false);
    destructor Destroy; override;
  end;

implementation

uses SysUtils;

{ TNetResList }

const
  MaxNetRes = 1023;

constructor TNetResList.Create(GetNetRes: boolean);
begin
  inherited Create;
  FResScope := RESOURCE_GLOBALNET;
  FResType  := RESOURCETYPE_ANY;
  FResUsage := RESOURCEUSAGE_CONTAINER;
  if GetNetRes then
    CreateResList;
end;

destructor TNetResList.Destroy;
begin
  SetLength(FNetRes,0);
  inherited;
end;

procedure TNetResList.AddCompInfo(NetRes: TNetResource);
begin
  SetLength(FNetRes,Length(FNetRes)+1);
  CopyNetRes(NetRes,FNetRes[Length(FNetRes)-1]);
end;

procedure TNetResList.CopyNetRes(Source: TNetResource; var Dest: TNetResInfo);
begin
  Dest.dwScope       := Source.dwScope;
  Dest.dwType        := Source.dwType;
  Dest.dwDisplayType := Source.dwDisplayType;
  Dest.dwUsage       := Source.dwUsage;
  Dest.LocalName     := StrPas(Source.lpLocalName);
  Dest.RemoteName    := StrPas(Source.lpRemoteName);
  Dest.Comment       := StrPas(Source.lpComment);
  Dest.Provider      := StrPas(Source.lpProvider);
end;

function TNetResList.EnumerateFunc(PNetRes: PNetResource): boolean;
type
  TNetResArray = array [0..MaxNetRes] of TNetResource;
  PNetResArray = ^TNetResArray;
var Rslt, RsltEnum, Buf, Entr: DWORD;
    EnumHandle: THandle;
    PNetResLocal: PNetResArray;
    NRes: TNetResource; i: integer;
begin
  Result := false;

  Rslt := WNetOpenEnum(FResScope, FResType, FResUsage,
    PNetResourceA(PNetRes), EnumHandle);
  if Rslt <> NO_ERROR then Exit;

  New(PNetResLocal);
  if PNetResLocal = nil then Exit;

  repeat
    Buf := SizeOf(TNETRESOURCE)*1024;
    Entr := 1;
    RsltEnum := WNetEnumResource(EnumHandle, Entr, PNetResLocal, Buf);
    if RsltEnum = NO_ERROR then
    begin
      for i := 0 to Entr - 1 do
      begin
        Move(PNetResLocal^[i],NRes,SizeOf(NRes));
        AddCompInfo(NRes);
        if (PNetResLocal^[i].dwDisplayType and RESOURCEUSAGE_CONTAINER ) =
          RESOURCEUSAGE_CONTAINER then
        begin
          EnumerateFunc(@PNetResLocal^[i]);
        end;
      end;
    end;
  until  RsltEnum = ERROR_NO_MORE_ITEMS;
  Result := true;
end;

procedure TNetResList.Clear;
begin
  SetLength(FNetRes,0);
end;

function TNetResList.GetRes(i: integer): TNetResInfo;
begin
  Result := FNetRes[i];
end;

function TNetResList.GetCount: integer;
begin
  Result := Length(FNetRes);
end;

procedure TNetResList.CreateResList;
begin
  Clear;
  EnumerateFunc(nil);
end;



end.
