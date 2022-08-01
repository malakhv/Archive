unit NodeAndItemWork;
interface

uses ComCtrls,TypeAndConstUnit;

procedure SetDataNode(Data:TNodeData; var Node:TTreeNode);
procedure GetDataNode(Node:TTreeNode;var Data:TNodeData);
procedure DelDataNode(Node:TTreeNode);

procedure SetDataItem(Data:TListItemData;var Item:TListItem);
procedure GetDataItem(Item:TListItem; var Data:TListItemData);
procedure DelDataItem(Item:TListItem);

procedure ClearTreeView(var TrView:TTreeView);
procedure ClearListView(var LsView:TListView);


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
   Data.ID := -10;
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

procedure SetDataItem(Data:TListItemData;var Item:TListItem);
var dt: ^TListItemData;
begin
 New(dt);
 dt^.ID := Data.ID;
 dt^.NameID := Data.NameID;
 dt^.Str := '';
 dt^.Str := Data.Str;
 Item.Data := dt;
end;

procedure GetDataItem(Item:TListItem; var Data:TListItemData);
var dt: ^TListItemData;
begin
 if Item.Data = nil then
 begin
  Data.ID := -10;
  Data.NameID := -10;
  Data.Str := '';
  Exit;
 end;
 dt := Item.Data;
 Data.ID := dt^.ID;
 Data.NameID := dt^.NameID;
 Data.Str := '';
 Data.Str := dt^.Str;
end;

procedure DelDataItem(Item:TListItem);
var dt: ^TListItemData;
begin
 if Item.Data = nil then Exit;
 dt := Item.Data;
 dt^.Str := '';
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

procedure ClearListView(var LsView:TListView);
var i:integer;
begin
 for i := 0 to LsView.Items.Count - 1 do
 begin
   DelDataItem(LsView.Items.Item[i]);
 end;
 LsView.Items.Clear;
end;

end.
