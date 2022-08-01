unit ExportHTML;

interface

uses SysUtils, Graphics;

type
  THTMLColorString = string[7];

type
  THTMLColor = class(TObject)
  private
    FColor: TColor;
    function GetHTMLColor: THTMLColorString;
  protected
    procedure SetColor(const Value: TColor);virtual;
  public
    property Color: TColor read FColor write SetColor;
    property HTMLColor: THTMLColorString read GetHTMLColor;
    constructor Create;
  end;

type
  THTMLFontSize = 1..7;

type
  THTMLFontFace = string;

type
  THTMLFont = class(THTMLColor)
  private
    FText: string;
    FSize: THTMLFontSize;
    FFace: THTMLFontFace;
    FChange  : boolean;
    FSetSize : boolean;
    FSetColor: boolean;
    FSetFace : boolean;
    procedure SetText(const Value: string);
    function GetFontTag: string;
    procedure SetSize(const Value: THTMLFontSize);
    procedure SetFace(const Value: THTMLFontFace);
  protected
    procedure SetColor(const Value: TColor);override;
  public
    constructor Create;
    destructor Destroy;override;
    property Text: string read FText write SetText;
    property Size: THTMLFontSize read FSize write SetSize;
    property Face: THTMLFontFace read FFace write SetFace;
    property FontTag: string read GetFontTag;
  end;

type
  THTMLAlign = (haNone = 0, haTop = 1, haBottom = 2, haLeft = 3, haRight = 4,
    haCenter = 5, haJustify = 6, haAbsbottom = 7, haAbsmiddle = 8,
    haBaseline = 9, haMiddle = 10, haTexttop = 11);

type
  THTMLTagAlign = class(TObject)
  private
    FAlign: THTMLAlign;
    FSetAlign: boolean;
    function GetAlignTag: string;
    procedure SetAlign(const Value: THTMLAlign);
  public
    constructor Create;
    destructor Destroy; override;
    property Align: THTMLAlign read FAlign write SetAlign;
    property AlignTag:string read GetAlignTag;
  end;

type
  THTMLHeadLeve = 1..7;

type
  THTMLHead = class(THTMLTagAlign)
  private
    FText: string;
    FLeve: THTMLHeadLeve;
    FSetAlign: boolean;
    procedure SetLeve(const Value: THTMLHeadLeve);
    function GetHeadTag: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Text: string read FText write FText;
    property Leve:THTMLHeadLeve read FLeve write SetLeve;
    property HeadTag: string read GetHeadTag;
  end;

type
  THWInfo = record
    Percent: boolean;
    Value: integer;
  end;

type
  THTMLHr = class(THTMLColor)
  private

  public

  end;



implementation

uses Windows;

const
  HTMLAlign: array[1..11] of string[9] = ('top', 'bottom','left','right',
    'center','justify','absbottom','absmiddle','baseline','middle','texttop');

function ColorToHtml(AColor: TColor): THTMLColorString;
var rgb: DWORD;
begin
  rgb := ColorToRGB(AColor);
  Result := '#' +
  Format('%.2x%.2x%.2x',[GetRValue(rgb),GetGValue(rgb),GetBValue(rgb)]);
end;

{ THTMColor }

constructor THTMLColor.Create;
begin
  inherited Create;
  FColor := clBlack;
end;

procedure THTMLColor.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

function THTMLColor.GetHTMLColor: THTMLColorString;
begin
  Result := ColorToHtml(FColor);
end;

{ THTMLFont }

constructor THTMLFont.Create;
begin
  inherited;
  FChange  := false;
  FSetSize := false;
  FSetColor:= false;
  FSetFace := false;
end;

destructor THTMLFont.Destroy;
begin
  inherited;
end;

procedure THTMLFont.SetText(const Value: string);
begin
  FText := Value;
end;

procedure THTMLFont.SetSize(const Value: THTMLFontSize);
begin
  FSize := Value;
  FSetSize := true;
  FChange := true;
end;

procedure THTMLFont.SetColor(const Value: TColor);
begin
  FSetColor := true;
  FChange := true;
  Inherited SetColor(Value);
end;

function THTMLFont.GetFontTag: string;
begin
  Result := '';
  if FText = '' then Exit;
  if not FChange then
  begin
    Result := FText;
    Exit;
  end;
  
  Result := '<font';
  if FSetColor then
    Result := Result + ' Color="'+ HTMLColor +'"';
  if FSetSize then
    Result := Result + ' Size="' + IntToStr(Size) +'"';
  Result := Result + '>';
  Result := Result + FText;
  Result := Result +  '</font>';
end;

procedure THTMLFont.SetFace(const Value: THTMLFontFace);
begin
  FFace := Value;
  FSetFace := true;
  FChange  := true; 
end;

{ THTMLTagAlign }

constructor THTMLTagAlign.Create;
begin
  inherited Create;
  FAlign := haNone;
  FSetAlign := false;
end;

destructor THTMLTagAlign.Destroy;
begin
  inherited;
end;

function THTMLTagAlign.GetAlignTag: string;
begin
  Result := '';
  if (FSetAlign) and (FAlign <> haNone)  then
  begin
    Result := ' align="'+HTMLAlign[Integer(FAlign)]+'"';
  end;
end;

procedure THTMLTagAlign.SetAlign(const Value: THTMLAlign);
begin
  FAlign := Value;
  FSetAlign := true;
end;

{ THTMLHead }

constructor THTMLHead.Create;
begin
  inherited Create;
  FLeve := 1;
  FSetAlign := false;
end;

destructor THTMLHead.Destroy;
begin
  inherited;
end;

procedure THTMLHead.SetLeve(const Value: THTMLHeadLeve);
begin
  FLeve := Value;
end;

function THTMLHead.GetHeadTag: string;
begin
  if FText = '' then
  begin
    Result := '';
    Exit;
  end;
  Result := '<H'+IntToStr(FLeve);
  Result := Result + Self.AlignTag;
  Result := Result + '>';
  Result := Result + FText + '</H'+IntToStr(FLeve)+'>';
end;



end.
