unit DioTreeView;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, XMLDoc, XMLIntf, MyXML;

type

  TCustomXMLTreeView = class(TTreeView)
  private
    FXMLFile: TCustomXMLFile;
    FAddChild: boolean;
    procedure SetXMLFile(const Value: TCustomXMLFile);
    procedure SetAddChild(const Value: boolean);
  protected
    function DoGetNodeText(XMLNode: IXMLNode): string; virtual;
    function DoGetNodeData(XMLNode: IXMLNode): Pointer; virtual;
    procedure XMLFileLoad(Sender: TObject); virtual;
    procedure LoadNodeFromXML(XMLNode: IXMLNode; Node: TTreeNode; FindChild: boolean);
    procedure DoAfterNodeChange(const Node: IXMLNode; ChangeType: TNodeChange); virtual;
  public
    property AddChild: boolean read FAddChild write SetAddChild;
    property XMLFile: TCustomXMLFile read FXMLFile write SetXMLFile;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

type

  TDioTreeView = class(TCustomXMLTreeView)
  private
    FDataFileView: boolean;
    procedure SetDataFileView(const Value: boolean);
  public
    property DataFileView: boolean read FDataFileView write SetDataFileView;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TDioTreeView]);
end;


{ TCustomXMLTreeView }

constructor TCustomXMLTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FAddChild := true;
  FXMLFile := TCustomXMLFile.Create(Self);
  FXMLFile.XMLDoc.AfterNodeChange := DoAfterNodeChange;
  FXMLFile.OnLoad := XMLFileLoad;
end;

destructor TCustomXMLTreeView.Destroy;
begin
  ClearSelection;
  FXMLFile.Free;
  inherited;
end;

procedure TCustomXMLTreeView.DoAfterNodeChange(const Node: IXMLNode; ChangeType: TNodeChange);
var TreeNode: TTreeNode;
begin
  TreeNode := Self.Items.GetFirstNode;
  while TreeNode <> nil do
  begin
    if TreeNode.Data = Pointer(Node) then
    begin
      TreeNode.Text := DoGetNodeText(Node);
      break;
    end;
    TreeNode := TreeNode.GetNext;
  end;
  if TreeNode = nil then

end;

function TCustomXMLTreeView.DoGetNodeData(XMLNode: IXMLNode): Pointer;
begin
  Result := Pointer(XMLNode);
end;

function TCustomXMLTreeView.DoGetNodeText(XMLNode: IXMLNode): string;
begin
  Result := XMLNode.NodeName;
  if XMLNode.NodeName = 'DioInfo' then
    Result := XMLNode.Attributes['Number'];
end;

procedure TCustomXMLTreeView.LoadNodeFromXML(XMLNode: IXMLNode; Node: TTreeNode;
  FindChild: boolean);
var ChildNode: TTreeNode;
begin
  // Если текущий узел XML равет nil, выход
  if XMLNode = nil then Exit;
  // Добавляем новый узел в дерево
  ChildNode := Items.AddChild(Node, DoGetNodeText(XMLNode));
  // Устанавливаем значение поля Data
  ChildNode.Data := DoGetNodeData(XMLNode);
  // Добавление дочерних узлов
  if FindChild then LoadNodeFromXML(XMLNode.ChildNodes.First,ChildNode,FindChild);
  XMLNode := XMLNode.NextSibling;
  LoadNodeFromXML(XMLNode,Node, FindChild);
end;

procedure TCustomXMLTreeView.SetAddChild(const Value: boolean);
begin
  if FAddChild <> Value then
  begin
    FAddChild := Value;
    XMLFile.Update;
  end;
end;

procedure TCustomXMLTreeView.SetXMLFile(const Value: TCustomXMLFile);
begin
  //if Value <> nil then FXMLFile.Assign(Value);
end;

procedure TCustomXMLTreeView.XMLFileLoad(Sender: TObject);
begin
  ClearSelection;
  Items.Clear;
  LoadNodeFromXML(FXMLFile.FirstNode,nil, AddChild);
end;

{ TDioTreeView }

constructor TDioTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FDataFileView := true;
end;

destructor TDioTreeView.Destroy;
begin
  inherited;
end;

procedure TDioTreeView.SetDataFileView(const Value: boolean);
begin
  if FDataFileView <> Value then
  begin
    FDataFileView := Value;
    FXMLFile.Update;
  end;
end;

end.
