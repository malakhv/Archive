unit MyOleObject;

interface

uses Classes;

const

  { Коды ошибок }

  OLE_ER_NONE      = 0;  // Ошибки нету
  OLE_ER_CREATEOBJ = 1;  // Ошибка создания обьекта
  OLE_ER_PROPERTY  = 2;  // Ошибка доступа к свойству
  OLE_ER_METHOD    = 3;  // Ошибка вызова метода
  OLE_ER_SETOBJECT = 4;  // Ошибка установки значения обьекта

type

  { Базовый OLE объект }

  TOleObject = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    function GetOleObj: OleVariant;
    procedure SetOleObj(const Value: OleVariant);
  protected
    function DoGetOleObj: OleVariant; virtual; abstract;
    procedure DoSetOleObj(AOleObj: OleVariant); virtual; abstract;
    procedure DoChange; virtual;
  public
    property OleObj: OleVariant read GetOleObj write SetOleObj;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Exists: boolean; virtual;
    procedure Assign(Source: TPersistent); override;
  end;

  { OLE объект имеющий родителя }

  TOleComponent = class(TOleObject)
  private
    FParent: TOleObject;
    function GetParent: TOleObject;
    procedure SetParent(const Value: TOleObject);
  protected
    function ParentExists: boolean; virtual;
    function DoGetParent: TOleObject;
    procedure DoSetParent(AParent: TOleObject); virtual;
  public
    property Parent: TOleObject read GetParent write SetParent;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AParent: TOleObject); virtual;
  end;

  { Базовый OLE объект, содержащий  свойство Text }

  TOleTextObj = class(TOleComponent)
  private
    function GetText: string;
    procedure SetText(const Value: string);
  public
    property Text: string read GetText write SetText;
  end;

  { Базовый OLE объект, с переменной для хранения указателя }

  TBaseOleObject = class(TOleComponent)
  private
    FOleObj: OleVariant;
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    procedure Clear; virtual;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

  { Базовый класс элемента коллекции }

  TOleItem = class(TOleComponent)
  private
    function GetIndex: integer;
    procedure SetIndex(const Value: integer);
  protected
    FIndex: integer;
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
    function DoGetIndex: integer; virtual;
    procedure DoSetIndex(AIndex: integer); virtual;
  public
    property Index: integer read GetIndex write SetIndex;
    function ValidateIndex: boolean;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AParent: TOleObject); override;
  end;

  { Базовый класс коллекции обьектов }

  TOleCollection = class(TOleComponent)
  private
    function GetCount: integer;
  public
    property Count: integer read GetCount;
    function IndexOf(AOleObj: OleVariant): integer;
  end;

implementation

uses Variants;

{ TOleObject }

procedure TOleObject.Assign(Source: TPersistent);
begin
  if Source is TBaseOleObject then
    OleObj := TBaseOleObject(Source).OleObj;
end;

procedure TOleObject.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TOleObject.Exists: boolean;
begin
  Result := VarIsType(OleObj,varDispatch);
end;

function TOleObject.GetOleObj: OleVariant;
begin
  Result := DoGetOleObj;
end;

procedure TOleObject.SetOleObj(const Value: OleVariant);
begin
  DoSetOleObj(Value);
  DoChange;
end;

{ TOleComponent }

procedure TOleComponent.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TOleComponent then
    Parent := TOleComponent(Source).Parent;
end;

constructor TOleComponent.Create(AParent: TOleObject);
begin
  inherited Create;
  Parent := AParent;
end;

function TOleComponent.DoGetParent: TOleObject;
begin
  Result := FParent;
end;

procedure TOleComponent.DoSetParent(AParent: TOleObject);
begin
  FParent := AParent;
end;

function TOleComponent.GetParent: TOleObject;
begin
  Result := DoGetParent;
end;

function TOleComponent.ParentExists: boolean;
begin
  Result := Parent <> nil;
  if Result then Result := Parent.Exists;
end;

procedure TOleComponent.SetParent(const Value: TOleObject);
begin
  DoSetParent(Value);
end;

{ TOleTextObj }

function TOleTextObj.GetText: string;
begin
 if Exists then
  Result := OleObj.Text
 else
  Result := '';
end;

procedure TOleTextObj.SetText(const Value: string);
begin
  if Exists then OleObj.Text := Value;
end;

{ TBaseOleObject }

procedure TBaseOleObject.Clear;
begin
  VarClear(FOleObj);
end;

constructor TBaseOleObject.Create(AParent: TOleObject);
begin
  inherited;
  Clear;
end;

destructor TBaseOleObject.Destroy;
begin
  Clear;
  inherited;
end;

function TBaseOleObject.DoGetOleObj: OleVariant;
begin
  Result := FOleObj;
end;

procedure TBaseOleObject.DoSetOleObj(AOleObj: OleVariant);
begin
  FOleObj := AOleObj;
end;

{ TOleItem }

procedure TOleItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TOleItem then
    Index := TOleItem(Source).Index;
end;

constructor TOleItem.Create(AParent: TOleObject);
begin
  inherited;
  FIndex := -1;
end;

function TOleItem.DoGetIndex: integer;
begin
  Result := FIndex;
end;

function TOleItem.DoGetOleObj: OleVariant;
begin
  if ParentExists and ValidateIndex then
    Result := Parent.OleObj.Item(FIndex)
  else
    VarClear(Result);
end;

procedure TOleItem.DoSetIndex(AIndex: integer);
begin
  FIndex := AIndex;
end;

procedure TOleItem.DoSetOleObj(AOleObj: OleVariant);
begin
  if ParentExists then
    Index := TOleCollection(Parent).IndexOf(AOleObj)
  else
    Index := -1;
end;

function TOleItem.GetIndex: integer;
begin
  Result := DoGetIndex;
end;

procedure TOleItem.SetIndex(const Value: integer);
begin
  DoSetIndex(Value);
end;

function TOleItem.ValidateIndex: boolean;
begin
  Result := (FIndex > 0) and (FIndex <= TOleCollection(Parent).Count);
end;

{ TOleCollection }

function TOleCollection.GetCount: integer;
begin
  if Exists then
    Result := OleObj.Count
  else
    Result := -1;
end;

function TOleCollection.IndexOf(AOleObj: OleVariant): integer;
var i: integer;
begin
  Result := -1;
  for i := 1 to Count do
    if TVarData(OleObj.Item(i)).VDispatch = TVarData(AOleObj).VDispatch then
    begin
      Result := i;
      Break;
    end;
end;

end.
