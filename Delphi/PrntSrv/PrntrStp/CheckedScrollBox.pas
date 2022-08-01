unit CheckedScrollBox;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, Graphics, Menus;

type
  TCheckedScrollBox = class(TScrollBox)
  private
    FRowHeight: integer;
    FCheckColor: TColor;
    FClear: boolean;
    FAutoSizeCheck: boolean;
    FSelColor: TColor;
    FSetFont: boolean;
    FFont: TFont;
    procedure SetSelColor(const Value: TColor);
    procedure SetAutoSizeCheck(const Value: boolean);
    procedure SetCheckColor(const Value: TColor);
    function GetCount: integer;
    procedure SetRowHeight(const Value: integer);
    procedure AllignSize;
    procedure ChMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure SetFont(const Value: TFont);
  protected
    procedure MouseMove(Shift: TShiftState; X,Y: Integer);override;
    function CanResize(var NewWidth, NewHeight: Integer): Boolean;override;
  public
    Items: array of TCheckBox;
    Selected: TCheckBox;
    property Font: TFont read FFont write SetFont;
    property RowHeight: integer read FRowHeight write SetRowHeight;
    property Count: integer read GetCount;
    property CheckColor: TColor read FCheckColor write SetCheckColor;
    property SelColor: TColor read FSelColor write SetSelColor;
    property AutoSizeCheck: boolean read FAutoSizeCheck write SetAutoSizeCheck;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Add(Text: string; Menu: TPopupMenu; Tag: integer; Checked: boolean);
    procedure Clear;
    procedure SetCheckedAll(Checked: boolean);
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TCheckedScrollBox]);
end;

{ TCheckedScrollBox }

procedure TCheckedScrollBox.Add(Text: string; Menu: TPopupMenu; Tag: integer;
  Checked: boolean);
var i: integer; oldCw: integer;
begin
  oldCw := Self.ClientWidth;
  i := Length(Items);
  SetLength(Items,i+1);
  Items[i] := TCheckBox.Create(Self);
  Items[i].Parent := Self;
  Items[i].Top := (i)*(Items[i].Height + 4) + 4 - Self.VertScrollBar.Position;
  Items[i].Left := 4;
  Items[i].Width := Self.ClientWidth - 8;
  Items[i].Color := FCheckColor;
  if FSetFont then Items[i].Font := FFont;
  Items[i].Caption := Text;
  Items[i].PopupMenu := Menu;
  Items[i].Tag := Tag;
  Items[i].Checked := Checked;
  Items[i].Visible := true;
  Items[i].OnMouseMove := ChMouseMove;
  if (oldCw <> Self.ClientWidth) and Self.FAutoSizeCheck then
  begin
    AllignSize;
  end;
end;

procedure TCheckedScrollBox.AllignSize;
var i: integer;
begin
  for i := 0 to Length(Items) - 1 do
  begin
    Items[i].Width := Self.ClientWidth - 8;
  end;
end;

procedure TCheckedScrollBox.Clear;
var i: integer;
begin
  FClear := true;
  Selected := nil;
  for i := 0 to Length(Items)-1 do
  begin
    if Items[i] <> nil then Items[i].Free;
  end;
  SetLength(Items,0);
  FClear := false;
end;

constructor TCheckedScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRowHeight := 4;
  FAutoSizeCheck := true;
  FCheckColor := Self.Color;
  FSelColor := clSkyBlue;
  FClear := false;
  SetLength(Items,0);
end;

destructor TCheckedScrollBox.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TCheckedScrollBox.GetCount: integer;
begin
  Result := Length(Items);
end;

procedure TCheckedScrollBox.ChMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender = nil then Exit;
  if Selected <> nil then Selected.Color := Self.FCheckColor;
  Selected := TCheckBox(Sender);
  (Sender as TCheckBox).Color := FSelColor;
end;

procedure TCheckedScrollBox.SetAutoSizeCheck(const Value: boolean);
begin
  FAutoSizeCheck := Value;
  AllignSize;
end;

procedure TCheckedScrollBox.SetCheckColor(const Value: TColor);
var i: integer;
begin
  FCheckColor := Value;
  for i := 0 to Length(Items) - 1 do
  begin
    Items[i].Color := FCheckColor;
  end;
end;

procedure TCheckedScrollBox.SetRowHeight(const Value: integer);
var i: integer;
begin
  FRowHeight := Value;
  for i := 0 to Length(Items) - 1 do
  begin
    Items[i].Top := (i)*(Items[i].Height + FRowHeight) + FRowHeight;
  end;
end;

procedure TCheckedScrollBox.SetSelColor(const Value: TColor);
begin
  FSelColor := Value;
  if Selected <> nil then Selected.Color := FSelColor;
end;


procedure TCheckedScrollBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Selected <> nil then
  begin
    Selected.Color := FCheckColor;
    Selected := nil;
  end;
end;

procedure TCheckedScrollBox.SetFont(const Value: TFont);
var i: integer;
begin
  FFont := Value;
  for i := 0 to Length(Items) - 1 do
  begin
    Items[i].Font := FFont;
  end;
  FSetFont := true;
end;

function TCheckedScrollBox.CanResize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result :=  inherited CanResize(NewWidth, NewHeight);
  if FAutoSizeCheck and not FClear then AllignSize; 
end;

procedure TCheckedScrollBox.SetCheckedAll(Checked: boolean);
var i: integer;
begin
  for i := 0 to Length(Items) - 1 do
  begin
    Items[i].Checked := Checked;
  end;
end;

end.
