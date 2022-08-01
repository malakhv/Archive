unit DrawListView;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, Graphics;

type
  TDrawListView = class(TListView)
  private
    FSelItemColor: TColor;
    FFrameColor: TColor;
    FSelFrameColor: TColor;
    procedure SetFrameColor(const Value: TColor);
    procedure SetSelFrameColor(const Value: TColor);
    procedure SetSelItemColor(const Value: TColor);
    procedure DItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  published
    property FrameColor: TColor read FFrameColor write SetFrameColor;
    property SelFrameColor: TColor read FSelFrameColor write SetSelFrameColor;
    property SelItemColor: TColor read FSelItemColor write SetSelItemColor;
    constructor Create(AOwner: TComponent); override;   
  end;

procedure Register;

implementation

uses
  Windows, Types;

procedure Register;
begin
  RegisterComponents('Samples', [TDrawListView]);
end;

{ TDrawListView }

constructor TDrawListView.Create(AOwner: TComponent);
begin
  inherited;
  Self.Parent := TWinControl(AOwner);
  Self.OnCustomDrawItem := DItem;
  Self.ViewStyle := vsReport;
  Self.HideSelection := false;
  Self.RowSelect := true;
  Self.Font.Size := 10;
end;

procedure TDrawListView.DItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var DRect,TxtRect: TRect;
    i,w: integer;
    Wdth: integer;
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
  Wdth := DRect.Right - 1;
  Sender.Canvas.Rectangle(DRect.Left + 1,DRect.Top,Wdth,DRect.Bottom - 1);
  TxtRect := DRect;
  TxtRect.Left := 2;
  Dec(TxtRect.Right,2);
  Dec(TxtRect.Bottom,2);
  Inc(TxtRect.Top);
  Sender.Canvas.TextRect(TxtRect,DRect.Left + 4,Drect.Top  - 1,Item.Caption);
  w := 0;
  for i := 0 to Item.SubItems.Count - 1 do
  begin
    w := w + Sender.Column[i].Width;
    DRect.Left := w + 1;
    TxtRect.Left := DRect.Left;
    Sender.Canvas.TextRect(TxtRect,DRect.Left + 4,Drect.Top - 1,Item.SubItems.Strings[i]);
  end;
  DefaultDraw := false;
end;

procedure TDrawListView.SetFrameColor(const Value: TColor);
begin
  FFrameColor := Value;
end;

procedure TDrawListView.SetSelFrameColor(const Value: TColor);
begin
  FSelFrameColor := Value;
end;

procedure TDrawListView.SetSelItemColor(const Value: TColor);
begin
  FSelItemColor := Value;
end;

end.
