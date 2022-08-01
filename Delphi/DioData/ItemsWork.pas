unit ItemsWork;

interface

uses SysUtils, ComCtrls;

type

  PDioNode = ^TDioNode;
  TDioNode = record
    Number: integer;
    FileName: TFileName;
  end;

  procedure ClearNodeInfo(Node: TTreeNode);
  procedure SetNodeInfo(Node: TTreeNode; ANumber: integer; AFileName: TFileName = '');
  function GetNodeInfo(Node: TTreeNode): TDioNode;

implementation

  procedure SetNodeInfo(Node: TTreeNode; ANumber: integer; AFileName: TFileName = '');
  var Info: PDioNode;
  begin
    New(Info);
    Info^.Number := ANumber;
    Info^.FileName := AFileName;
    Node.Data := Info;
  end;

  function GetNodeInfo(Node: TTreeNode): TDioNode;
  begin
    Result.Number := TDioNode(Node.Data^).Number;
    Result.FileName := TDioNode(Node.Data^).FileName;
  end;

  procedure ClearNodeInfo(Node: TTreeNode);
  begin
    if Node.Data <> nil then
    begin
      Dispose(Node.Data);
      Node.Data := nil;
    end;
  end;

end.
