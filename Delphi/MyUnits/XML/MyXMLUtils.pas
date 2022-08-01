unit MyXMLUtils;

interface

uses XMLIntf;

function FindChildByAttr(ParentNode: IXMLNode; AttrName: string; AttrValue: OleVariant): IXMLNode;

implementation

function FindChildByAttr(ParentNode: IXMLNode; AttrName: string; AttrValue: OleVariant): IXMLNode;
var
  Node: IXMLNode;
begin
  if ParentNode <> nil then Node := ParentNode.ChildNodes.First;
  while Node <> nil do
  begin
    if Node.HasAttribute(AttrName) then
      if Node.Attributes[AttrName] = AttrValue then break;
    Node := Node.NextSibling;
  end;
  Result := Node;
end;

end.
