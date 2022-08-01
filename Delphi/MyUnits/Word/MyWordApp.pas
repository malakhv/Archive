unit MyWordApp;

interface

uses Classes, MyOleObject, MyWordObject, MyWordDocs;

const

  { Действия метода Move }

  WdCharacter = 1;    // Переход к следующему символу
  WdWord = 2;         // Переход к следующему слову
  WdSentence = 3;     // Переход к следующему предложению
  WdParagraph = 4;    // Переход к следующему абзацу
  WdLine = 5;         // Переход к следующей линии
  WdStory = 6;        // Переход в следующую текстовую область документа
  WdSection = 8;      // Переход к следующему разделу
  WdColumn = 9;       // Переход к следующему столбцу
  WdRow = 10;         // Переход к следующей строке
  WdCell = 12;        // Переход к следующей ячейки
  WdTable = 15;       // Переход к следующей таблице

const

  { Типы выделенного объекта }

  wdSelectionNone = -1;
  wdSelectionNormal = 2;

type

  { Объект выделение }

  TWordSelection = class(TOleTxtWrkObj)
  private
    FFind: TWordFind;
    function GetSelType: integer;
    function GetSelEnd: integer;
    function GetSelStart: integer;
    procedure SetSelEnd(const Value: integer);
    procedure SetSelStart(const Value: integer);
    function GetSelStyle: integer;
    procedure SetSelStyle(const Value: integer);
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    property Find: TWordFind read FFind;
    property SelType: integer read GetSelType;
    property SelStyle: integer read GetSelStyle write SetSelStyle;
    property SelStart: integer read GetSelStart write SetSelStart;
    property SelEnd: integer read GetSelEnd write SetSelEnd;
    function Move(MoveUnit: integer = 1; Count: integer = 1): integer;
    procedure TypeParagraph;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

type

  { Приложение MS Word }

  TWordApp = class(TBaseOleObject)
  private
    FQuitOnFree: boolean;
    FDocuments: TWordDocs;
    FSelection: TWordSelection;
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    procedure SetDocuments(const Value: TWordDocs);
  protected
    function CreateWordObject: boolean; virtual;
  public
    property Documents: TWordDocs read FDocuments write SetDocuments;
    property Selection: TWordSelection read FSelection;
    property QuitOnFree: boolean read FQuitOnFree write FQuitOnFree;
    property Visible: boolean read GetVisible write SetVisible;
    procedure Assign(Source: TPersistent); override;
    procedure Open;
    procedure Quit;
    procedure Show;
    constructor Create(AutoCreate: boolean = false); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses ComObj, Variants;

const

  { Проложение MS Word }

  WORD_APP = 'Word.Application';

{ TWordApp }

procedure TWordApp.Assign(Source: TPersistent);
begin
  inherited;
  if Source <> nil then
    if Source is TWordApp then
      QuitOnFree := (Source as TWordApp).QuitOnFree;
end;

constructor TWordApp.Create(AutoCreate: boolean);
begin
  inherited Create(nil);
  FDocuments := TWordDocs.Create(Self);
  FSelection := TWordSelection.Create(Self);
  QuitOnFree := false;
  if AutoCreate then CreateWordObject;
end;

function TWordApp.CreateWordObject: boolean;
begin
  Result := true;
  if Exists then Clear;
  try
    OleObj := CreateOleObject(WORD_APP);
  except
    Result := false;
  end;
end;

destructor TWordApp.Destroy;
begin
  if QuitOnFree then Quit;
  FDocuments.Free;
  FSelection.Free;
  inherited;
end;

function TWordApp.GetVisible: boolean;
begin
  try
    Result := OleObj.Visible;
  except
    Result := false;
  end;
end;

procedure TWordApp.Open;
begin
  CreateWordObject;
end;

procedure TWordApp.Quit;
begin
  if Exists then OleObj.Quit;
  Clear;
end;

procedure TWordApp.SetDocuments(const Value: TWordDocs);
begin
  FDocuments := Value;
end;

procedure TWordApp.SetVisible(const Value: boolean);
begin
  if Exists then
    OleObj.Visible := Value;
end;

procedure TWordApp.Show;
begin
  Visible := true;
end;

{ TWordSelection }

constructor TWordSelection.Create(AParent: TOleObject);
begin
  inherited;
  FFind := TWordFind.Create(Self);
end;

destructor TWordSelection.Destroy;
begin
  FFind.Free;
  inherited;
end;

function TWordSelection.DoGetOleObj: OleVariant;
begin
  if ParentExists then
    Result := Parent.OleObj.Selection
  else
    VarClear(Result);
end;

procedure TWordSelection.DoSetOleObj(AOleObj: OleVariant);
begin
  Exit;
end;

function TWordSelection.GetSelType: integer;
begin
  if Exists then
    Result := OleObj.Type
  else
    Result := wdSelectionNone;
end;

function TWordSelection.Move(MoveUnit, Count: integer): integer;
begin
  if Exists then
    Result := OleObj.Move(MoveUnit, Count)
  else
    Result := 0;
end;

function TWordSelection.GetSelEnd: integer;
begin
  if Exists then
    Result := OleObj.End
  else
    Result := -1;
end;

function TWordSelection.GetSelStart: integer;
begin
  if Exists then
    Result := OleObj.Start
  else
    Result := -1;
end;

function TWordSelection.GetSelStyle: integer;
begin
  if Exists then
    Result := OleObj.Style
  else
    Result := -1;
end;

procedure TWordSelection.SetSelEnd(const Value: integer);
begin
  if Exists then OleObj.End := Value;
end;

procedure TWordSelection.SetSelStart(const Value: integer);
begin
  if Exists then OleObj.Start := Value;
end;

procedure TWordSelection.SetSelStyle(const Value: integer);
begin
  if Exists then OleObj.Style := Value;
end;

procedure TWordSelection.TypeParagraph;
begin
  if Exists then OleObj.TypeParagraph;
end;

end.
