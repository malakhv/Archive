unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Node, StdCtrls, NodePanel, Buttons, ComCtrls, Menus,
  ExtDlgs;

type
  TMainForm = class(TForm)
    ObjectPanel: TPanel;
    CentralPanel: TPanel;
    ptnPanel: TPanel;
    Label1: TLabel;
    lblNumber: TLabel;
    btnAddNode: TSpeedButton;
    btnAddWay: TSpeedButton;
    WayList: TListView;
    btnDelWay: TSpeedButton;
    btnSaveFile: TSpeedButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    btnOpenFile: TSpeedButton;
    btnClearWayList: TSpeedButton;
    btnAddWey2: TSpeedButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    mnClearNodePanel: TMenuItem;
    SavePictureDialog: TSavePictureDialog;
    StatusBar1: TStatusBar;
    ResultPanel: TPanel;
    ResList: TListBox;
    btnFind: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblNode: TLabel;
    lblLength: TLabel;
    lblType: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    btnSave: TSpeedButton;
    N8: TMenuItem;
    N9: TMenuItem;
    NodeBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAddNodeClick(Sender: TObject);
    procedure btnAddWayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelWayClick(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure btnClearWayListClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure mnClearNodePanelClick(Sender: TObject);
  private
    procedure NodeClick(Sender: TObject);
    procedure ViewInfo(Sender: TObject);
    procedure FindWay(Node1,Node2: integer);

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  nd,nd2,nd3: TNode;
  NodePanel: TNodePanel;
  SelNode: boolean;

implementation

uses InfoWayUnit, AboutUnit;

{$R *.dfm}

procedure TMainForm.NodeClick(Sender: TObject);
begin
  ViewInfo(Sender);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  NodePanel := TNodePanel.Create(CentralPanel);
  NodePanel.Parent := CentralPanel;
  NodePanel.Align := alClient;
end;

procedure TMainForm.btnAddNodeClick(Sender: TObject);
begin
  NodePanel.AddNode;
  NodePanel.Items[Length(NodePanel.Items)-1].OnClick := NodeClick;
  NodeBox.Items.AddObject(IntToStr(NodePanel.Items[Length(NodePanel.Items)-1].Number),
    TObject(Length(NodePanel.Items)-1)); 
end;

procedure TMainForm.btnAddWayClick(Sender: TObject);
var i,j: integer; w:TWay; f: boolean;
begin
  WayForm.NodeBox.Items.Clear;
  if NodePanel.Selected = nil then Exit;
  WayForm.lblNumber.Caption := IntToStr(NodePanel.Selected.Number);
  // Определение подходящих узлов назначения
  for i := 0 to Length(NodePanel.Items) - 1 do
  begin
    if NodePanel.Items[i] = NodePanel.Selected then Continue;
    f := true;
    // если уже есть путь, в список не включаем
    for j := 0 to Length(NodePanel.Selected.Links) - 1 do
    begin
      if NodePanel.Selected.Links[j].Index = i then
      begin f := false; break; end;
    end;
    if f then
    WayForm.NodeBox.Items.AddObject(IntToStr(NodePanel.Items[i].Number),
      TObject(i));
  end;
  if WayForm.ShowModal = mrOK then
  begin
    if WayForm.NodeBox.ItemIndex = -1 then exit;
    i := Integer(WayForm.NodeBox.Items.Objects[WayForm.NodeBox.ItemIndex]);
    w.Node := @NodePanel.Items[i];
    w.Length := StrToIntDef(WayForm.WayEdit.Text,1);
    w.Index := i;
    NodePanel.Selected.AddWay(w);
    ViewInfo(NodePanel.Selected);
  end; 
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if NodePanel <> nil then NodePanel.Destroy;  
end;

procedure TMainForm.ViewInfo(Sender: TObject);
var i: integer; item: TListItem;
begin
  lblNumber.Caption :=  IntToStr((Sender as TNode).Number);
  WayList.Items.Clear;
  for i := 0 to Length((Sender as TNode).Links)-1  do
  begin
    item := WayList.Items.Add;
    item.Caption := IntToStr(NodePanel.items[(Sender as TNode).Links[i].Index].Number);
    item.SubItems.Add(IntToStr((Sender as TNode).Links[i].Length));
    item.Data := Pointer(i);
  end;
  lblNode.Caption   := IntToStr((Sender as TNode).Metka.Node + 1);
  lblLength.Caption := IntToStr((Sender as TNode).Metka.Length);
  case (Sender as TNode).Metka.MType of
    mtNone : lblType.Caption := 'None';
    mtTime : lblType.Caption := 'Time';
    mtConst: lblType.Caption := 'Const';
  end;
end;

procedure TMainForm.btnDelWayClick(Sender: TObject);
begin
  if WayList.Selected = nil then Exit;
  NodePanel.Selected.DeleteWay(Integer(WayList.Selected.Data));
  WayList.Items.Delete(WayList.Selected.Index);
  NodePanel.Repaint;
end;

procedure TMainForm.btnSaveFileClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    NodePanel.SaveToFile(SaveDialog.FileName); 
  end;
end;

procedure TMainForm.btnOpenFileClick(Sender: TObject);
var i: integer;
begin
  if OpenDialog.Execute then
  begin
    ResList.Clear;
    NodeBox.Clear;
    WayList.Items.Clear;
    NodePanel.LoadFromFile(OpenDialog.FileName);
    for i := 0 to Length(NodePanel.Items) - 1 do
    begin
      NodePanel.Items[i].OnClick := NodeClick;
      if i <> 0 then NodeBox.Items.AddObject(IntToStr(NodePanel.Items[i].Number),TObject(i));
    end;
  end;
end;

procedure TMainForm.btnClearWayListClick(Sender: TObject);
var i: integer;
begin
  for i := 0 to WayList.Items.Count - 1 do
  begin
    NodePanel.Selected.DeleteWay(Integer(WayList.Items[i].Data));
  end;
  WayList.Items.Clear; 
  NodePanel.Repaint;
end;

procedure TMainForm.N5Click(Sender: TObject);
begin
  NodePanel.Destroy;
  Application.Terminate; 
end;

procedure TMainForm.FindWay(Node1,Node2: integer);
var flag: boolean; i,j: integer;
    CurrentNode: integer;
    lngth: integer; minlngth,min: integer;
    str: string;
    Res: array of integer; 
begin

  CurrentNode := 0;
  NodePanel.Items[0].Metka.Length := 0;
  NodePanel.Items[0].Metka.Node   := -1;
  NodePanel.Items[0].Metka.MType  := mtConst;

  str := 'Узел '+IntToStr(1) + '  Метка ' +'  ['+ IntToStr(0)+':'+ '-]' + '  ' + 'П';
  ResList.Items.Add(str);

  flag := false;
  while flag = false do
  begin
    //просмотр меток узлов, в которые можно попасть из данного
    //
    for i := 0 to Length(NodePanel.Items[CurrentNode].Links) - 1 do
    begin
      j := NodePanel.Items[CurrentNode].Links[i].Index;
      lngth := NodePanel.Items[CurrentNode].Links[i].Length +
        NodePanel.Items[CurrentNode].Metka.Length;
      if NodePanel.Items[j].Metka.MType = mtConst then Continue;
      if(NodePanel.Items[j].Metka.MType <> mtNone)and
        (NodePanel.Items[j].Metka.Length <= lngth) then Continue;
      // замена метки
      NodePanel.Items[j].Metka.Length := lngth;
      NodePanel.Items[j].Metka.Node   := CurrentNode;
      NodePanel.Items[j].Metka.MType  := mtTime;
      str := 'Узел '+IntToStr(j+1) +'  Метка ' + '  ['+ IntToStr(lngth)+
                                   ':'+IntToStr(CurrentNode+1) + ']  ' + 'В';
      ResList.Items.Add(str);
    end;
    // проверка, все ли метки постоянные
    flag := true;
    for i := 0 to Length(NodePanel.Items) - 1 do
    begin
      if(NodePanel.Items[i].Metka.MType = mtTime)or
        (NodePanel.Items[i].Metka.MType = mtNone) then
      begin
        flag := false; break;
      end;
    end;

    min := -1;
    minlngth := 999999999;
    // поиск минимального значения пути (след. шаг ищем в общем)
    if not flag then
    begin
      for i := 0 to Length(NodePanel.Items[CurrentNode].Links) - 1 do
      begin
        j := NodePanel.Items[CurrentNode].Links[i].Index;
        lngth := NodePanel.Items[CurrentNode].Links[i].Length;
        if NodePanel.Items[j].Metka.MType = mtConst then Continue;
        if lngth < minlngth then
        begin
          min := j; minlngth := lngth;
        end;
      end;
    end;
    if min <> - 1 then
    begin
      lngth := NodePanel.Items[CurrentNode].Metka.Length + minlngth;
      NodePanel.Items[min].Metka.Length := lngth;
      NodePanel.Items[min].Metka.Node   := CurrentNode;
      NodePanel.Items[min].Metka.MType  := mtConst;
      str := 'Узел '+IntToStr(min + 1) + '  Метка ' + '  ['+ IntToStr(lngth)+
                                      ':'+IntToStr(CurrentNode+1) + ']  ' + 'П';
      ResList.Items.Add(str);
      CurrentNode := min;
    end
    else begin
      CurrentNode := NodePanel.Items[CurrentNode].Metka.Node;
    end;
  end;

  SetLength(Res,0);
  // Ищем путь
  CurrentNode := Node2-1; // если Node2 - номер узла
  lngth := NodePanel.Items[Node2-1].Metka.Length;
  while CurrentNode <> Node1-1 do
  begin
    SetLength(Res,Length(Res)+1);
    Res[Length(Res)-1] := CurrentNode + 1;
    CurrentNode := NodePanel.Items[CurrentNode].Metka.Node;
  end;
  SetLength(Res,Length(Res)+1);
  Res[Length(Res)-1] := CurrentNode + 1;

  str := '';
  for i := Length(Res) - 1 downto 0  do
  begin
    if i <> 0 then str := str + '(' + IntToStr(Res[i]) + ')' + ' -> '
    else  str := str + '(' + IntToStr(Res[i]) + ')';
  end;
  str := str + '   Lenght = '+IntToStr(lngth);
  ResList.Items.Add(str);
end;

procedure TMainForm.btnFindClick(Sender: TObject);
var n1,n2: integer;
begin
  if Length(NodePanel.Items) > 1 then
   if NodeBox.ItemIndex <> -1 then
   begin
     n2 := NodePanel.Items[Integer(NodeBox.Items.Objects[NodeBox.ItemIndex])].Number;
     FindWay(1,n2);
   end;
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    ResList.Items.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.N9Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.mnClearNodePanelClick(Sender: TObject);
begin
  NodePanel.ItemsClear;
  NodeBox.Clear;
  ResList.Clear;
  WayList.Items.Clear;
  NodePanel.Repaint; 
end;

end.
