unit NodeUnit;

interface

uses ComCtrls;

const
  ID_Error = -1;

type
  TNodeType = (ntNone = 0, ntCmpt = 1, ntSwmn = 2, ntPtrc = 3, ntSwmnGrp = 4,
    ntProtocol = 5, ntHeats = 6, ntPStart = 7, ntPEnd = 8);

type
  TNdInf = record
    NodeType: TNodeType;
    ID: integer;
  end;
  PNdInf = ^TNdInf;

function GetNodeInfo(Node: TTreeNode): TNdInf;
procedure SetNodeInfo(Info: TNdInf; Node: TTreeNode);
procedure FreeNodeInfo(Node: TTreeNode);
procedure ClearTreeView(TreeView: TTreeView);

implementation

const
  NilInfo: TNdInf = (NodeType: ntNone; ID: ID_ERROR);

function GetNodeInfo(Node: TTreeNode): TNdInf;
begin
  if Node.Data <> nil then
  begin
    Result := TNdInf(Node.Data^);
  end else
    Result := NilInfo;
end;

procedure SetNodeInfo(Info: TNdInf; Node: TTreeNode);
var inf: PNdInf;
begin
  New(inf);
  inf^ := Info;
  Node.Data := inf;
end;

procedure FreeNodeInfo(Node: TTreeNode);
begin
  if Node.Data <> nil then
    Dispose(Node.Data);
end;

procedure ClearTreeView(TreeView: TTreeView);
var i: integer;
begin
  for i := 0 to TreeView.Items.Count - 1 do
  begin
    FreeNodeInfo(TreeView.Items.Item[i]);
  end;
  TreeView.Items.Clear;
end;


end.
