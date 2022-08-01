unit Query;

interface

uses
  Classes;

const
  AllFields = '*'; 

// Тип строки SQL запроса
type
  TSQLStr = WideString;

type
  TFieldList = class(TPersistent)
  private
    FItems: array of TSQLStr;
    function GetCount: integer;
    function GetItem(Index: integer): TSQLStr;
    procedure SetItem(Index: integer; const Value: TSQLStr);
  public
    property Item[Index: integer]: TSQLStr read GetItem write SetItem; default;
    property Count: integer read GetCount;
    function Add(Field: TSQLStr): integer;
    procedure Clear;
    procedure Delete(Index: integer);
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TCustomSQL = class(TPersistent)
  private
    FTable: TSQLStr;
    FFields: TFieldList;
    FOrderBy: TSQLStr;
    FWhere: TSQLStr;
    procedure SetFields(const Value: TFieldList);
    procedure SetTable(const Value: TSQLStr);
  protected
    property Table: TSQLStr read FTable write SetTable;
    property Fields: TFieldList read FFields write SetFields;
    property OrderBy: TSQLStr read FOrderBy write FOrderBy;
    property Where: TSQLStr read FWhere write FWhere;
  public
    function Select: TSQLStr; overload;
    class function Select(ATable, AFields, AWhere: TSQLStr;
      AOrderBy: TSQLStr = ''): TSQLStr; overload;
    class function Select(ATable: TSQLStr; AFields: TFieldList;
      AWhere: TSQLStr; AOrderBy: TSQLStr = ''): TSQLStr; overload;
    class function Select(ATable, AOrderBy: TSQLStr): TSQLStr; overload;
    class function SelectByField(ATable, AFields, AField: TSQLStr;
      Value: Variant; AOrderBy: TSQLStr = ''): TSQLStr; overload;
    class function SelectByField(ATable: TSQLStr; AFields: TFieldList;
      AField: TSQLStr; Value: Variant; AOrderBy: TSQLStr = ''): TSQLStr; overload;
    procedure Clear;
    constructor Create; overload;
    constructor Create(ATable: TSQLStr); overload;
    destructor Destroy; override;
  end;

  TSQL = class(TCustomSQL)
  public
    property Table;
    property Fields;
    property OrderBy;
    property Where;
  end;

implementation

uses Variants;

// Подготовка параметров SQL запроса
//    Param - параметр запроса
function ParamToStr(Param: Variant): TSQLStr;
begin
  // Если параметр - строка, то дополняем кавычками,
  // в противном случае, приводим к строке
  if VarIsStr(Param) then
    Result := '''' + Param + ''''
  else
    Result := VarToStr(Param);
end;

// Подготовка списка полей
//  ATableName - имя таблицы
//  AFielas - список полей
function FieldsToStr(ATableName: TSQLStr; AFields: TFieldList): TSQLStr;
var i: integer;
begin
  Result := '';
  if Assigned(AFields) then
  begin
    for i := 0 to AFields.Count - 1 do
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + ATableName + '.' + AFields[i];
    end;
  end else
    Result := '*';
end;

{ TFieldList }

function TFieldList.Add(Field: TSQLStr): integer;
begin
  Result := Length(FItems);
  SetLength(FItems,Result + 1);
  FItems[Result] := Field;
end;

procedure TFieldList.Assign(Source: TPersistent);
var i: integer;
begin
  if Source is TFieldList then
  begin
    Clear;
    for i:= 0 to (Source as TFieldList).Count - 1 do
      Add((Source as TFieldList)[i]);
    inherited Assign(Source);
  end;
end;

procedure TFieldList.Clear;
begin
  SetLength(FItems,0);
end;

constructor TFieldList.Create;
begin
  inherited;
  SetLength(FItems,0);
end;

procedure TFieldList.Delete(Index: integer);
var i: integer;
begin
  for i := Index to Length(FItems) - 2 do
  begin
    FItems[i] := FItems[i+1];
  end;
  SetLength(FItems,Length(FItems) - 1);
end;

destructor TFieldList.Destroy;
begin
  Clear;
  inherited;
end;

function TFieldList.GetCount: integer;
begin
  Result := Length(FItems);
end;

function TFieldList.GetItem(Index: integer): TSQLStr;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index];
end;

procedure TFieldList.SetItem(Index: integer; const Value: TSQLStr);
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    FItems[Index] := Value;
end;

{ TQueryString }

procedure TCustomSQL.Clear;
begin
  FFields.Clear;
  FTable := '';
end;

constructor TCustomSQL.Create;
begin
  inherited Create;
  FFields := TFieldList.Create;
end;

constructor TCustomSQL.Create(ATable: TSQLStr);
begin
  Create;
  FTable := ATable;
end;

destructor TCustomSQL.Destroy;
begin
  FFields.Free;
  inherited Destroy;
end;

class function TCustomSQL.Select(ATable: TSQLStr; AFields: TFieldList; AWhere,
  AOrderBy: TSQLStr): TSQLStr;
begin
  Result := Select(ATable,FieldsToStr(ATable,AFields),AWhere,AOrderBy);
end;

class function TCustomSQL.Select(ATable, AFields, AWhere,
  AOrderBy: TSQLStr): TSQLStr;
begin
  Result := 'Select ' + AFields + ' from ' + ATable;
  if AWhere <> '' then
    Result := Result + ' where ' + AWhere;
  if AOrderBy <> '' then
    Result := Result + ' order by ' + AOrderBy;
end;

class function TCustomSQL.Select(ATable, AOrderBy: TSQLStr): TSQLStr;
begin
  Result := Select(ATable,AllFields,'',AOrderBy);
end;

function TCustomSQL.Select: TSQLStr;
begin
  Result := Select(FTable,Fields,Where,OrderBy);
end;

class function TCustomSQL.SelectByField(ATable: TSQLStr; AFields: TFieldList;
  AField: TSQLStr; Value: Variant; AOrderBy: TSQLStr): TSQLStr;
begin
  Result := SelectByField(ATable,FieldsToStr(ATable,AFields),AField,Value,
    AOrderBy);
end;

class function TCustomSQL.SelectByField(ATable, AFields, AField: TSQLStr;
  Value: Variant; AOrderBy: TSQLStr): TSQLStr;
var
  sqlWhere: TSQLStr;
begin
  sqlWhere := ATable + '.' + AField + ' = ' + ParamToStr(Value);
  Result := Select(ATable,AFields,sqlWhere,AOrderBy);
end;

procedure TCustomSQL.SetFields(const Value: TFieldList);
begin
  if Assigned(Value) then
    FFields.Assign(Value);
end;

procedure TCustomSQL.SetTable(const Value: TSQLStr);
begin
  FTable := Value;
end;

end.
