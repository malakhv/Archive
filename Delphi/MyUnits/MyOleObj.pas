
{******************************************************************************}
{                                                                              }
{                             Ole Class Library                                }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit MyOleObj;

interface

uses  SysUtils, Classes;

const

  { Коды ошибок }

  OLE_ER_NONE      = 0;
  OLE_ER_CREATEOBJ = 1;
  OLE_ER_PROPERTY  = 2;
  OLE_ER_METHOD    = 3;
  OLE_ER_SETOBJECT = 4;

type

  TOleObjectName = string[255];

type

  TBaseOleObject = class(TPersistent)
  private
    FOleObject: Variant;
    FOleName: TOleObjectName;
    function GetExists: boolean;
    procedure SetOleName(const Value: TOleObjectName);
    procedure SetOleObject(const Value: Variant);
  protected
    function DoGetExists: boolean; virtual;
    procedure DoSetOleObject(Value: Variant); virtual;
  public
    property OleName: TOleObjectName read FOleName write SetOleName;
    property OleObject: Variant read FOleObject write SetOleObject;
    property Exists: boolean read GetExists;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TParOleObject = class(TBaseOleObject)
  private
    FParent: TBaseOleObject;
    procedure SetParent(const Value: TBaseOleObject);
  protected
    procedure DoSetParent(AParent: TBaseOleObject); virtual;
  public
    property Parent: TBaseOleObject read FParent write SetParent;
    constructor Create(AParent: TBaseOleObject); reintroduce; virtual;
  end;

implementation

uses Variants;

{ TBaseOleObject }

procedure TBaseOleObject.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TBaseOleObject then
  begin
    OleName := (Source as TBaseOleObject).OleName;
    OleObject := (Source as TBaseOleObject).OleObject;
  end;
end;

procedure TBaseOleObject.Clear;
begin
  VarClear(FOleObject);
end;

constructor TBaseOleObject.Create;
begin
  inherited;
  Clear;
end;

destructor TBaseOleObject.Destroy;
begin
  Clear;
  inherited;
end;

function TBaseOleObject.DoGetExists: boolean;
begin
  Result := not VarIsEmpty(FOleObject);
end;

procedure TBaseOleObject.DoSetOleObject(Value: Variant);
begin
  Clear;
  if VarIsType(Value,varDispatch) then
    OleObject := Value;
end;

function TBaseOleObject.GetExists: boolean;
begin
  Result := DoGetExists;
end;

procedure TBaseOleObject.SetOleName(const Value: TOleObjectName);
begin
  FOleName := Value;
end;

procedure TBaseOleObject.SetOleObject(const Value: Variant);
begin
  FOleObject := Value;
end;

{ TPerOleObject }

constructor TParOleObject.Create(AParent: TBaseOleObject);
begin
  inherited Create;
  Parent := AParent;
end;

procedure TParOleObject.DoSetParent(AParent: TBaseOleObject);
begin
  FParent := AParent;
end;

procedure TParOleObject.SetParent(const Value: TBaseOleObject);
begin
  DoSetParent(Value);
end;

end.
