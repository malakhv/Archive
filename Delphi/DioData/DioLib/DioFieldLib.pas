
{******************************************************************************}
{                                                                              }
{                           Dio Data Class Library                             }
{                                                                              }
{                       Copyright (c) 2008-2009 itProject                      }
{                                                                              }
{******************************************************************************}

unit DioFieldLib;

interface

uses SysUtils, Classes, MyClasses, DioXML;

type

  { Класс для работы с полями данных }

  TDioField = class(TCustomDioXML)
  private
    function GetEnabled: boolean;
    function GetFieldIndex: integer;
  public
    property Enabled: boolean read GetEnabled;
    property FieldIndex: integer read GetFieldIndex;
  end;

  { Класс для работы со списком полей }

  TDioFields = class(TXMLDioCollection)
  private
    EDioField: TDioField;
    function GetItem(Index: integer): TDioField;
    function GetEnabledCount: integer;
  public
    property Item[Index: integer]: TDioField read GetItem; default;
    property EnabledCount: integer read GetEnabledCount;
    constructor Create(ADioType: byte); override;
    destructor Destroy; override;
  end;

implementation

const

  { Имена атрибутов XML }

  aFieldIndex = 'FieldIndex';

{ TDioField }

function TDioField.GetEnabled: boolean;
begin
  Result := NodeValue;
end;

function TDioField.GetFieldIndex: integer;
begin
  Result := Attribute[aFieldIndex];
end;

{ TDioFields }

constructor TDioFields.Create(ADioType: byte);
begin
  inherited;
  EDioField := TDioField.Create(nil);
  XMLType := dxtFields;
end;

destructor TDioFields.Destroy;
begin
  EDioField.Free;
  inherited;
end;

function TDioFields.GetEnabledCount: integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Item[i].Enabled then Inc(Result)
end;

function TDioFields.GetItem(Index: integer): TDioField;
begin
  EDioField.XMLNode := XMLNode.ChildNodes[Index];
  if EDioField.Exists then
    Result := EDioField
  else
    Result := nil;
end;

end.
