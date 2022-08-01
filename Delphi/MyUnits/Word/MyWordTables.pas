unit MyWordTables;

interface

uses MyOleObject, MyWordObject;

type

  TWordTableCell = class(TBaseOleObject)
  private
    FRange: TWordRange;
    function GetColumn: integer;
    function GetRow: integer;
  public
    property Range: TWordRange read FRange;
    property Row: integer read GetRow;
    property Column: integer read GetColumn;
    procedure SetCell(ARow,AColumn: integer);
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

type

  TWordTable = class(TOleItem)
  private
    FCell: TWordTableCell;
    function GetCell(Row, Column: integer): TWordTableCell;
  protected
    function DoGetIndex: integer; override;
  public
    property Cell[Row,Column: integer]: TWordTableCell read GetCell;
    procedure AutoFormat(AFormat: integer);
    procedure Delete;
    procedure Select;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

type

  TWordTables = class(TOleCollection)
  private
    FTable: TWordTable;
    function GetItem(Index: integer): TWordTable;
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    property Item[Index: integer]: TWordTable read GetItem; default;
    function Add(Range: TOleObject; NumRows, NumColumns: integer; Format: integer = 16): TWordTable; overload;
    function Add(Range: OleVariant; NumRows, NumColumns: integer; Format: integer = 16): TWordTable; overload;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

implementation

uses Variants;

{ TWordTableCell }

constructor TWordTableCell.Create(AParent: TOleObject);
begin
  inherited;
  FRange := TWordRange.Create(Self);
end;

destructor TWordTableCell.Destroy;
begin
  FRange.Free;
  inherited;
end;

function TWordTableCell.GetColumn: integer;
begin
  if Exists then
    Result := OleObj.Column
  else
    Result := -1;
end;

function TWordTableCell.GetRow: integer;
begin
  if Exists then
    Result := OleObj.Row
  else
    Result := -1;
end;

procedure TWordTableCell.SetCell(ARow, AColumn: integer);
begin
  if ParentExists then
    OleObj := Parent.OleObj.Cell(ARow, AColumn);
end;

{ TWordTable }

procedure TWordTable.AutoFormat(AFormat: integer);
begin
  if Exists then
    OleObj.AutoFormat(Format:=AFormat);
end;

constructor TWordTable.Create(AParent: TOleObject);
begin
  inherited;
  FCell := TWordTableCell.Create(Self);
end;

procedure TWordTable.Delete;
begin
  if Exists then OleObj.Delete;
end;

destructor TWordTable.Destroy;
begin

  inherited;
end;

function TWordTable.DoGetIndex: integer;
begin
  if ParentExists then
    Result := TOleCollection(Parent).IndexOf(OleObj)
  else
    Result := -1;
end;

function TWordTable.GetCell(Row, Column: integer): TWordTableCell;
begin
  FCell.SetCell(Row, Column);
  Result := FCell;
end;

procedure TWordTable.Select;
begin
  if Exists then OleObj.Select;
end;

{ TWordTables }

function TWordTables.Add(Range: TOleObject; NumRows, NumColumns, Format: integer): TWordTable;
begin
  if Exists then
  begin
    FTable.OleObj := OleObj.Add(Range.OleObj, NumRows, NumColumns);
    //FTable.AutoFormat(Format);
  end;
  Result := FTable;
end;

function TWordTables.Add(Range: OleVariant; NumRows, NumColumns, Format: integer): TWordTable;
begin
  if Exists then
  begin
    FTable.OleObj := OleObj.Add(Range, NumRows, NumColumns);
    //FTable.AutoFormat(Format);
  end;
  Result := FTable;
end;

constructor TWordTables.Create(AParent: TOleObject);
begin
  inherited;
  FTable := TWordTable.Create(Self);
end;

destructor TWordTables.Destroy;
begin
  FTable.Free;
  inherited;
end;

function TWordTables.DoGetOleObj: OleVariant;
begin
  if ParentExists then
    Result := Parent.OleObj.Tables
  else
    VarClear(Result);
end;

procedure TWordTables.DoSetOleObj(AOleObj: OleVariant);
begin
  inherited;
end;

function TWordTables.GetItem(Index: integer): TWordTable;
begin
  if (Index > 0) and (Index <= Count) then
    //FTable.OleObj := OleObj.Item(Index)
    FTable.Index := Index
  else
    FTable.Index := -1;
  Result := FTable;
end;

end.
