unit NodeAndItemWork;
interface

uses ComCtrls,TypeAndConstUnit;

procedure SetDataNode(Data:TNodeData; var Node:TTreeNode);
procedure GetDataNode(Node:TTreeNode;var Data:TNodeData);
procedure DelDataNode(Node:TTreeNode);


procedure ClearTreeView(var TrView:TTreeView);


implementation

procedure SetDataNode(Data:TNodeData; var Node:TTreeNode);
var dt:^TNodeData;
begin
 New(dt);
 dt^.NodeType := Data.NodeType;
 dt^.ID := Data.ID;
 Node.Data := dt;       
end;

procedure GetDataNode(Node:TTreeNode;var Data:TNodeData);
var dt:^TNodeData;
begin
 if Node.Data = nil then
 begin
   Data.NodeType := ntNone;
   Data.ID := 0;
   Exit;
 end;
 dt := Node.Data;
 Data.NodeType := dt^.NodeType;
 Data.ID := dt^.ID;
end;

procedure DelDataNode(Node:TTreeNode);
var dt:^TNodeData;
begin
 if Node.Data = nil then Exit;
 dt := Node.Data;
 Dispose(dt);
end;

procedure ClearTreeView(var TrView:TTreeView);
var CurItem:TTreeNode;
begin
 CurItem := TrView.Items.GetFirstNode;
 while CurItem <> nil do
 begin
  if CurItem.Data <> nil then DelDataNode(CurItem);
  CurItem := CurItem.GetNext;
 end;
 TrView.Items.Clear;
end;

end.
