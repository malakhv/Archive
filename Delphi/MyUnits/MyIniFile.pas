unit MyIniFile;

interface

uses SysUtils, Classes, MyClasses;

const

  { Символы ограничивающие имя секции}

  SectStart = '[';
  SectEnd = ']';

const

  { Код ошибки }

  ErrorCode = '#Error';

  { Класс для работы с файлом настройки }

type
  TMyIniFile = class(TCustomFileObject)
  private
    FList: TStringList;
    FIsOpen: boolean;
    function GetNames(Index: integer): string;
    function GetValues(Name: string): string;
    procedure SetValues(Name: string; const Value: string);
    procedure SetValueFromIndex(Index: integer; const Value: string);
    function GetValueFromIndex(Index: integer): string;
    function GetCount: integer;
    function GetItem(Index: integer): string;
    procedure SetItem(Index: integer; const Value: string);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property Item[Index: integer]: string read GetItem write SetItem;
    property Names[Index: integer]: string read GetNames;
    property Values[Name: string]: string read GetValues write SetValues;
    property ValueFromIndex[Index: integer]: string read GetValueFromIndex write SetValueFromIndex;
    property Count: integer read GetCount;
    property IsOpen: boolean read FIsOpen;
    function NameExists(Name: string): boolean;
    function IsParamStr(Index: integer): boolean; overload;
    function IsSectionName(Index: integer): boolean; overload;
    function SectionIndex(Name: string): integer;
    class function IsParamStr(Str: string): boolean; overload;
    class function IsSectionName(Str: string): boolean; overload;
    class function StrToSectionName(Str: string): string;
    procedure Add(Name,Value: string);
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    constructor Create(AFileName: TFileName = ''); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TIniFile }

procedure TMyIniFile.Add(Name, Value: string);
begin
  FList.Add( Trim(Name) + '=' + Trim(Value) );
end;

procedure TMyIniFile.Assign(Source: TPersistent);
begin
  inherited;
  if Assigned(Source) then
    if Source is TMyIniFile then
    begin
      FileName := (Source as TMyIniFile).FileName;
      AutoLoad := (Source as TMyIniFile).AutoLoad;
      FList.Assign((Source as TMyIniFile).FList);
    end;
end;

procedure TMyIniFile.AssignTo(Des: TPersistent);
begin
  inherited;
  Des.Assign(Self);
end;

constructor TMyIniFile.Create(AFileName: TFileName);
begin
  inherited Create;
  FList := TStringList.Create;
  FIsOpen:= false;
  if Trim(AFileName) <> '' then FileName := AFileName
end;

destructor TMyIniFile.Destroy;
begin
  FList.Free;
  inherited;
end;

function TMyIniFile.DoLoadFromFile(const AFileName: TFileName): boolean;
begin
  FList.LoadFromFile(AFileName);
  FIsOpen:= true;
  Result := true;
end;

function TMyIniFile.DoSaveToFile(const AFileName: TFileName): boolean;
begin
  FList.SaveToFile(FileName);
  Result := true;
end;

function TMyIniFile.GetCount: integer;
begin
  Result := FList.Count;
end;

function TMyIniFile.GetItem(Index: integer): string;
begin
  Result := FList[Index];
end;

function TMyIniFile.GetNames(Index: integer): string;
begin
  Result := FList.Names[Index];
end;

function TMyIniFile.SectionIndex(Name: string): integer;
var i: integer;
begin
  Result := 0;
  if IsSectionName(Name) then
    for i := 0 to FList.Count - 1 do
      if FList[i] = Name then
      begin
        Result := i + 1;
        break;
      end;
end;

function TMyIniFile.GetValues(Name: string): string;
begin
  if NameExists(Name) then
    Result := FList.Values[Name]
  else
    Result := '';
end;

function TMyIniFile.GetValueFromIndex(Index: integer): string;
begin
  Result := FList.ValueFromIndex[Index]
end;

function TMyIniFile.IsParamStr(Index: integer): boolean;
begin
  Result := IsParamStr(FList[Index]);
end;

class function TMyIniFile.IsParamStr(Str: string): boolean;
begin
  Result := (not IsSectionName(Str)) and (Pos('=',Str) > 0);
end;

function TMyIniFile.IsSectionName(Index: integer): boolean;
begin
  Result := IsSectionName(FList[Index]);
end;

class function TMyIniFile.IsSectionName(Str: string): boolean;
begin
  Result := ( Pos(SectStart,Str) <> 0 ) and ( Pos(SectEnd,Str) <> 0 );
end;

function TMyIniFile.NameExists(Name: string): boolean;
begin
  Result := FList.IndexOfName(Name) <> -1;
end;

procedure TMyIniFile.SetValues(Name: string; const Value: string);
begin
  if NameExists(Name) then
    FList.Values[Name] := Trim(Value)
  else
    Add(Name,Value);
end;

class function TMyIniFile.StrToSectionName(Str: string): string;
begin
  Result := Trim(Str);
  if not IsSectionName(Result) then
  begin
    if not ( Pos(SectStart, Str) <> 0 ) then Result := SectStart + Result;
    if not ( Pos(SectEnd, Str) <> 0 ) then Result := Result + SectEnd;
  end;
end;

procedure TMyIniFile.SetItem(Index: integer; const Value: string);
begin
  FList[Index] := Value;
end;

procedure TMyIniFile.SetValueFromIndex(Index: integer; const Value: string);
begin
  FList.ValueFromIndex[Index] := Value;
end;

end.
