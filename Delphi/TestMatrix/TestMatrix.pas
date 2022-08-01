//******************************************************************************
//*
//* Mikhail Malakhov
//*
//******************************************************************************
unit TestMatrix;

interface

uses SysUtils, Classes;

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
    Tag: TTstTag;
  end;

  { Array of Testcase Info }
  TTestInfoArray = array of TTestInfo;

type

  TTestList = class(TPersistent)
  private
    FTestList: TTestInfoArray;
  protected
    function AddItem: integer; virtual;
  public
    function Add(TestName: TTstName): integer; overload;
    function Add(TestInfo: TTestInfo): integer; overload;
    function Add(TestName: TTstName; Number: TTstNmbr; Tag: TTstTag): integer; overload;
    function Count: integer;
    function IndexOf(TestInfo: TTestInfo): integer; overload;
    function IndexOf(TestName: TTstName): integer; overload;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TTestList }

function TTestList.Add(TestName: TTstName): integer;
var
  LCount: integer;
begin
  LCount = Count;
  Result := Add(TestName,LCount,LCount + 1);
end;

function TTestList.Add(TestName: TTstName; Number: TTstNmbr;
  Tag: TTstTag): integer;
begin
  Result := AddItem;
  with FTestList[Result] do
  begin
    Name := TestName;
    Nmbr := Number;
    Tag  := Tag;
  end;
end;

function TTestList.Add(TestInfo: TTestInfo): integer;
begin
  with TestInfo do Result := Add(Name, Nmbr, Tag);
end;

function TTestList.AddItem: integer;
begin
  Result := Count;
  SetLength(FTestList,Result + 1);
end;

procedure TTestList.Clear;
begin
  SetLength(FTestList,0);
end;

function TTestList.Count: integer;
begin
  Result := Length(FTestList);
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

function TTestList.IndexOf(TestName: TTstName): integer;
begin
  for Result := 0 to Count - 1 do
    if FTestList[Result].Name = TestName then Exit;
  Result := -1;
end;

function TTestList.IndexOf(TestInfo: TTestInfo): integer;
begin
  for Result := 0 to Count - 1 do
    if FTestList[Result] = TestInfo then Exit;
  Result := -1;
end;

end.
