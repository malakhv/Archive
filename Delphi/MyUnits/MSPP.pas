unit MSPP;
interface
uses SysUtils,ComObj,Variants;

const MSPPT = 'PowerPoint.Application';
const MSWRD = 'Word.Application';

type Shape = record
      Obj: Variant;
      index: integer;
     end;

type TSlide = class(TObject)
     private
       FHeader: string;
       procedure SetHeader(AHeader: string);
     public
       Obj: Variant;
       ParentObj: Variant;
       SlType: integer;
       constructor Create(AParent: Variant; AIndex: integer; ALayout: integer);
       destructor Destroy;
       function SlideIndex : integer;
       function SlideNumber: integer;
       procedure TestMetod;
       procedure MoveTo(toPos: integer);
       procedure AddPicture(FileName: TFileName;Top,Left: integer);
       procedure SetText(Text: string; const index: integer);
       procedure DeleteItem(index: integer);
       property Header: string read FHeader write SetHeader;
     end;

type TSlides = class(TObject)
     private
       ParentObj: Variant;
       Count: integer;
     public
       Items: array of TSlide;
       constructor Create(AParent: Variant);overload;
       destructor  Destroy;
       function Add(SlType: integer): TSLide;
     end;

type TPresentation = class(TObject)
       Obj:    Variant;
       ParentObj: Variant;
       Slides: TSlides;
     public
       constructor Create(AParent: Variant);
       destructor  Destroy;
       procedure SaveAs(FileName: TFileName);
     end;

type TPowerPointApp = class(TObject)
     private
       AppObj: Variant;
       FVisible: boolean;
       procedure SetVisible(AVisible: boolean);
     public
       Presentation: TPresentation;
       constructor Create;
       destructor  Destroy;
       property Visible: boolean read FVisible write SetVisible;
     end;

implementation

{ TSlide }

constructor TSlide.Create(AParent: Variant; AIndex: integer; ALayout: integer);
begin
  inherited Create;
  Self.ParentObj := AParent;
  Self.Obj := Self.ParentObj.Slides.Add(AIndex,ALayout);
end;

destructor TSlide.Destroy;
begin
  inherited Destroy;
end;

procedure TSlide.MoveTo(toPos: integer);
begin
  Self.Obj.MoveTo(toPos);
end;

function TSlide.SlideIndex: integer;
begin
  Result := Self.Obj.SlideIndex;
end;

function TSlide.SlideNumber: integer;
begin
  Result := Self.Obj.SlideNumber;
end;

procedure TSlide.TestMetod;
var f: variant;
begin
 f := Self.Obj.Shapes.Item(1);
 f := f.TextFrame;
 f := f.TextRange;
 f.Text := 'Привет!!!';
end;

procedure TSlide.AddPicture(FileName: TFileName; Top, Left: integer);
begin
  Self.Obj.Shapes.AddPicture(FileName,1,1,Left,Top);
end;

procedure TSlide.SetHeader(AHeader: string);
var tmp: variant;
begin
  FHeader:= AHeader;
  tmp := Self.Obj.Shapes.Item(1);
  tmp := tmp.TextFrame;
  tmp := tmp.TextRange;
  tmp.Text := AHeader;
end;

procedure TSlide.SetText(Text: string; const index: integer);
var tmp: variant;
begin
  tmp := Self.Obj.Shapes.Item(index);
  tmp := tmp.TextFrame;
  tmp := tmp.TextRange;
  tmp.Text := Text;
end;

procedure TSlide.DeleteItem(index: integer);
var tmp: variant;
begin
  tmp := Self.Obj.Shapes.Item(index);
  tmp.Delete;
end;

{ TSlides }

constructor TSlides.Create(AParent: Variant);
begin
  inherited Create;
  Self.ParentObj := AParent;
  Self.Count := 0;
end;

destructor TSlides.Destroy;
begin
  SetLength(Items,0);
  inherited Destroy;
end;

function TSlides.Add(SlType: integer): TSlide;
begin
  SetLength(Items,Length(Items)+1);
  Items[Length(Items)-1] := TSlide.Create(ParentObj,Length(Items),SlType);
  Result := Items[Length(Items)-1];
end;

{ TPresentation }

constructor TPresentation.Create(AParent: Variant);
begin
  inherited Create;
  Self.ParentObj := AParent;
  Self.Obj := AParent.Presentations.Add;
  Self.Slides := TSlides.Create(Self.Obj);
end;

destructor TPresentation.Destroy;
begin
  Self.Slides.Destroy;
  inherited Destroy;
end;

procedure TPresentation.SaveAs(FileName: TFileName);
begin
  Self.Obj.SaveAs(FileName);
end;

{ TPowerPointApp }

constructor TPowerPointApp.Create;
begin
  inherited Create;
  Self.AppObj := CreateOleObject(MSPPT);
  Self.Presentation := TPresentation.Create(Self.AppObj);
end;

destructor TPowerPointApp.Destroy;
begin
  Self.Presentation.Destroy;  
  inherited Destroy;
end;

procedure TPowerPointApp.SetVisible(AVisible: boolean);
begin
  FVisible := AVisible;
  Self.AppObj.Visible := AVisible;
end;


end.
