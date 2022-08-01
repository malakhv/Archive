unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    procedure ListView1CustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var SelItemIndex: integer = -1;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListView1.Color := RGB(238,243,250);
end;

procedure TForm1.ListView1CustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var DRect,TxtRect: TRect;
    i,w: integer;
begin
  DRect := Item.DisplayRect(drBounds);
  if (Item.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := RGB(207,218,231);//clCream;
  Sender.Canvas.Font.Color := RGB(40,113,233);
  Sender.Canvas.Pen.Color := clSilver;

  if Item.Selected then
  begin
    with Sender.Canvas do
    begin
      Pen.Color := clNavy;
    end;
    Sender.Canvas.Brush.Color := clSkyBlue;
  end;

  if Item.Index = SelItemIndex then
  begin
    Sender.Canvas.Brush.Color := RGB(0,68,181);//clRed;
  end;


  Sender.Canvas.Rectangle(DRect.Left + 1,DRect.Top,Sender.ClientWidth - 1,DRect.Bottom - 1);
  TxtRect := DRect;
  TxtRect.Left := 2;
  Dec(TxtRect.Right,2);
  Dec(TxtRect.Bottom,2);
  Inc(TxtRect.Top);
  Sender.Canvas.TextRect(TxtRect,DRect.Left + 4,Drect.Top  - 1,Item.Caption);

  
  //w := Sender.Column[0].Width + 1;
  for i := 0 to Item.SubItems.Count - 1 do
  begin
    w := w + Sender.Column[i].Width;
    DRect.Left := w + 1;
    TxtRect.Left := DRect.Left;
    Sender.Canvas.TextRect(TxtRect,DRect.Left + 4,Drect.Top - 1,Item.SubItems.Strings[i]);
  end;

  DefaultDraw := false;

end;

procedure TForm1.ListView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var Item: TListItem;
    Index: integer;
begin
  if Button = mbRight then
  begin
    Item := (Sender as TListView).GetItemAt(X,Y);
    asm
      mov eax, SelItemIndex;
      mov Index, eax;
      mov SelItemIndex,-1;
    end;
    if Item <> nil then
    begin
      if Index <> Item.Index then
        SelItemIndex := Item.Index;
    end;
    (Sender as TListView).Invalidate;
  end;
end;

end.
