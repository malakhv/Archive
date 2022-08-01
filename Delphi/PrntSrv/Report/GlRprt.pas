unit GlRprt;

interface

uses ComCtrls;

const
  PageCountLabel = 'Всего страниц: ';
  RecCountLabel  = 'Количество записей: ';

type
  TNodeType = (ntNone = 0, ntUser = 1, ntPrinter = 2, ntMacnine = 3,
    ntFilter = 4);

type
  TNodeInfo = record
    NodeType: TNodeType;
    FID: integer;
  end;

type
  PNodeInfo = ^TNOdeInfo;

const
  NilNode: TNodeInfo = (NodeType: ntNone);

var
  AppDir: string;

function GetNodeType(Node: TTreeNode): TNodeType;
function GetNodeInfo(Node: TTreeNode): TNodeInfo;
procedure SetNodeType(NodeType: TNodeType; var Node: TTreeNode);
procedure SetNodeInfo(NodeInfo: TNodeInfo; var Node: TTreeNode);
procedure ClearNode(Node: TTreeNode);

implementation

uses SysUtils, Classes;

function GetNodeType(Node: TTreeNode): TNodeType;
begin
  Result := ntNone;
  if Node.Data <> nil then
  begin
    Result := TNodeInfo(Node.Data^).NodeType;
  end;
end;

function GetNodeInfo(Node: TTreeNode): TNodeInfo;
begin
  Result := NilNode;
  if Node.Data <> nil then
  begin
    Result := TNodeInfo(Node.Data^);
  end;
end;

procedure SetNodeType(NodeType: TNodeType; var Node: TTreeNode);
begin
  if Node.Data <> nil then
  begin
    TNodeInfo(Node.Data^).NodeType := NodeType;
  end;
end;

procedure SetNodeInfo(NodeInfo: TNodeInfo; var Node: TTreeNode);
var Info: PNodeInfo;
begin
  New(Info);
  Info^ := NodeInfo;
  Node.Data := Info;
end;

procedure ClearNode(Node: TTreeNode);
begin
  Dispose(Node.Data);
end;

end.
