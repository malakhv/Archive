unit OLE;

interface

uses SysUtils, Classes;

{ OLE Errors }
const
  OLE_NO_ERROR        = 0;  // OLE Errors: Has no error
  OLE_CREATEOBJ_ERROR = 1;  // OLE Errors: Error of creating object
  OLE_PROPERTY_ERROR  = 2;  // OLE Errors: Error of accessing to property
  OLE_METHOD_ERROR    = 3;  // OLE Errors: Error of calling a method
  OLE_OWNERDONTEXISTS = 4;  // OLE Errors:
  OLE_SETOBJECT_ERROR = 5;  // OLE Errors: Error of setting up value

//type
//  TOleErrors = set of

{ TOleObjectName }
type
  TOleObjectName = string[255];

{ TOleObject. The base object represents OLE object. }
type
  TOleObject = class(TObject)
  private
    FOleObj: Variant;
    FObjName: TOleObjectName;
    FLastError: byte;
  protected
    function DoExists: Boolean;
    function DoGetLastError: byte;
    procedure DoSetName(const Value: TOleObjectName);
    procedure ClearOleObject;
    procedure ClearLastError;
  public
    function Attach: Boolean;
    function HasError: Boolean;
    procedure Clear; virtual;
    property Name: TOleObjectName read FObjName write DoSetName;
    property Error: byte read DoGetLastError;
    property Exists: Boolean read DoExists;
    property OleObject: Variant read FOleObj;
    constructor Create(AName: TOleObjectName); virtual;
    destructor Destroy; override;
  end;

{ TOleComponent. The TOleObject that has a parent. }
type
  TOleComponent = class(TOleObject)
  private
    FParent: TOleObject;
    function DoGetVisible: Boolean;
    procedure DoSetVisible(const Value: Boolean);
  protected
    function HasParent: Boolean; virtual;
    procedure DoSetParent(AParent: TOleObject); virtual;
  public
    property Parent: TOleObject read FParent write DoSetParent;
    property Visible: Boolean read DoGetVisible write DoSetVisible;
    constructor Create(AName: TOleObjectName); overload; override;
    constructor Create(AName: TOleObjectName; AParent: TOleObject); overload;
  end;

implementation

uses System.Win.ComObj, System.Variants;

{ TOleObject }

function TOleObject.Attach: Boolean;
begin
  ClearLastError;
  try
    FOleObj := CreateOleObject(Name);
    Result := True;
  except
    FLastError := OLE_CREATEOBJ_ERROR;
    ClearOleObject;
    Result := False;
  end;
end;

procedure TOleObject.Clear;
begin
  ClearOleObject;
end;

procedure TOleObject.ClearLastError;
begin
  FLastError := OLE_NO_ERROR;
end;

procedure TOleObject.ClearOleObject;
begin
  VarClear(FOleObj);
end;

constructor TOleObject.Create(AName: TOleObjectName);
begin
  inherited Create;
  Self.Name := Name;
end;

destructor TOleObject.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TOleObject.DoExists: Boolean;
begin
  Result := VarIsType(FOleObj, varDispatch);
end;

function TOleObject.DoGetLastError: byte;
begin
  Result := FLastError;
end;

procedure TOleObject.DoSetName(const Value: TOleObjectName);
begin
  FObjName := Value;
end;

function TOleObject.HasError: Boolean;
begin
  Result := Error <> OLE_NO_ERROR;
end;

{ TOleComponent }

constructor TOleComponent.Create(AName: TOleObjectName; AParent: TOleObject);
begin
  inherited Create(AName);
  FParent := AParent;
end;

constructor TOleComponent.Create(AName: TOleObjectName);
begin
  inherited Create(AName);  // Why it does not work?
  Name := AName;
end;

function TOleComponent.DoGetVisible: Boolean;
begin
  if Self.Exists then
  begin
    ClearLastError;
    try
      Result := Self.OleObject.Visible;
    except
      FLastError := OLE_PROPERTY_ERROR;
      Result := False; // Default value
    end;
  end;
end;

procedure TOleComponent.DoSetParent(AParent: TOleObject);
begin
  FParent := AParent;
end;

procedure TOleComponent.DoSetVisible(const Value: Boolean);
begin
  if Self.Exists then
  begin
    ClearLastError;
    try
      Self.OleObject.Visible := Value;
    except
      FLastError := OLE_PROPERTY_ERROR;
    end;
  end;
end;

function TOleComponent.HasParent: Boolean;
begin
  //Result := Self.Parent <> nil and Self.Parent.Exists;
end;

end.
