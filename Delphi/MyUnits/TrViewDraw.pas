unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    StatusBar1: TStatusBar;
    ListView1: TListView;
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  h: integer;
  Index: integer;

implementation

{$R *.dfm}

const

{ По умолчанию:
  clSelNodeRect = clSkyBlue;  // цвет рамки выделенного узла
  clSelNodeText = clNavy;     // цвет текста выделенного узла
  clNodeText    = clBlack;    // цвет текста
  clNodeRect    = clSilver;   // цвет рамки узла
  clSelNodeBg   = clCream;    // цвет фона выделенного узла
  clNodeBg      = clCream;    // цвет фона узла
}
  clSelNodeRect = clNavy;     // цвет рамки выделенного узла
  clSelNodeText = clNavy;     // цвет текста выделенного узла
  clNodeText    = clBlack;    // цвет текста
  clNodeRect    = clSilver;   // цвет рамки узла
  clSelNodeBg   = clCream;    // цвет фона выделенного узла
  clNodeBg      = clCream;    // цвет фона узла

const
  ndLeveSpace = 10; // отступ
  ndTextSpace = 4;

var
  SelNode: TTreeNode = nil;

procedure TForm1.TreeView1CustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var DRect,NRect,TxtRect: TRect;
    TextH,ty: integer;
begin
  //Sender.Realign;
  DRect := Node.DisplayRect(false);
  TxtRect := Node.DisplayRect(true);
  h := DRect.Bottom - DRect.Top;
  NRect.Left   := DRect.Left  + 1;
  NRect.Top    := DRect.Top   + 1;
  NRect.Right  := DRect.Right - 1;
  Nrect.Bottom := Drect.Bottom;

  with Sender.Canvas do
  begin
    Brush.Color := clNodeBg;
    if not Node.Selected then
    begin
      Pen.Color   := clNodeRect;
      Font.Color  := clNodeText;
    end else
    begin
      Pen.Color   := clSelNodeRect;
      Font.Color  := clSelNodeText;
    end;
    TextH := TextHeight(Node.Text);
    Rectangle(DRect.Left + 1,DRect.Top + 1,DRect.Right - 1, DRect.Bottom);
    ty := ( NRect.Top + ((NRect.Bottom - NRect.Top) div 2)) - (TextH div 2);
    inc(Nrect.Top);
    inc(NRect.Left);
    Dec(Nrect.Bottom);
    Dec(NRect.Right);
    //TextOut((DRect.Left + ndTextSpace) + Node.Level * ndLeveSpace ,DRect.Top + 2,Node.Text);
    //TextRect(NRect,(DRect.Left + ndTextSpace) + Node.Level * ndLeveSpace ,DRect.Top + 2,Node.Text);
    TextRect(NRect,(DRect.Left + ndTextSpace) + Node.Level * ndLeveSpace ,ty,Node.Text);
  end;

  DefaultDraw := false;
end;

procedure TForm1.TreeView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var Node: TTreeNode;
begin
  Node := (Sender as TTReeView).GetNodeAt(X,Y);
  if Node <> nil then
  begin
    if Node = SelNode then
    begin
      if Node.Expanded then Node.Collapse(false)
      else Node.Expand(false);
    end;
    (Sender as TTReeView).Selected := Node;
    SelNode := Node;
  end;
end;

end.
