{*******************************************************}
{                                                       }
{           TBoard Visual Component                     }
{                                                       }
{           Copyright (c) 2008 Малахов Михаил           }
{                                                       }
{*******************************************************}

unit BoardControl;

interface

uses
  SysUtils, Classes, Controls, Graphics;

// Матрица для хранения состояний точек  
type
  TPixelMask = array of array of boolean;

type
  TBoardBorderStyle = TPenStyle;

type
  TBoardState = (bsNormal = 0, bsCreate = 1, bsPaint = 2, bsChangeMask = 3,
    bsResize = 4);

type
  TBoard = class(TGraphicControl)
  private
    FPixelMask: TPixelMask;
    FPixelColor: TColor;
    FPixelWidth: byte;
    FActiveColor: TColor;
    FPixelHeight: byte;
    FPixelBorder: TColor;
    FPixelMargin: Integer;
    FBorderWidth: integer;
    FText: string;
    FActiveBorder: TColor;
    FBorderColor: TColor;
    FBorderStyle: TBoardBorderStyle;
    FBoardState: TBoardState;
    procedure SetPixelBorder(const Value: TColor);
    procedure SetPixelColor(const Value: TColor);
    procedure SetActiveColor(const Value: TColor);
    procedure SetPixelHeight(const Value: byte);
    procedure SetPixelWidth(const Value: byte);
    procedure SetPixelMargin(const Value: Integer);
    procedure SetBorderWidth(const Value: integer);
    procedure SetColCount(const Value: integer);
    procedure SetRowCount(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetActiveBorder(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TBoardBorderStyle);
    function GetPixels(i, j: integer): boolean;
    procedure SetPixels(i, j: integer; const Value: boolean);
    function GetColCount: integer;
    function GetRowCount: integer;
    procedure DelSizeConstants;
    function GetFontName: TFontName;
    function GetFontSize: integer;
    function GetFontStyles: TFontStyles;
    procedure SetFontName(const Value: TFontName);
    procedure SetFontSize(const Value: integer);
    procedure SetFontStyles(const Value: TFontStyles);
  protected
    property BoardState: TBoardState read FBoardState write FBoardState;
    procedure SetAutoSize(Value: boolean); override;
    procedure UpdateSize;
    procedure UpdateBoard;
    procedure UpdateText;
  public
    property Pixels[i,j: integer]: boolean read GetPixels write SetPixels; default;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure ClearPixels;
    procedure LoadBitmap(Bitmap: TBitmap; TransparentColor: TColor = clWhite;
      Resize: boolean = true);
    procedure Paint; override;
    procedure Repaint; override;
    procedure Turn;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoSize;
    property ActiveBorder: TColor read FActiveBorder write SetActiveBorder;
    property ActiveColor: TColor read FActiveColor write SetActiveColor;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderStyle: TBoardBorderStyle read FBorderStyle write SetBorderStyle;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth;
    property Color;
    property ColCount: integer read GetColCount write SetColCount;
    property FontSize: integer read GetFontSize write SetFontSize;
    property FontName: TFontName read GetFontName write SetFontName;
    property FontStyles: TFontStyles read GetFontStyles write SetFontStyles;
    property RowCount: integer read GetRowCount write SetRowCount;
    property PixelBorder: TColor read FPixelBorder write SetPixelBorder;
    property PixelColor: TColor read FPixelColor write SetPixelColor;
    property PixelHeight: byte read FPixelHeight write SetPixelHeight;
    property PixelMargin: Integer read FPixelMargin write SetPixelMargin;
    property PixelWidth: byte read FPixelWidth write SetPixelWidth;
    property Text: string read FText write SetText;
  end;

procedure Register;

implementation

uses Types;

procedure Register;
begin
  RegisterComponents('Samples', [TBoard]);
end;

{ TTCustomBoard }

const
  defWidth = 256;                 // Ширина по умолчанию в пикселах
  defHeight = 48;                 // Высота по умолчанию в пикселах
  defBorderStyle = psInsideFrame; // Стиль рамки
  defBorderWidth = 1;             // Толщина рамки
  defPixelWidth = 4;              // Ширина точки по умолчанию
  defPixelHeight = 4;             // Высота точки по умолчанию
  defPixelMargin = 2;             // Расстояние между точками
  DefColCount = 42;               // Число столбцов
  DefRowCount = 16;               // Число строк
  DefFontName = 'Courier New';    // Имя шрифта
  DefFontSize  = 10;              // Размер шрифта

procedure TBoard.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TBoard then
  begin
    FPixelColor := TBoard(Source).PixelColor;
    FPixelWidth := TBoard(Source).PixelWidth;
    FActiveColor := TBoard(Source).ActiveColor;
    FPixelHeight := TBoard(Source).PixelHeight;
    FPixelBorder := TBoard(Source).PixelBorder;
    FPixelMargin := TBoard(Source).PixelMargin;
    FBorderWidth := TBoard(Source).BorderWidth;
    FActiveBorder := TBoard(Source).ActiveBorder;
    FBorderColor := TBoard(Source).BorderColor;
    FBorderStyle := TBoard(Source).BorderStyle;
    FBoardState := TBoard(Source).BoardState;
    Text := TBoard(Source).Text;
  end;
end;

procedure TBoard.Clear;
begin
  // Удаление элементов массива
  SetLength(FPixelMask,0,0);
  FText := '';
  Self.Refresh;
end;

procedure TBoard.ClearPixels;
var i,j: integer;
begin
  //FText := '';
  // Установка всех элементов маски в false
  for i := Low(FPixelMask) to High(FPixelMask) do
    for j := Low(FPixelMask[i]) to High(FPixelMask[i]) do
      FPixelMask[i,j] := false;
  Self.Refresh;
end;

constructor TBoard.Create(AOwner: TComponent);
begin
  inherited;
  FBoardState := bsCreate;
  Self.AutoSize := true;
  Self.Font.Name := DefFontName;
  Self.Font.Size := DefFontSize;
  FActiveBorder := clGray;
  FActiveColor := clRed;
  FBorderColor := clBlack;
  FBorderStyle := defBorderStyle;
  FBorderWidth := defBorderWidth;
  FPixelBorder := clGray;
  FPixelColor := clWhite;
  FPixelHeight := defPixelHeight;
  FPixelMargin := defPixelMargin;
  FPixelWidth := defPixelWidth;
  Text := 'Text';
  FBoardState := bsNormal;
end;

procedure TBoard.DelSizeConstants;
begin
  Self.Constraints.MaxWidth := 0;
  Self.Constraints.MinWidth := 0;
  Self.Constraints.MaxHeight := 0;
  Self.Constraints.MinHeight := 0;
end;

destructor TBoard.Destroy;
begin
  Clear;
  inherited;
end;

function TBoard.GetColCount: integer;
begin
  Result := Length(FPixelMask);
end;

function TBoard.GetFontName: TFontName;
begin
  Result := Self.Font.Name;
end;

function TBoard.GetFontSize: integer;
begin
  Result := Self.Font.Size;
end;

function TBoard.GetFontStyles: TFontStyles;
begin
  Result := Self.Font.Style;
end;

function TBoard.GetPixels(i, j: integer): boolean;
begin
  if (i > 0) and (i < ColCount) and (j > 0) and (j < RowCount) then
    Result := FPixelMask[i,j]
  else
    Result := false;
end;

function TBoard.GetRowCount: integer;
begin
  if Length(FPixelMask) > 0 then
    Result := Length(FPixelMask[0])
  else
    Result := 0;
end;

procedure TBoard.LoadBitmap(Bitmap: TBitmap; TransparentColor: TColor;
  Resize: boolean);

  function Min(X,Y: integer): integer;
  begin
    if X < Y then Result := X
    else Result := Y;
  end;

var i,j, Col,Row: integer;
begin
  FBoardState := bsChangeMask;
  ClearPixels;
  // Если Resize = true, то меняем количество точек в соответствии с изображением
  // иначе вычисляем количество точек
  if Resize then
  begin
    ColCount := Bitmap.Width;
    RowCount := Bitmap.Height;
    Col := ColCount;
    Row := RowCount;
  end
  else begin
    Col := Min(ColCount, Bitmap.Width);
    Row := Min(RowCount, Bitmap.Height);
  end;
  for i := 0 to Col - 1 do
    for j := 0 to Row - 1 do
    begin
      if Bitmap.Canvas.Pixels[i,j] = TransparentColor then
        FPixelMask[i,j] := false
      else
        FPixelMask[i,j] := true;
    end;
  FBoardState := bsNormal;
  UpdateBoard;
end;

procedure TBoard.Paint;
var i,j: integer;
    Rect: TRect;
    WM,HM,BM: integer;

    function GetLeft(i: integer): integer;
    asm
      mul eax, WM;
      add eax, BM;
    end;

    function GetTop(j: integer): integer;
    asm
      mul eax, HM;
      add eax, BM;
    end;

begin
  if FBoardState = bsNormal then
  begin
    FBoardState := bsPaint;
    inherited;
    // Установка параметров отрисовки компонента
    //Self.Canvas.Pen.Color := Color;
    //Self.Canvas.Brush.Color := Color;
    Canvas.Pen.Color := Color;
    Canvas.Brush.Color := Color;
      // Отрисовка компонента
    Canvas.Rectangle(0,0,Width,Height);

    // Параметры отрисовки неактивных пикселов
    Canvas.Pen.Color := PixelBorder;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;
    Canvas.Brush.Color := PixelColor;
    // Расчет отступов
    WM := FPixelWidth + FPixelMargin;
    HM := FPixelHeight + FPixelMargin;
    BM := FBorderWidth + PixelMargin;
    for i := Low(FPixelMask) to High(FPixelMask) do
    begin
      //Rect.Left := FBorderWidth + PixelMargin + (i * (FPixelWidth + FPixelMargin));
      Rect.Left := GetLeft(i);
      Rect.Right :=  Rect.Left + FPixelWidth;
      for j := Low(FPixelMask[i]) to High(FPixelMask[i]) do
      begin
        //Rect.Top := FBorderWidth + FPixelMargin + (j * (FPixelHeight + FPixelMargin));
        Rect.Top := GetTop(j);
        Rect.Bottom := Rect.Top + FPixelHeight;
        if FPixelMask[i,j] and Self.Enabled  then
        begin
          Canvas.Pen.Color := FActiveBorder;
          Canvas.Brush.Color := FActiveColor;
        end
        else begin
          Canvas.Pen.Color := FPixelBorder;
          Canvas.Brush.Color := FPixelColor;
        end;
        Canvas.Ellipse(Rect);
      end;
    end;

    // Проверка, надо ли рисовать рамку
    if (FBorderWidth > 0) and (FBorderStyle <> psClear) then
    begin
      // Установка параметров кисти и карандаша для отрисовки рамки
      Canvas.Pen.Style := FBorderStyle;
      Canvas.Pen.Color := FBorderColor;
      Canvas.Pen.Width := FBorderWidth;
      Canvas.Brush.Style := bsClear;
      // Отрисовка рамки
      Canvas.Rectangle(0,0,Width,Height);
    end;
    FBoardState := bsNormal;
  end;
end;

procedure TBoard.Repaint;
begin
  if FBoardState = bsNormal then
    inherited;
end;

procedure TBoard.UpdateBoard;
begin
  // Если AutoSize = true, то пересчет размеров компонента,
  // если AutoSize = false, то просто перерисовка
  if AutoSize then UpdateSize;
  Self.Refresh;
end;

procedure TBoard.UpdateSize;
var BrState: TBoardState;
begin
  BrState := BoardState;
  BoardState := bsResize;
  DelSizeConstants;
  // Расчет ширины компонента
  Self.Width := (ColCount * (FPixelWidth + FPixelMargin)) + (FBorderWidth * 2) +
    FPixelMargin;
  Self.Constraints.MaxWidth := Self.Width;
  Self.Constraints.MinWidth := Self.Width;
  // Расчет высоты компонента
  Self.Height := (RowCount * (FPixelHeight + FPixelMargin)) + (FBorderWidth * 2) +
    FPixelMargin;
  Self.Constraints.MaxHeight := Self.Height;
  Self.Constraints.MaxHeight := Self.Height;
  BoardState := BrState;
end;

procedure TBoard.UpdateText;
begin
  Text := FText;
end;

procedure TBoard.SetColCount(const Value: integer);
begin
  if Value <> ColCount then
  begin
    SetLength(FPixelMask,Value,GetRowCount); // Установка количество столбцов
    Self.Refresh;
  end;
end;

procedure TBoard.SetFontName(const Value: TFontName);
begin
  if Value <> Self.Font.Name then
  begin
    Self.Font.Name := Value;
    UpdateText;
  end;
end;

procedure TBoard.SetFontSize(const Value: integer);
begin
  if Value <> Self.Font.Size then
  begin
    Self.Font.Size := Value;
    UpdateText;
  end;
end;

procedure TBoard.SetFontStyles(const Value: TFontStyles);
begin
  if Value <> Self.Font.Style then
  begin
    Self.Font.Style := Value;
    UpdateText;
  end;
end;

procedure TBoard.SetPixelBorder(const Value: TColor);
begin
  if Value <> FPixelBorder then
  begin
    FPixelBorder := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetBorderColor(const Value: TColor);
begin
  if Value <> FBorderColor then
  begin
    FBorderColor := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetBorderStyle(const Value: TBoardBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetBorderWidth(const Value: integer);
begin
  if Value <> FBorderWidth then
  begin
    FBorderWidth := Value;
    UpdateBoard;
  end;
end;

procedure TBoard.SetPixelColor(const Value: TColor);
begin
  if Value <> FPixelColor  then
  begin
    FPixelColor := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetActiveBorder(const Value: TColor);
begin
  if Value <> FActiveBorder then
  begin
    FActiveBorder := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetActiveColor(const Value: TColor);
begin
  if Value <> FActiveColor then
  begin
    FActiveColor := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetAutoSize(Value: boolean);
begin
  inherited;
  if AutoSize then
  begin
    UpdateText;
    UpdateSize;
  end
  else DelSizeConstants;
end;

procedure TBoard.SetPixelHeight(const Value: byte);
begin
  if Value <> FPixelHeight then
  begin
    FPixelHeight := Value;
    UpdateBoard;
  end;
end;

procedure TBoard.SetPixelMargin(const Value: Integer);
begin
  if Value <> FPixelMargin then
  begin
    FPixelMargin := Value;
    UpdateBoard;
  end;
end;

procedure TBoard.SetPixels(i, j: integer; const Value: boolean);
begin
  if (i > 0) and (i < ColCount) and (j > 0) and (j < RowCount) then
  begin
    FPixelMask[i,j] := Value;
    Self.Refresh;
  end;
end;

procedure TBoard.SetPixelWidth(const Value: byte);
begin
  if Value <> FPixelWidth then
  begin
    FPixelWidth := Value;
    UpdateBoard;
  end;
end;

procedure TBoard.SetRowCount(const Value: integer);
begin
  if Value <> RowCount then
  begin
    SetLength(FPixelMask,Length(FPixelMask),Value);
    UpdateBoard;
  end;
end;

procedure TBoard.SetText(const Value: string);
var bmp: TBitmap;
    Rect: TRect;
begin
  if Trim(Value) = '' then
  begin
    FText := '';
    ClearPixels;
    Exit;
  end;
  bmp := TBitmap.Create;
  try
    bmp.Canvas.Font.Assign(Self.Font);
    bmp.Width := bmp.Canvas.TextWidth(Value);
    bmp.Height := bmp.Canvas.TextHeight(Value);
    Rect.Left := 0;
    Rect.Top  := 0;
    Rect.Bottom := bmp.Height;
    Rect.Right  := bmp.Width;
    bmp.Canvas.TextRect(Rect,0,0,Value);
    Self.LoadBitmap(bmp,clWhite,AutoSize);
  finally
    bmp.Free;
  end;
  FText := Value;
end;

procedure TBoard.Turn;
var i,j: integer;
begin
  for i := Low(FPixelMask) to High(FPixelMask) do
    for j := Low(FPixelMask[i]) to High(FPixelMask[i]) do
      FPixelMask[i,j] := not FPixelMask[i,j];
  Self.Refresh;
end;

end.
