unit MyXMLNode;

interface

uses Classes, XMLIntf;

type

  TCustomXMLNodeObject = class(TPersistent)
  private
    FXMLWork: boolean;
    FOnChange: TNotifyEvent;
    function GetXMLNode: IXMLNode;
    procedure SetXMLNode(const Value: IXMLNode);
    function GetAttribute(AttrName: string): OleVariant;
    procedure SetAttribute(AttrName: string; const Value: OleVariant);
    function GetNodeValue: OleVariant;
    procedure SetNodeValue(const Value: OleVariant);
    function GetChilds(ChildName: string): IXMLNode;
    function GetChildValue(ChildName: string): OleVariant;
    procedure SetChildValue(ChildName: string; const Value: OleVariant);
  protected
    function IsNodeWrk: boolean; virtual;
    function DoGetXMLNode: IXMLNode; virtual; abstract;
    function DoSetXMLNode(AXMLNode: IXMLNode): boolean; virtual; abstract;
    procedure DoChange;
  public
    property Attribute[AttrName: string]: OleVariant read GetAttribute write SetAttribute;
    property ChildNode[ChildName: string]: IXMLNode read GetChilds;
    property ChildValue[ChildName: string]: OleVariant read GetChildValue write SetChildValue;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property XMLNode: IXMLNode read GetXMLNode write SetXMLNode;
    property XMLWork: boolean read FXMLWork write FXMLWork;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Exists: boolean; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure FirstSibling;
    procedure NextSibling;
    procedure PrevSibling;
    constructor Create(AXMLNode: IXMLNode); virtual;
  end;

type

  TXMLNodeObject = class(TCustomXMLNodeObject)
  private
    FXMLNode: IXMLNode;
  protected
    function DoGetXMLNode: IXMLNode; override;
    function DoSetXMLNode(AXMLNode: IXMLNode): boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  end;

function FindNode(Node: IXMLNode; NodeName: string): IXMLNode;

implementation

function FindNode(Node: IXMLNode; NodeName: string): IXMLNode;
var ChildNode: IXMLNode;
begin
  Result := nil;
  // ≈сли источник = nil, выход
  if Node = nil then Exit;
  // ≈сли узел не найден, то поиск среди дочерних узлов
  if Node.NodeName <> NodeName then
  begin
    ChildNode := Node.ChildNodes.First;
    while ChildNode <> nil do
    begin
      Result := FindNode(ChildNode,NodeName);
      if Result <> nil then break;
      ChildNode := ChildNode.NextSibling;
    end;
  end else
    Result := Node;
  // ≈сли ничего не найдено, переходим к следующему узлу на уровне Node
  if Result = nil then Result := FindNode(Node.NextSibling,NodeName);
end;

{ TCustomXMLNodeObject }

procedure TCustomXMLNodeObject.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomXMLNodeObject then
    XMLWork := TCustomXMLNodeObject(Source).XMLWork;
end;

constructor TCustomXMLNodeObject.Create(AXMLNode: IXMLNode);
begin
  inherited Create;
  FXMLWork := true;
  if AXMLNode <> nil then XMLNode := AXMLNode;
end;

procedure TCustomXMLNodeObject.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TCustomXMLNodeObject.Exists: boolean;
begin
  Result := XMLNode <> nil;
end;

procedure TCustomXMLNodeObject.FirstSibling;
begin
  if XMLNode.ParentNode <> nil then
    XMLNode := XMLNode.ParentNode.ChildNodes.First
  else
    XMLNode := XMLNode.OwnerDocument.ChildNodes.First;
end;

function TCustomXMLNodeObject.GetAttribute(AttrName: string): OleVariant;
begin
  Result := '';
  if Exists then
    if XMLNode.HasAttribute(AttrName) then
      Result := XMLNode.Attributes[AttrName];
end;

function TCustomXMLNodeObject.GetChilds(ChildName: string): IXMLNode;
begin
  Result := XMLNode.ChildNodes[ChildName];
end;

function TCustomXMLNodeObject.GetChildValue(ChildName: string): OleVariant;
begin
  if ChildNode[ChildName] <> nil then
    Result := ChildNode[ChildName].NodeValue
  else
    VarClear(Result);
end;

function TCustomXMLNodeObject.GetNodeValue: OleVariant;
begin
  Result := XMLNode.NodeValue;
end;

function TCustomXMLNodeObject.GetXMLNode: IXMLNode;
begin
  Result := DoGetXMLNode;
end;

function TCustomXMLNodeObject.IsNodeWrk: boolean;
begin
  Result := Exists and FXMLWork;
end;

procedure TCustomXMLNodeObject.NextSibling;
begin
  XMLNode := XMLNode.NextSibling;
end;

procedure TCustomXMLNodeObject.PrevSibling;
begin
  XMLNode := XMLNode.PreviousSibling;
end;

procedure TCustomXMLNodeObject.SetAttribute(AttrName: string; const Value: OleVariant);
begin
  if Exists then
    if XMLNode.HasAttribute(AttrName) then
      XMLNode.Attributes[AttrName] := Value;
end;

procedure TCustomXMLNodeObject.SetChildValue(ChildName: string;
  const Value: OleVariant);
begin
  if ChildNode[ChildName] <> nil then
    ChildNode[ChildName].NodeValue := Value;
end;

procedure TCustomXMLNodeObject.SetNodeValue(const Value: OleVariant);
begin
  XMLNode.NodeValue := Value;
end;

procedure TCustomXMLNodeObject.SetXMLNode(const Value: IXMLNode);
begin
  if DoSetXMLNode(Value) then DoChange;
end;

{ TXMLNodeObject }

procedure TXMLNodeObject.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TXMLNodeObject then
    XMLNode := TXMLNodeObject(Source).XMLNode;
end;

function TXMLNodeObject.DoGetXMLNode: IXMLNode;
begin
  Result := FXMLNode;
end;

function TXMLNodeObject.DoSetXMLNode(AXMLNode: IXMLNode): boolean;
begin
  Result := FXMLNode <> AXMLNode;
  if Result then
    FXMLNode := AXMLNode;
end;

end.
