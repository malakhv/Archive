unit TMtrx;

interface

uses SysUtils, Classes, MyClasses;

type

  { Testcase Name type }
  TTstName = string[8];

  { Testcase Number type }
  TTstNmbr = byte;

  { Testcase Tag type }
  TTstTag  = byte;

  { Testcase Information }
  TTestInfo = record
    Name: TTstName;
    Nmbr: TTstNmbr;
    Tag: byte;
  end;

type

  { Array of Testcase Info }
  TTestInfoArray = array of TTestInfo;

  { Event }
  TAfterAddItemEvent = procedure (Sender: TObject; ItemIndex: integer) of object;

  TTestList = class(TPersistent)
  private
    FItems: TTestInfoArray;
    FOnAfterAddItem: TAfterAddItemEvent;
    function GetCount: integer;
    function GetItem(Index: integer): TTestInfo;
    procedure SetItem(Index: integer; const Value: TTestInfo);
  protected
    function AddItem: integer;
    procedure DoAfterAddItem(ItemIndex: integer); virtual;
  public
    property Item[Index: integer]: TTestInfo read GetItem write SetItem; default;
    property Count: integer read GetCount;
    property OnAfterAddItem: TAfterAddItemEvent read FOnAfterAddItem write FOnAfterAddItem;
    function Add: integer; overload;
    function Add(ATestInfo: TTestInfo): integer; overload;
    function Add(ATestName: TTstName): integer; overload;
    function Add(ATestName: TTstName; ATag: integer): integer; overload;
    function Add(ATestName: TTstName; ANumber: byte; ATag: integer): integer; overload;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

  TMatrixFile = class(TCustomFileObject)
  private
    FStrings: TStringList;
    FTestList: TTestList;
    procedure SetStrings(const Value: TStringList);
    function GetCount: integer;
    function GetTestList: TTestList;
    procedure SetTestList(const Value: TTestList);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property Count: integer read GetCount;
    property Strings: TStringList read FStrings write SetStrings;
    property TestList: TTestList read GetTestList write SetTestList;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

const

  TESTCASE_SEPARATE = '|';

{ TTestList }

function TTestList.Add: integer;
begin
  Result := Add('',0,0);
end;

function TTestList.Add(ATestInfo: TTestInfo): integer;
begin
  Result := Add(ATestInfo.Name, ATestInfo.Number, ATestInfo.Tag);
end;

function TTestList.Add(ATestName: TTstName): integer;
begin
  Result := Add(ATestName,0,0);
end;

function TTestList.Add(ATestName: TTstName; ATag: integer): integer;
begin
  Result := Add(ATestName,0,ATag);
end;

function TTestList.Add(ATestName: TTstName; ANumber: byte;
  ATag: integer): integer;
begin
  Result := AddItem;
  with FItems[Result] do
  begin
    Name := ATestName;
    Number := ANumber;
    Tag := ATag;
  end;
  DoAfterAddItem(Result);
end;

function TTestList.AddItem: integer;
begin
  Result := Count;
  SetLength(FItems,Result + 1);
end;

procedure TTestList.Clear;
begin
  SetLength(FItems,0);
end;

constructor TTestList.Create;
begin
  inherited;
  Clear;
end;

destructor TTestList.Destroy;
begin
  Clear;
  inherited;
end;

procedure TTestList.DoAfterAddItem(ItemIndex: integer);
begin
  if Assigned(FOnAfterAddItem) then
    FOnAfterAddItem(Self,ItemIndex);
end;

function TTestList.GetCount: integer;
begin
  Result := Length(FItems);
end;

function TTestList.GetItem(Index: integer): TTestInfo;
begin
  if Index < Count then
    Result := FItems[Index]
  else
    Exception.Create('Index out of range');
end;

procedure TTestList.SetItem(Index: integer; const Value: TTestInfo);
begin
  if Index < Count then
    FItems[Index] := Value
  else
    Exception.Create('Index out of range');
end;

{ TMatrixFile }

constructor TMatrixFile.Create;
begin
  inherited;
  FStrings := TStringList.Create;
  FTestList := TTestList.Create;
end;

destructor TMatrixFile.Destroy;
begin
  if Strings <> nil then Strings.Free;
  if TestList <> nil then TestList.Free;
  inherited;
end;

function TMatrixFile.DoLoadFromFile(const AFileName: TFileName): boolean;

  function GetTestName(Column: integer): string;
  var j: integer;
  begin
    Result := '';
    for j := 0 to 8 do
      Result := Result + Strings[j][Column];
  end;

var
  i: Integer;
  TmpStr: String;
begin
  Result := true;
  try
    Strings.LoadFromFile(AFileName);
    if Strings.Count > 0 then
    begin
      TmpStr := Strings[0];
      for i := Pos(TESTCASE_SEPARATE,TmpStr) + 1 to Length(TmpStr) do
        if TmpStr[i] <> TESTCASE_SEPARATE then
        begin
          TestList.Add(GetTestName(i),i);
        end;
    end;
  except
    Result := false;
  end;
end;

function TMatrixFile.DoSaveToFile(const AFileName: TFileName): boolean;
begin
  Result := true;
  try
    Strings.SaveToFile(AFileName);
  except
    Result := false;
  end;
end;

function TMatrixFile.GetCount: integer;
var
  i: Integer;
  TmpStr: String;
begin
  Result := 0;
  if Strings.Count > 0 then
  begin
    TmpStr := Strings[0];
    Delete(TmpStr,1,Pos(TESTCASE_SEPARATE,TmpStr));
    for i := 1 to Length(TmpStr) do
      if TmpStr[i] <> TESTCASE_SEPARATE then Inc(Result);
  end;
end;

function TMatrixFile.GetTestList: TTestList;
begin
  Result := FTestList;
end;

procedure TMatrixFile.SetStrings(const Value: TStringList);
begin
  if Value <> nil then FStrings.Assign(Value);
end;

procedure TMatrixFile.SetTestList(const Value: TTestList);
begin
  if Assigned(Value) then FTestList.Assign(Value);
end;

end.
