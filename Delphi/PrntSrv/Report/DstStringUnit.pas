unit DstStringUnit;

interface

uses Classes;

type
  TStrArray = array of String;

type
  TDisStringList = class(TStringList)
  private
    FStrArray: TStrArray;
    function GetDisCount: integer;
    function GetStrCount: integer;
  protected
    property StrCount: integer read GetStrCount;
    procedure ClearStr;
    procedure AddStr(const Str: string);
    function FindStr(const FStr: string): boolean;
  public
    property DisCount: integer read GetDisCount;
    constructor Create;
    destructor Destroy; override; 
  end;

implementation

{ TDisStringList }

constructor TDisStringList.Create;
begin
  inherited Create;
  SetLength(FStrArray,0);
end;

destructor TDisStringList.Destroy;
begin
  SetLength(FStrArray,0);
  inherited;
end;

procedure TDisStringList.AddStr(const Str: string);
begin
  SetLength(FStrArray,Length(FStrArray) + 1);
  FStrArray[Length(FStrArray) - 1] := Str;
end;

function TDisStringList.GetDisCount: integer;
var i: integer;
begin
  ClearStr;
  for i := 0 to Self.Count - 1 do
  begin
    if not FindStr(Self.Strings[i]) then AddStr(Self.Strings[i]);
  end;
  Result := Length(FStrArray);
end;

function TDisStringList.GetStrCount: integer;
begin
  Result := Length(FStrArray);
end;

function TDisStringList.FindStr(const FStr: string): boolean;
var i: integer;
begin
  Result := false;
  for i := 0 to Length(FStrArray) - 1 do
  begin
    if FStrArray[i] = FStr then
    begin
      Result := true;
      break;
    end;
  end;
end;

procedure TDisStringList.ClearStr;
begin
  SetLength(FStrArray,0);
end;

end.
