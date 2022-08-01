unit ADODBWork;

interface

uses
  Classes, DB, ADODB;

type
  TQueryMode = (qmOpen = 0, qmExec = 1);
  TSaveMode = (smAppend = 0, smEdit = 1);

type
  TOperationType = (otNone = 0, otNot = 1, otAnd = 2, otOr = 3, otXor = 4);
  TCompareMode = (cmMore = 0, cmLess = 1, cmEqu = 2, cmMoreEqu = 3,
    cmLessEqu = 4, cmNotEqu = 5);

type
  TTableName = string[20];
  TFieldName = string[20];

  TFieldInfo = record
    Field: TFieldName;
    Value: Variant;
  end;

  TFieldList = array of TFieldInfo;

  TFieldNameList = array of TFieldName;

type
  TFields = array of integer;

type
  PWhereParam = ^TWhereParam;
  TWhereParam = record
    Field: TFieldName;
    Value: Variant;
    Compare: TCompareMode;
    Operation: TOperationType;
    Operand: PWhereParam;
  end;

type
  TWhereParamList = array of TWhereParam;

type
  TCustomADODB = class(TADOQuery)
  private
    FLastID: integer;
  public
    property LastID: integer read FLastID;
    // Exec Query
    function ExecQuery(SQL: WideString;
      QueryMode: TQueryMode = qmOpen): boolean; overload;
    function ExecQuery(QueryMode: TQueryMode = qmOpen): boolean; overload;
    class function ExecQuery(AQuery: TADOQuery; SQL: WideString;
      QueryMode: TQueryMode = qmOpen): boolean; overload;
    // Delete Record
    function DelRec(TableName: TTableName; Where: WideString = ''): boolean; overload;
    function DelRec(TableName: TTableName; ID: integer): boolean; overload;
    // Save Record
    function SaveRec(SQL: WideString; FieldList: TFieldList; var Count: integer;
      SaveMode: TSaveMode = smEdit): boolean; overload;
    function SaveRec(SQL: WideString; FieldName: TFieldName; Value: Variant;
      SaveMode: TSaveMode = smEdit): boolean; overload;
    // Add Record (Use Save Record function)
    function AddRec(TableName: TTableName; FieldList: TFieldList): boolean; overload;
    function AddRec(TableName: TTableName; FieldName: TFieldName;
      Value: Variant): boolean; overload;
    // Load Record
    function LoadRec(Des: TObject; SQL: WideString; FieldList: TFieldNameList;
      DataField: TFieldName; Sep: string; var Count: integer): boolean; overload;
    function LoadRec(Des: TObject; SQL: WideString; FieldName: TFieldName;
      DataField: TFieldName): boolean; overload;
    function LoadRec(Des: TObject;SQL: WideString;
      DataField: TFieldName): boolean; overload;

    class function GetWhereString(ParamList: TWhereParamList;
      TableName: TTableName = ''): WideString;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils, Controls, StdCtrls, ComCtrls, Variants;

const
  Operations : array[0..4] of string[3] = ('','not', 'and' , 'or' , 'xor');
  CompareMode: array[0..5] of string[2] = ('>', '<', '=', '>=', '<=', '<>');

const
  ID_ERROR = -1;

{ TADODB }

function TCustomADODB.AddRec(TableName: TTableName; FieldList: TFieldList): boolean;
var Count: integer;
begin
  Result := SaveRec('Select * from '+ TableName,FieldList,Count,smAppend);
end;

function TCustomADODB.AddRec(TableName: TTableName; FieldName: TFieldName; Value: Variant): boolean;
begin
  Result := SaveRec('Select * from '+ TableName,FieldName,Value,smAppend);
end;

constructor TCustomADODB.Create(AOwner: TComponent);
begin
  inherited;
end;

function TCustomADODB.DelRec(TableName: TTableName; Where: WideString): boolean;
begin
  Result := ExecQuery('Delete from ' + TableName + ' where ' + Where,qmExec);
end;

function TCustomADODB.DelRec(TableName: TTableName; ID: integer): boolean;
begin
  Result := DelRec(TableName,TableName + '.ID = ' + IntToStr(ID));
end;

destructor TCustomADODB.Destroy;
begin
  Self.Close;
  inherited;
end;

class function TCustomADODB.ExecQuery(AQuery: TADOQuery; SQL: WideString;
  QueryMode: TQueryMode): boolean;
begin
  Result := true;
  try
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Add(SQL);
    case QueryMode of
      qmOpen:  AQuery.Open;
      qmExec:  AQuery.ExecSQL;
    end;
  except
    Result := false;
  end;
end;

function TCustomADODB.ExecQuery(QueryMode: TQueryMode): boolean;
begin
  Result := ExecQuery(Self,Self.SQL.Text,QueryMode);
end;

function TCustomADODB.LoadRec(Des: TObject; SQL: WideString; FieldList: TFieldNameList;
  DataField: TFieldName; Sep: string; var Count: integer): boolean;

  function GetValueString(Fields: TFieldNameList; Sep: string): string;
  var i: integer;
  begin
    Result := '';
    for i := Low(Fields) to High(Fields) do
    begin
      if Self.FindField(Fields[i]) <> nil then
      begin
        if Trim(Result) <> '' then
          Result := Result + Sep;
        Result := Result + Trim(Self.FieldByName(Fields[i]).AsString) + Sep;
      end;
    end;
  end;

var
  Item: TListItem;
  i: integer;

begin
  if Length(FieldList) = 0 then
  begin
    Result := false;
    Exit;
  end;
  Result := true;
  if Des.ClassNameIs('TComboBox') or Des.ClassNameIs('TListBox') or
     Des.ClassNameIs('TListView') or Des.ClassNameIs('TDrawListView') then
    (Des as TCustomListControl).Clear
  else
    (Des as TStrings).Clear;
  if not Self.Active then Exit;
  if ExecQuery(SQL) then
  begin
    try
      while not Self.Eof do
      begin

        if Des.ClassNameIs('TComboBox') then
        begin
          if DataField <> '' then
            (Des as TComboBox).Items.AddObject(GetValueString(FieldList,Sep),
              TObject(Self.FieldByName(DataField).AsInteger))
          else
            (Des as TComboBox).Items.Add(GetValueString(FieldList,Sep));
        end;

        if Des.ClassNameIs('TListBox') then
        begin
          if DataField <> '' then
            (Des as TListBox).Items.AddObject(Self.FieldByName(Name).AsString,
              TObject(Self.FieldByName(DataField).AsInteger))
          else
            (Des as TListBox).Items.Add(Self.FieldByName(Name).AsString);
        end;

        if Des.ClassNameIs('TListView') or Des.ClassNameIs('TDrawListView') then
        begin
          Item := (Des as TListView).Items.Add;

          if (Des as TListView).Columns.Count = Length(FieldList) then
          begin
            Item.Caption := Self.FieldByName(FieldList[0]).AsString;
            for i := Low(FieldList) + 1 to High(FieldList) do
            begin
              item.SubItems.Add(Self.FieldByName(FieldList[i]).AsString);
            end;
          end else
            Item.Caption := GetValueString(FieldList,Sep);

          if DataField <> '' then
            Item.Data := Pointer(Self.FieldByName(DataField).AsInteger);
        end;

        if Des.ClassNameIs('TStringList') then
        begin
          if Sep = '%' then
          begin
            for i := Low(FieldList) to High(FieldList) do
              (Des as TStringList).Add(FieldList[i] + '=' +
                Self.FieldByName(FieldList[i]).AsString);
          end else
          (Des as TStringList).Add(GetValueString(FieldList,Sep) + '='+
            IntToStr(Self.FieldByName(DataField).AsInteger));
        end;

        Self.Next;
      end;
    except
      Result := false;
    end;
  end;
end;

class function TCustomADODB.GetWhereString(ParamList: TWhereParamList;
  TableName: TTableName = ''): WideString;

  function GetValueString(Value: Variant): WideString;
  begin
    if VarIsStr(Value) then
      Result := '''' + VarToStr(Value) + ''''
    else
      Result := VarToStr(Value);
  end;

var i: integer;
begin
  Result := '';
  TableName := Trim(TableName);
  if TableName <> '' then
    TableName := TableName + '.';
  for i := Low(ParamList) to High(ParamList) do
  begin
    with ParamList[i] do
      Result := Result + ' ' + TableName + Field + ' ' +
        CompareMode[Integer(Compare)] + ' ' + GetValueString(Value) + ' ' +
        Operations[Integer(Operation)];
  end;
end;

function TCustomADODB.LoadRec(Des: TObject; SQL: WideString;
  DataField: TFieldName): boolean;
var NameList: TStringList;
    FList: TFieldNameList;
    i, Count: integer;
begin
  Result := false;
  NameList := TStringList.Create;
  try
    if ExecQuery(SQL) then
    begin
      Self.Fields.GetFieldNames(NameList);
      if NameList.Count > 0  then
      begin
        SetLength(FList,NameList.Count);
        for i := 0 to NameList.Count - 1 do
          FList[i] := NameList.Strings[i];
        Result := Self.LoadRec(Des,SQL,FList,DataField,'%',Count);
        SetLength(FList,0);
      end;
    end;
  finally
    NameList.Free;
  end;
end;

function TCustomADODB.LoadRec(Des: TObject; SQL: WideString; FieldName,
  DataField: TFieldName): boolean;
var FList: TFieldNameList;
    Count: integer;
begin
  SetLength(FList,1);
  FList[0] := FieldName;
  Result :=  LoadRec(Des,SQL,FList,DataField,'',Count);
  SetLength(FList,0);
end;

function TCustomADODB.SaveRec(SQL: WideString; FieldName: TFieldName; Value: Variant;
  SaveMode: TSaveMode = smEdit): boolean;
var FList: TFieldList;
    Count: integer;
begin
  SetLength(FList,1);
  FList[0].Field := FieldName;
  FList[0].Value := Value;
  Result := SaveRec(SQL,FList,Count,SaveMode);
  SetLength(FList,0);
end;

function TCustomADODB.SaveRec(SQL: WideString; FieldList: TFieldList; var Count: integer;
  SaveMode: TSaveMode): boolean;

  function SetFieldValue(Field: TField; Value: Variant): boolean;
  begin
    Result := true;
    if Field.KeyFields <> '' then
      FLastID := Field.DataSet.FieldByName(Field.KeyFields).AsVariant;
    try
      case Field.DataType of
        ftFloat                       : Field.AsFloat      := Double(Value);
        ftString                      : Field.AsString     := VarToStr(Value);
        ftBoolean                     : Field.AsBoolean    := Boolean(Value);
        ftCurrency                    : Field.AsCurrency   := Currency(Value);
        ftWideString                  : Field.AsWideString := VarToWideStr(Value);
        ftDate, ftTime, ftDateTime    : Field.AsDateTime   := VarToDateTime(Value);
        ftSmallint, ftInteger, ftWord : Field.AsInteger    := Value;
      else
        Field.AsVariant := Value;
      end;
    except
      Result := false;
    end;
  end;

var
  i: integer;

begin
  Count := 0;
  FLastID := ID_ERROR;
  if ExecQuery(SQL) then
  begin
    while (not Self.Eof) or (SaveMode = smAppend)  do
    begin
      case SaveMode of
        smAppend: Self.Append;
        smEdit  : Self.Edit;
      end;
      for i := Low(FieldList) to High(FieldList) do
        if SetFieldValue(Self.FieldByName(FieldList[i].Field), FieldList[i].Value) then
          Inc(Count);
      Self.Post;
      if Self.FindField('id') <> nil then
        FLastID := Self.FieldByName('id').AsInteger;
      if SaveMode <> smEdit then break;
      Self.Next;
    end;
  end;
  if SaveMode <> smAppend then
    Result := Count = Length(FieldList) * Self.RecordCount
  else
    Result := Count = Length(FieldList); 
end;

function TCustomADODB.ExecQuery(SQL: WideString; QueryMode: TQueryMode): boolean;
begin
  Result := ExecQuery(Self,SQL,QueryMode);
end;

end.

