unit ExportHTML;

interface

uses SysUtils, Classes, Graphics, ComCtrls;

const
  BRTag = '<br>';

type
  THTMLColorString = string[7];

type
  THTMLColor = class(TObject) 
  private
    FColor: TColor;
    FSetColor: boolean;
    function GetHTMLColor: THTMLColorString;
    function GetColorTag: string;
    function GetBgColorTag: string;
  protected
    procedure SetColor(const Value: TColor);virtual;
  public
    constructor Create;
    property Color: TColor read FColor write SetColor;
    property HTMLColor: THTMLColorString read GetHTMLColor;
    property ColorTag: string read GetColorTag;
    property BgColorTag: string read GetBgColorTag; 
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
  THTMLTagAlign = class(THTMLColor)
  private
    FAlign: THTMLAlign;
    FSetAlign: boolean;
    function GetAlignTag: string;
    procedure SetAlign(const Value: THTMLAlign);
  protected
     property Color;
     property HTMLColor;
     property ColorTag;
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
  THTMLHWElement = class(THTMLTagAlign)
  private
    FWidth: integer;
    FHeight: integer;
    FHPercent: boolean;
    FWPercent: boolean;
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
    function GetHeightTag: string;
    function GetWidthTag: string;
  protected
    FSetWidth:   boolean;
    FSetHeight:  boolean;
  public
    property Width: integer read FWidth write SetWidth;
    property Height : integer read FHeight write SetHeight;
    property WPercent: boolean read FWPercent write FWPercent;
    property HPercent: boolean read FHPercent write FHPercent;
    property HeightTag: string read GetHeightTag;
    property WidthTag : string read GetWidthTag;
    property Color;
    property HTMLColor;
    property ColorTag;
    constructor Create;
    destructor Destroy;override;
  end;

type
  THTMLHr = class(THTMLHWElement)
  private
    FNoShade: boolean;
    FSize: byte;
    FSetSize  :boolean;
    procedure SetSize(const Value: byte);
    function GetHrTag: string;
  protected
    FSetBackGround: boolean;
    property Height;
    property HeightTag;
  public
    constructor Create;
    destructor Destroy;override;
    property Size: byte read FSize write SetSize;
    property NoShade: boolean read FNoShade write FNoShade;
    property HrTag: string read GetHrTag;
  end;

type
  THTMLHWBgElement = class(THTMLHWElement)
  private
    FBackGround: TFileName;
    function GetBackGroundTag: string;
    procedure SetBackGround(const Value: TFileName);
  public
    constructor Create;
    destructor Destroy;override;
    property BackGround: TFileName read FBackGround write SetBackGround;
    property BackGroundTag: string read GetBackGroundTag;
  end;

type
  THTMLText = class(TObject)
  private
    FItalic: boolean;
    FTeleType: boolean;
    FBold: boolean;
    FUnderline: boolean;
    FCode: boolean;
    FText: string;
    function GetTextTag: string;
  public
    property Text: string read FText write FText;
    property Bold: boolean read FBold write FBold;
    property Italic: boolean read FItalic write FItalic;
    property Underline: boolean read FUnderline write FUnderline;
    property TeleType: boolean read FTeleType write FTeleType;
    property Code: boolean read FCode write FCode;
    property TextTag: string read GetTextTag;
    procedure ClearOptions;
    constructor Create;
    destructor Destroy; override;
  end;

type
  THTMLTableTD = class(THTMLHWBgElement)
  private
    FNoWrap: boolean;
    FColSpan: byte;
    FRowSpan: byte;
    FSetBackGround: boolean;
    FSetColSpan: boolean;
    FSetRowSpan: boolean;
    procedure SetColSpan(const Value: byte);
    procedure SetRowSpan(const Value: byte);
    function GetTDTag: string;
    function GetSimpleText: string;
  public
    HTMLText: THTMLText;
    constructor Create;
    destructor Destroy;override;
    property SimpleText: string read GetSimpleText;
    property ColSpan: byte read FColSpan write SetColSpan;
    property RowSpan: byte read FRowSpan write SetRowSpan;
    property NoWrap: boolean read FNoWrap write FNoWrap;
    property TDTag: string read GetTDTag;
  end;

type
  THTMLParagraph = class(THTMLTagAlign)
  private
    FText: string;
    function GetParagraphTag: string;

  public
    constructor Create;
    destructor Destroy;override;
    property Text: string read FText write FText;
    property ParagraphTag: string read GetParagraphTag;
  end;

type
  TTableTDArray = array of THTMLTableTD;

type
  TTDCollection = class(TObject)
  private
    function GetCount: integer;
  public
    TDItem: TTableTDArray;
    property Count: integer read GetCount;
    function Add(Text: string): THTMLTableTD;
    function Delete(Index: integer): boolean; overload;
    function Delete(Item: THTMLTableTD): boolean; overload;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

type
  THTMLTableTR = class(THTMLTagAlign)
  private
    FTab: string;
    FSetTab: boolean;
    function GetTRTag: TStringList;
    procedure SetTab(const Value: string);
  public
    TDItems: TTDCollection;
    property TRTag: TStringList read GetTRTag;
    property Tab: string read FTab write SetTab;
    property Color;
    property HTMLColor;
    property ColorTag;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TTableTRArray = array of THTMLTableTR;

type
  TTRCollection = class(TObject)
  private
    function GetCount: integer;
  public
    TRItem: TTableTRArray;
    property Count: integer read GetCount;
    function Add: THTMLTableTR;
    function Delete(Index: integer): boolean;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

type
  THTMLTable = class(THTMLHWBgElement)
  private
    FCellPadding: byte;
    FCellSpacing: byte;
    FBorder: byte;
    FSetBorder: boolean;
    FSteCellSpacing: boolean;
    FSetCellPadding: boolean;
    procedure SetBorder(const Value: byte);
    procedure SetCellPadding(const Value: byte);
    procedure SetCellSpacing(const Value: byte);
    function GetTableTag: TStringList;
  public
    TRItems: TTRCollection;
    property Border: byte read FBorder write SetBorder;
    property CellPadding: byte read FCellPadding write SetCellPadding;
    property CellSpacing: byte read FCellSpacing write SetCellSpacing;
    property TableTag: TStringList read GetTableTag;
    procedure LoadFromListView(ListView: TListView);
    constructor Create;
    destructor Destroy; override;
  end;

type
  THTMLImage = class(THTMLHWElement)
  private
    FVSpace: byte;
    FHSpace: byte;
    FBorder: byte;
    FAlt: string;
    FName: string;
    FSrc: TFileName;
    FLowSrc: TFileName;
    FSetBorder: boolean;
    FSetHSpace: boolean;
    FSetVSpace: boolean;
    function GetIMGTag: string;
    procedure SetBorder(const Value: byte);
    procedure SetHSpace(const Value: byte);
    procedure SetVSpace(const Value: byte);
  protected
    property WPercent;
    property HPercent;
    property Color;
    property HTMLColor;
    property ColorTag;
  public
    property Src: TFileName read FSrc write FSrc;
    property LowSrc: TFileName read FLowSrc write FLowSrc; 
    property HSpace: byte read FHSpace write SetHSpace;
    property VSpace: byte read FVSpace write SetVSpace;
    property Name: string read FName write FName;
    property Alt: string read FAlt write FAlt;
    property Border: byte read FBorder write SetBorder;
    property IMGTag: string read GetIMGTag;
    constructor Create;
    destructor Destroy; override;
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
  FSetColor := false;
end;

procedure THTMLColor.SetColor(const Value: TColor);
begin
  FColor := Value;
  FSetColor := true;
end;

function THTMLColor.GetHTMLColor: THTMLColorString;
begin
  Result := ColorToHtml(FColor);
end;

function THTMLColor.GetColorTag: string;
begin
  Result := '';
  if FSetColor then
    Result := ' color="'+ColorToHtml(FColor)+'"';
end;

function THTMLColor.GetBgColorTag: string;
begin
  Result := '';
  if FSetColor then
    Result := ' bgcolor="'+ColorToHtml(FColor)+'"';
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

procedure THTMLFont.SetFace(const Value: THTMLFontFace);
begin
  FFace := Value;
  FSetFace := true;
  FChange  := true; 
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
  Result := Result + ' ' + ColorTag;
  if FSetFace then
    Result := Result + ' face="' + FFace + '"'; 
  if FSetSize then
    Result := Result + ' Size="' + IntToStr(Size) +'"';
  Result := Result + '>';
  Result := Result + FText;
  Result := Result +  '</font>';
end;

procedure THTMLFont.SetColor(const Value: TColor);
begin
  inherited;
  FChange := true;
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

{ THTMLHWElement }

constructor THTMLHWElement.Create;
begin
  inherited Create;
  FSetWidth  := false;
  FSetHeight := false;
  FHPercent := false;
  FWPercent := false;
end;

destructor THTMLHWElement.Destroy;
begin
  inherited;
end;

function THTMLHWElement.GetHeightTag: string;
begin
  if not FSetHeight then
  begin
    Result := '';
    Exit;
  end;
  Result := ' height="' + IntToStr(FHeight);
  if FHPercent then Result := Result + '%';
  Result := Result + '"';
end;

function THTMLHWElement.GetWidthTag: string;
begin
  if not Self.FSetWidth then
  begin
    Result := '';
    Exit;
  end;
  Result := ' height="' + IntToStr(FWidth);
  if FWPercent then Result := Result + '%';
  Result := Result + '"';
end;

procedure THTMLHWElement.SetHeight(const Value: Integer);
begin
  FHeight := Value;
  FSetHeight  := true;
end;

procedure THTMLHWElement.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  FSetWidth  := true;
end;

{ THTMLHr }

constructor THTMLHr.Create;
begin
  inherited Create;
  FSetSize  := false;
  Self.Align := haNone;
end;

destructor THTMLHr.Destroy;
begin
  inherited;
end;

procedure THTMLHr.SetSize(const Value: byte);
begin
  FSize := Value;
  FSetSize  := true;
end;

function THTMLHr.GetHrTag: string;
begin
  Result := '<hr';
  Result := Result + Self.AlignTag;
  Result := Result + Self.ColorTag;
  if FSetSize then
    Result := Result + ' size="'+IntToStr(FSize)+'"';
  Result := Result + Self.WidthTag;
  if NoShade then Result := Result + ' noshade';
  Result := Result + '>';
end;

{ THTMLHWBElement }

constructor THTMLHWBgElement.Create;
begin
  inherited Create;
end;

destructor THTMLHWBgElement.Destroy;
begin
  inherited;
end;

function THTMLHWBgElement.GetBackGroundTag: string;
begin
  if Trim(Self.FBackGround) = '' then
  begin
    Result := '';
    Exit;
  end;
  Result := ' background="' + FBackGround + '"';
end;

procedure THTMLHWBgElement.SetBackGround(const Value: TFileName);
begin
  FBackGround := Trim(Value);
end;

{ THTMLTableTD }

constructor THTMLTableTD.Create;
begin
  inherited Create;
  FSetBackGround := false;
  FSetColSpan    := false;
  FSetRowSpan    := false;
  HTMLText := THTMLText.Create;
end;

destructor THTMLTableTD.Destroy;
begin
  inherited;
end;

procedure THTMLTableTD.SetColSpan(const Value: byte);
begin
  FColSpan := Value;
  FSetColSpan := Value <> 0;
end;

procedure THTMLTableTD.SetRowSpan(const Value: byte);
begin
  FRowSpan := Value;
  FSetRowSpan := Value <> 0;
end;

function THTMLTableTD.GetTDTag: string;
begin
  if Self.HTMLText.Text = '' then
  begin
    Result := '';
    Exit;
  end;
  Result := '<td';
  if FSetColSpan then
    Result := Result + ' colspan="'+ IntToStr(FColSpan) +'"';
  if FSetRowSpan then
    Result := Result + ' rowspan="'+ IntToStr(FRowSpan) +'"';
  Result := Result + AlignTag + BgColorTag + WidthTag + HeightTag + BackGroundTag;
  Result := Result + '>';
  Result := Result + HTMLText.TextTag;
  Result := Result + '</td>';
end;

function THTMLTableTD.GetSimpleText: string;
begin
  Result := HTMLText.Text;
end;

{ THTMLParagraph }

constructor THTMLParagraph.Create;
begin
  inherited Create;
end;

destructor THTMLParagraph.Destroy;
begin
  inherited;
end;

function THTMLParagraph.GetParagraphTag: string;
begin
  if FText = '' then
  begin
    Result := '';
    Exit;
  end;
  Result := '<p';
  Result := Result + ' ' + AlignTag;
  Result := Result + '>';
  Result := Result + FText;
  Result := Result + '</p>';
end;

{ TTDCollection }

constructor TTDCollection.Create;
begin
  inherited Create;
  SetLength(TDItem,0);
end;

destructor TTDCollection.Destroy;
begin
  Clear;
  inherited;
end;

function TTDCollection.Add(Text: string): THTMLTableTD;
begin
  SetLength(TDItem,Length(TDItem)+1);
  TDItem[Length(TDItem)-1] := THTMLTableTD.Create;
  TDItem[Length(TDItem)-1].HTMLText.Text := Text;
  Result := TDItem[Length(TDItem)-1];
end;

procedure TTDCollection.Clear;
var i: integer;
begin
  for i := 0 to Length(TDItem) - 1 do
  begin
    TDItem[i].Free;
  end;
  SetLength(TDItem,0);
end;

function TTDCollection.Delete(Index: integer): boolean;
var i: integer;
begin
  Result := false;
  if Index > Length(TDItem) - 1 then Exit;
  try
    for i := Index to Length(TDItem) - 2 do
      TDItem[i] := TDItem[i+1];
    TDItem[Length(TDItem)-1].Free;
    SetLength(TDItem,Length(TDItem)-1);
    Result := true;
  except
    Result := false;
  end
end;

function TTDCollection.Delete(Item: THTMLTableTD): boolean;
var i: integer;
begin
  Result := false;
  if Item = nil then Exit;
  for i := 0 to Length(Self.TDItem) - 1 do
  begin
    if Self.TDItem[i] = Item then
    begin
      Result := Delete(i);
      break;
    end;
  end;
end;

function TTDCollection.GetCount: integer;
begin
  Result := Length(Self.TDItem);
end;

{ THTMLTableTR }

constructor THTMLTableTR.Create;
begin
  inherited Create;
  TDItems := TTDCollection.Create;
  FSetTab := false;
  FTab := '';
end;

destructor THTMLTableTR.Destroy;
begin
  TDItems.Free;
  inherited;
end;

function THTMLTableTR.GetTRTag: TStringList;
var i: integer;
begin
  Result := TStringList.Create;
  Result.Clear;
  if Self.TDItems.Count = 0 then Exit;
  for i := 0 to Self.TDItems.Count - 1 do
  begin
    Result.Add('   ' + Self.TDItems.TDItem[i].TDTag);
  end;
  if Trim(Result.Text) = '' then Exit;
  Result.Insert(0,'<tr' + AlignTag + BgColorTag + '>');
  Result.Add('</tr>');
  if not FSetTab then Exit;
  for i := 0 to Result.Count - 1 do
  begin
    Result[i] := Tab + Result[i];
  end;
end;

procedure THTMLTableTR.SetTab(const Value: string);
begin
  FTab := Value;
  FSetTab := true;
end;

{ TTRCollection }

function TTRCollection.Add: THTMLTableTR;
begin
  SetLength(TRItem,Length(TRItem) + 1);
  TRItem[Length(TRItem) - 1] := THTMLTableTR.Create;
  Result := TRItem[Length(TRItem) - 1];
end;

procedure TTRCollection.Clear;
var i: integer;
begin
  for i := 0 to Length(TRItem) - 1 do
  begin
    TRItem[i].Free;
  end;
  SetLength(TRItem,0);
end;

constructor TTRCollection.Create;
begin
  inherited Create;
  SetLength(TRItem,0);
end;

function TTRCollection.Delete(Index: integer): boolean;
var i: integer;
begin
  Result := false;
  if Index > Length(TRItem) - 1 then Exit;
  try
    for i := Index to Length(TRItem) - 2 do
      TRItem[i] := TRItem[i+1];
    TRItem[Length(TRItem)-1].Free;
    SetLength(TRItem,Length(TRItem)-1);
    Result := true;
  except
    Result := false;
  end
end;

destructor TTRCollection.Destroy;
begin
  Clear;
  inherited;
end;

function TTRCollection.GetCount: integer;
begin
  Result := Length(TRItem);
end;

{ THTMLTable }

constructor THTMLTable.Create;
begin
  inherited Create;
  Self.TRItems := TTRCollection.Create;
  FSetBorder := false;
  FSteCellSpacing := false;
  FSetCellPadding := false;
end;

destructor THTMLTable.Destroy;
begin
  Self.TRItems.Free;
  inherited;
end;

function THTMLTable.GetTableTag: TStringList;
var i: integer; t: string;
begin
  Result := TStringList.Create;
  if TRItems.Count = 0 then Exit;
  for i := 0 to TRItems.Count - 1 do
  begin
    TRItems.TRItem[i].Tab := '    ';
    Result.AddStrings(TRItems.TRItem[i].TRTag);
  end;
  if Trim(Result.Text) = '' then Exit;

  t := '<table';
  if FSetBorder then
    t := t + ' border="' + IntToStr(FBorder)+'"';
  if FSteCellSpacing then
    t := t + ' cellspacing="'+ IntToStr(Self.FCellSpacing) +'"';
  if FSetCellPadding then
    t := t + ' cellpadding="'+ IntToStr(Self.FCellPadding) +'"';
  t := t + HeightTag + WidthTag + BackGroundTag + AlignTag + BgColorTag;
  t := t + '>';

  Result.Insert(0,t);
  Result.Add('</table>');
end;

procedure THTMLTable.LoadFromListView(ListView: TListView);

  function PrepareStr(AStr: string): string;
  const noStr = '&nbsp;';
  begin
    if Trim(AStr) <> '' then Result := AStr
    else Result := noStr;
  end;

var i,j: integer;
begin
  Self.TRItems.Clear;
  with Self.TRItems.Add do
  begin
    for i := 0 to ListView.Columns.Count - 1 do
    begin
      with TDItems.Add(ListView.Columns[i].Caption) do
      begin
        HTMLText.FBold := true;
      end;
    end;
  end;
  for i := 0 to ListView.Items.Count - 1 do
  begin
    with Self.TRItems.Add do
    begin
      TDItems.Add(PrepareStr(ListView.Items.Item[i].Caption));
      for j := 0 to ListView.Items.Item[i].SubItems.Count - 1 do
        TDItems.Add(PrepareStr(ListView.Items.Item[i].SubItems.Strings[j]));
    end
  end;
end;

procedure THTMLTable.SetBorder(const Value: byte);
begin
  FBorder := Value;
  FSetBorder := true;
end;

procedure THTMLTable.SetCellPadding(const Value: byte);
begin
  FCellPadding := Value;
  FSetCellPadding := true;
end;

procedure THTMLTable.SetCellSpacing(const Value: byte);
begin
  FCellSpacing := Value;
  FSteCellSpacing := true;
end;

{ THTMLText }

constructor THTMLText.Create;
begin
  inherited Create;
  Self.FItalic := false;
  Self.FTeleType := false;
  Self.FBold := false;
  Self.FUnderline := false;
  Self.FCode := false;
  Self.FText := '';
end;

procedure THTMLText.ClearOptions;
begin
  Self.FItalic := false;
  Self.FTeleType := false;
  Self.FBold := false;
  Self.FUnderline := false;
  Self.FCode := false;
end;

destructor THTMLText.Destroy;
begin
  inherited;
end;

function THTMLText.GetTextTag: string;
begin
  Result := '';
  if FText = '' then Exit;
  Result := FText;
  if FBold then
  begin
    Insert('<b>',Result,1);Result := Result + '</b>';
  end;
  if FItalic then
  begin
    Insert('<i>',Result,1);Result := Result + '</i>';
  end;
  if FUnderline then
  begin
    Insert('<u>',Result,1);Result := Result + '</u>';
  end;
  if FTeleType then
  begin
    Insert('<tt>',Result,1);Result := Result + '</tt>';
  end;
  if FCode then
  begin
    Insert('<code>',Result,1);Result := Result + '</code>';
  end;
end;

{ THTMLImage }

constructor THTMLImage.Create;
begin
  inherited Create;
  FSetBorder := false;
  FSetHSpace := false;
  FSetVSpace := false;
  FBorder := 0;
end;

destructor THTMLImage.Destroy;
begin
  inherited;
end;

function THTMLImage.GetIMGTag: string;
begin
  Result := '';
  if FSrc = '' then Exit;
  Result := '<img src="' + FSrc +'"';
  Result := Result + WidthTag + HeightTag + AlignTag;
  if Trim(FAlt) <> '' then
    Result := Result + ' alt="'+ FAlt +'"';
  if FSetBorder then
    Result := Result + ' border="'+ IntToStr(FBorder) +'"';
  if FSetHSpace then
    Result := Result + ' hspace="'+ IntToStr(FHSpace) +'"';
  if FSetVSpace then
    Result := Result + ' vspace="'+ IntToStr(FVSpace) +'"';
  if Trim(FName) <> '' then
    Result := Result + ' name="'+ FName +'"';
  if Trim(FLowSrc) <> '' then
    Result := Result + ' flowsrc="'+ FLowSrc +'"';
  Result := Result + '/>';
end;

procedure THTMLImage.SetBorder(const Value: byte);
begin
  FBorder := Value;
  FSetBorder := true;
end;

procedure THTMLImage.SetHSpace(const Value: byte);
begin
  FHSpace := Value;
  FSetHSpace := true;
end;

procedure THTMLImage.SetVSpace(const Value: byte);
begin
  FVSpace := Value;
  FSetVSpace := true;
end;

end.
