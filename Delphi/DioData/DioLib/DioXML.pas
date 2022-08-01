unit DioXML;

interface

uses MyXMLNode;

type

  { Базовый класс для работы с узлом, у которого есть атрибуты Name и Caption }

  TCustomDioXML = class(TXMLNodeObject)
  private
    function GetName: string;
    procedure SetName(const Value: string);
    function GetCaption: string;
    procedure SetCaption(const Value: string);
  public
    property Name: string read GetName write SetName;
    property Caption: string read GetCaption write SetCaption;
  end;

type

  { Тип коллекции (список полей, список данных статистики, список шаблонов отчетов) }

  TDioXMLType = (dxtNone = 0, dxtFields = 1, dxtStats = 2, dxtReports = 3);

  { Коллекция узлов }

  TXMLDioCollection = class(TXMLNodeObject)
  private
    FDioType: byte;
    FXMLType: TDioXMLType;
    function GetCount: integer;
    procedure SetDioType(const Value: byte);
    procedure SetXMLType(const Value: TDioXMLType);
  protected
    procedure DoSetDioType(ADioType: byte); virtual;
  public
    property DioType: byte read FDioType write SetDioType;
    property Count: integer read GetCount;
    property XMLType: TDioXMLType read FXMLType write SetXMLType;
    procedure Update;
    constructor Create(ADioType: byte); reintroduce; virtual;
  end;

implementation

uses uDioOpt;

{ TDioXML }

function TCustomDioXML.GetCaption: string;
begin
  Result := Attribute[aCaption];
end;

function TCustomDioXML.GetName: string;
begin
  Result := Attribute[aName];
end;

procedure TCustomDioXML.SetCaption(const Value: string);
begin
  Attribute[aCaption] := Value;
end;

procedure TCustomDioXML.SetName(const Value: string);
begin
  Attribute[aName] := Value;
end;

{ TXMLDioCollection }

constructor TXMLDioCollection.Create(ADioType: byte);
begin
  inherited Create(nil);
  XMLType := dxtNone;
  DioType := ADioType;
end;

procedure TXMLDioCollection.DoSetDioType(ADioType: byte);
begin
  FDioType := ADioType;
  Update;
end;

function TXMLDioCollection.GetCount: integer;
begin
  if Exists then
    Result := XMLNode.ChildNodes.Count
  else
    Result := 0;
end;

procedure TXMLDioCollection.SetDioType(const Value: byte);
begin
  DoSetDioType(Value);
end;

procedure TXMLDioCollection.SetXMLType(const Value: TDioXMLType);
begin
  FXMLType := Value;
  Update;
end;

procedure TXMLDioCollection.Update;
begin
  case XMLType of
    dxtFields: XMLNode := GetNodeByName(nFields, DioType);
    dxtStats: XMLNode := GetNodeByName(nStats, DioType);
    dxtReports: XMLNode := GetNodeByName(nReports, DioType);
  else
    XMLNode := nil;
  end;
end;

end.
