unit QueryBuilder;

interface

uses
  Classes, XMLIntf, XMLDoc;

const
  NO_ERROR           = 1;
  PARAMS_COUNT_ERROR = 2;
  QUERYNAME_ERROR    = 3;
  NO_QUERY           = 4;
  NO_OPEN_FILE       = 5;
  FIND_NODE_ERROR    = 6;

const
  QueryNodeName   = 'Query';
  SQLNodeName     = 'sql';
  QueryParamStart = '$';

type
  TQueryString = WideString;

type
  TQueryParamType = (ptNone = 0, ptInt = 1, ptStr = 2, ptDateTime = 3);

type
  TQueryParam = record
    Name : TQueryString;
    Value: TQueryString;
    ParamType: TQueryParamType;
    function GetValue: Variant;
  end;

  TQueryParams = array of TQueryParam;

const
  NilParam: TQueryParam = (Name: ''; Value: ''; ParamType: ptNone);

type

  TQueryParamList = class(TPersistent)
  private
    FItems: TQueryParams;
    function GetCount: integer;
    function GetItem(Index: integer): TQueryParam;
    procedure SetItem(Index: integer; const Value: TQueryParam);
  public
    property Count: integer read GetCount;
    property Item[Index: integer]: TQueryParam read GetItem write SetItem;
    procedure Add(QueryParam: TQueryParam); overload;
    procedure Add(Name: TQueryString; Value: Variant;
      ParamType: TQueryParamType); overload;
    procedure Delete(Index: integer);
    function FindParam(ParamName: TQueryString): TQueryParam;
    function IndexOf(ParamName: TQueryString): integer;
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TErrorNotification = procedure(Sender: TObject; ErrorCode: integer) of object;

type
  TQueryBuilder = class(TXMLDocument)
  private
    FLastError: integer;
    FOnError: TErrorNotification;
    FQueryName: TQueryString;
    FQuery: TQueryString;
    procedure SetQueryName(const Value: TQueryString);
    function FindNode(NodeName: TQueryString; ParentNode: IXMLNode = nil): IXMLNode;
    function FindQuery(AQueryName: TQueryString): IXMLNode;
    function GetIsFileOpen: boolean;
    function GetSQL(QueryNode: IXMLNode): TQueryString;
  protected
    procedure SetLastError(ErrorCode: integer = NO_ERROR); virtual;
  public
    property QueryName: TQueryString read FQueryName write SetQueryName;
    property Query: TQueryString read FQuery;
    property LastError: integer read FLastError;
    property IsFileOpen: boolean read GetIsFileOpen;
    function GetQuery(AQueryName: TQueryString; Params: array of Variant): TQueryString;
    constructor Create(AOwner: TComponent); override;
  published
    property OnError: TErrorNotification read FOnError write FOnError;
  end;

implementation

uses
  SysUtils, Variants;

{ TQueryParam }

function TQueryParam.GetValue: Variant;
begin
  // �������� ���� ���������
  case Self.ParamType of
    ptNone: Result := '';
    ptInt: Result := StrToInt(Self.Value);
    ptStr: Result := Self.Value;
    ptDateTime: Result := StrToDateTime(Self.Value);
  end;
end;

{ TQueryParamList }

procedure TQueryParamList.Add(QueryParam: TQueryParam);
begin
  // ���������� ��������
  SetLength(FItems,Self.Count + 1);
  FItems[Self.Count - 1] := QueryParam;
end;

procedure TQueryParamList.Add(Name: TQueryString; Value: Variant;
  ParamType: TQueryParamType);
var QueryParam: TQueryParam;
begin
  QueryParam.Name := Name;
  QueryParam.Value := VarToStr(Value);
  QueryParam.ParamType := ParamType;
  Self.Add(QueryParam);
end;

procedure TQueryParamList.Assign(Source: TPersistent);
var i: integer;
begin
  // ����� ������ �������
  inherited;
  // �������� ������ ���������
  SetLength(FItems,(Source as TQueryParamList).Count);
  for i := 0 to Self.Count - 1 do
    FItems[i] := (Source as TQueryParamList).Item[i];
end;

constructor TQueryParamList.Create;
begin
  inherited;
end;

procedure TQueryParamList.Delete(Index: integer);
var i: Integer;
begin
  if (Index >= 0) and (Index < Self.Count) then
  begin
    for i := Index to Self.Count - 2 do
      FItems[i] := FItems[i + 1];
    SetLength(FItems, Self.Count - 1);
  end;
end;

destructor TQueryParamList.Destroy;
begin
  SetLength(FItems,0);
  inherited;
end;

function TQueryParamList.FindParam(ParamName: TQueryString): TQueryParam;
var index: integer;
begin
  index := Self.IndexOf(ParamName);
  if index <> -1 then
    Result := FItems[index];
end;

function TQueryParamList.GetCount: integer;
begin
  Result := Length(FItems);
end;

function TQueryParamList.GetItem(Index: integer): TQueryParam;
begin
  if (Index >= 0) and (Index < Self.Count) then
    Result := FItems[Index]
  else
    Result := NilParam;
end;

function TQueryParamList.IndexOf(ParamName: TQueryString): integer;
var i: integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do
    if FItems[i].Name = ParamName then
    begin
      Result := i;
      Break;
    end;
end;

procedure TQueryParamList.SetItem(Index: integer; const Value: TQueryParam);
begin
  if (Index >= 0) and (Index < Self.Count) then
    FItems[Index] := Value;
end;

{ TQueryBuilder }


constructor TQueryBuilder.Create(AOwner: TComponent);
begin
  inherited;
  FLastError := NO_ERROR;
end;

function TQueryBuilder.FindNode(NodeName: TQueryString; ParentNode: IXMLNode): IXMLNode;
begin
  Result := nil;
  // ���� ���� �� ������ - ������
  if not Self.IsFileOpen then Exit;
  // ���� �������� <> nil, �� ���� �������� �������
  if ParentNode <> nil then
    Result := ParentNode.ChildNodes.FindNode(NodeName)
  else
    Result := Self.ChildNodes.FindNode(NodeName);
  // ��������� �����
  if Result = nil then
    SetLastError(FIND_NODE_ERROR);
end;

function TQueryBuilder.FindQuery(AQueryName: TQueryString): IXMLNode;
var Node: IXMLNode;
begin
  Result := nil;
  // �������� �������� �����
  if not Self.IsFileOpen then Exit;
  // Root Directory
  Node := Self.FindNode(QueryNodeName,nil);
  if Node <> nil then
    Result := Self.FindNode(AQueryName,Node);
end;

function TQueryBuilder.GetIsFileOpen: boolean;
begin
  // ���� ���� �� ������ - false
  Result := Self.FileName <> '';
  if not Result then
    SetLastError(NO_OPEN_FILE);
end;

function TQueryBuilder.GetQuery(AQueryName: TQueryString; Params: array of Variant): TQueryString;
var Node: IXMLNode;
    Query: TQueryString;
    ParamsCount, ParamPos, i: integer;
begin
  Result := '';
  // ����� �������
  Node := FindQuery(AQueryName);
  if Node <> nil then
  begin
    // ���������� ���������� �������
    ParamsCount := Node.ChildNodes.Count - 1;
    // �������� ���������� ����������
    if Length(Params) <> ParamsCount then
    begin
      // �������� ����� ���������� �������
      SetLastError(PARAMS_COUNT_ERROR);
      Exit;
    end;
    Node := Self.FindNode(SQLNodeName,Node);
    if Node <> nil then
    begin
      Query := Node.NodeValue;
      Node := Node.NextSibling;
      i := 0;
      // ������ ����������
      while Node <> nil do
      begin
        // ����� ����� ��������� � �������
        ParamPos := Pos(QueryParamStart + Node.NodeValue,Query);
        // ���� �������� ������
        if ParamPos > 0 then
        begin
          // �������� ����� ��������� �� �������
          Delete(Query,ParamPos,Length(Node.NodeValue) + 1);
          // ������� �������� ���������
          Insert(VarToStr(Params[i]),Query,ParamPos);
        end;
        // ������� � ���������� ����
        Node := Node.NextSibling;
        Inc(i);
      end;
      Result := Query;
    end;
  end;
end;

function TQueryBuilder.GetSQL(QueryNode: IXMLNode): TQueryString;
var Node: IXMLNode;
begin
  Result := '';
  // �������� �������� �����
  if not Self.IsFileOpen then Exit;
  if QueryNode <> nil then
  begin
    Node := FindNode(SQLNodeName,QueryNode);
    if Node <> nil then
      Result := Node.NodeValue
  end else
    SetLastError(FIND_NODE_ERROR);
end;

procedure TQueryBuilder.SetLastError(ErrorCode: integer);
begin
  FLastError := ErrorCode;
  if ErrorCode <> NO_ERROR then
    if Assigned(OnError) then
      OnError(Self,ErrorCode);
end;

procedure TQueryBuilder.SetQueryName(const Value: TQueryString);
var Node: IXMLNode;
begin
  FQueryName := '';
  FLastError := NO_ERROR;
  if not Self.IsFileOpen then Exit;
  Node := FindQuery(Value);
  if Node <> nil then
  begin
    FQueryName := Self.GetSQL(Node);
  end;
end;

end.
