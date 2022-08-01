unit MyLog;

interface

uses SysUtils, Classes, MyClasses;

type

  TBeforAddStrEvent = procedure(Sender: TObject; var Str: string) of object;

  TCustomLog = class(TCustomFileObject)
  private
    EList: TStringList;
    EAutoSave: boolean;
    EInsertTime: boolean;
    EBeforAdd: TBeforAddStrEvent;
    EAfterAdd: TNotifyEvent;
    EOnChange: TNotifyEvent;
    FMaxCount: integer;
    procedure SetData(const Value: TStringList);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetMaxCount(const Value: integer);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
    procedure DoBeforAdd(var Str: string); virtual;
    procedure DoAfterAdd; virtual;
  public
    property AutoSave: boolean read EAutoSave write EAutoSave;
    property InsertTime: boolean read EInsertTime write EInsertTime;
    property Data: TStringList read EList write SetData;
    property BeforAdd: TBeforAddStrEvent read EBeforAdd write EBeforAdd;
    property AfterAdd: TNotifyEvent read EAfterAdd write EAfterAdd;
    property OnChange: TNotifyEvent read EOnChange write SetOnChange;
    property MaxCount: integer read FMaxCount write SetMaxCount;
    procedure Add(Str: string);
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Des: TPersistent); override;
    procedure Clear;
    constructor Create(AFileName: TFileName = ''); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TCustomLog }

procedure TCustomLog.Add(Str: string);
begin
  DoBeforAdd(Str);
  if MaxCount > 0 then
    while EList.Count >= MaxCount do
      EList.Delete(0);
  if EInsertTime then
    EList.Add(DateTimeToStr(Now) + ' - ' + Str)
  else
    EList.Add(Str);
  if AutoSave then Save;
  DoAfterAdd;
end;

procedure TCustomLog.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomLog then
  begin
    EList.Assign( (Source as TCustomLog).EList );
    EBeforAdd := (Source as TCustomLog).BeforAdd;
    EAfterAdd := (Source as TCustomLog).AfterAdd;
    EInsertTime := (Source as TCustomLog).InsertTime;
  end;
end;

procedure TCustomLog.AssignTo(Des: TPersistent);
begin
  inherited;
  if (Des is TCustomLog) then Des.Assign(Self);
end;

procedure TCustomLog.Clear;
begin
  EList.Clear;
  if AutoSave then Save;
end;

constructor TCustomLog.Create(AFileName: TFileName);
begin
  inherited Create;
  EList := TStringList.Create;
  EAutoSave := false;
  EInsertTime := true;
  MaxCount := 0;
  if AFileName <> ''  then FileName := AFileName;
end;

destructor TCustomLog.Destroy;
begin
  if EList <> nil then EList.Free;
  inherited;
end;

procedure TCustomLog.DoAfterAdd;
begin
  if Assigned(EAfterAdd) then EAfterAdd(Self);
end;

procedure TCustomLog.DoBeforAdd(var Str: string);
begin
  if Assigned(EBeforAdd) then EBeforAdd(Self,Str);
end;

function TCustomLog.DoLoadFromFile(const AFileName: TFileName): boolean;
begin
  EList.LoadFromFile(AFileName);
  Result := true;
end;

function TCustomLog.DoSaveToFile(const AFileName: TFileName): boolean;
begin
  EList.SaveToFile(AFileName);
  Result := true;
end;

procedure TCustomLog.SetData(const Value: TStringList);
begin
  if Value <> nil then
  begin
    EList.Assign(Value);
    if AutoSave then Save;
  end;
end;

procedure TCustomLog.SetMaxCount(const Value: integer);
begin
  if Value >= 0 then
    FMaxCount := Value
  else
    FMaxCount := 0;
end;

procedure TCustomLog.SetOnChange(const Value: TNotifyEvent);
begin
  EList.OnChange := Value;
end;

end.
