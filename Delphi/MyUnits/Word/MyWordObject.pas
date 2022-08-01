unit MyWordObject;

interface

uses MyOleObject;

type

  { Базовый класс, содержащий функции для работы с текстом }

  TOleTxtWrkObj = class(TOleTextObj)
  public
    procedure ConvertToTable; overload;
    procedure ConvertToTable(ASeparator: string; AFormat: integer); overload;
    procedure Copy;
    procedure CopyAsPicture;
    procedure Cut;
    procedure Paste;
    procedure Select;
    procedure Delete; overload;
    procedure Delete(DStart,DCount: integer); overload;
    procedure InsertAfter(Text: string);
    procedure InsertBefore(Text: string);
  end;

type

  { Область документа }

  TWordRange = class(TOleTxtWrkObj)
  private
    FLast: integer;
    FFirst: integer;
    procedure SetFirst(const Value: integer);
    procedure SetLast(const Value: integer);
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    property First: integer read FFirst write SetFirst;
    property Last: integer read FLast write SetLast;
    procedure SetRange(RStart,REnd: integer);
    procedure ClearRangeInterval;
    constructor Create(AParent: TOleObject); override;
  end;

type

  { Объект поиска }

  TWordFind = class(TOleTextObj)
  private
    function GetFindForward: boolean;
    procedure SetFindForward(const Value: boolean);
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    property FindForward: boolean read GetFindForward write SetFindForward;
    function Execute: boolean;
    function FindAndReplace(FindStr,ReplaceStr: string): boolean;
  end;

const

  { Форматы сохранения файла }

  WdFormatDocument          = 0;
  WdFormatTemplate          = 1;
  WdFormatText              = 2;
  WdFormatTextLineBreaks    = 3;
  WdFormatDOSText           = 4;
  WdFormatDOSTextLineBreaks = 5;
  WdFormatRTF               = 6;
  WdFormatUnicodeText       = 7;

  { Форматы открываемых файлов }

  WdOpenFormatAuto          = 0;
  WdOpenFormatDocument      = 1;
  WdOpenFormatRTF           = 3;
  WdOpenFormatTemplate      = 2;
  WdOpenFormatText          = 4;
  WdOpenFormatUnicodeText   = 5;

implementation

{ TOleTxtWrkObj }

procedure TOleTxtWrkObj.ConvertToTable;
begin
  if Exists then OleObj.ConvertToTable;
end;

procedure TOleTxtWrkObj.ConvertToTable(ASeparator: string; AFormat: integer);
begin
  if Exists then OleObj.ConvertToTable(Separator := ASeparator,Format := AFormat);
end;

procedure TOleTxtWrkObj.Copy;
begin
  if Exists then OleObj.Copy;
end;

procedure TOleTxtWrkObj.CopyAsPicture;
begin
  if Exists then OleObj.CopyAsPicture;
end;

procedure TOleTxtWrkObj.Cut;
begin
  if Exists then OleObj.Cut;
end;

procedure TOleTxtWrkObj.Delete(DStart, DCount: integer);
begin
  if Exists then OleObj.Delete(DStart,DCount);
end;

procedure TOleTxtWrkObj.Delete;
begin
  if Exists then OleObj.Delete;
end;

procedure TOleTxtWrkObj.InsertAfter(Text: string);
begin
  if Exists then OleObj.InsertAfter(Text);
end;

procedure TOleTxtWrkObj.InsertBefore(Text: string);
begin
  if Exists then OleObj.InsertBefore(Text);
end;

procedure TOleTxtWrkObj.Paste;
begin
  if Exists then OleObj.Paste;
end;

procedure TOleTxtWrkObj.Select;
begin
  if Exists then OleObj.Select;
end;

{ TWordRange }

procedure TWordRange.ClearRangeInterval;
begin
  FFirst := -1;
  FLast := -1;
end;

constructor TWordRange.Create(AParent: TOleObject);
begin
  inherited;
  ClearRangeInterval;
end;

function TWordRange.DoGetOleObj: OleVariant;
begin
  if ParentExists then
    if (FFirst >= 0) and (FLast >= 0) then
      Result := Parent.OleObj.Range(FFirst, FLast)
    else
      Result := Parent.OleObj.Range
  else
    VarClear(Result);
end;

procedure TWordRange.DoSetOleObj(AOleObj: OleVariant);
begin
  inherited;
end;

procedure TWordRange.SetFirst(const Value: integer);
begin
  if Value >= 0 then
    FFirst := Value
  else
    FFirst := -1;
end;

procedure TWordRange.SetLast(const Value: integer);
begin
  if Value >= 0 then
    FLast := Value
  else
    FLast := -1;
end;

procedure TWordRange.SetRange(RStart, REnd: integer);
begin
  First := RStart;
  Last := REnd;
end;

{ TWordFind }

function TWordFind.DoGetOleObj: OleVariant;
begin
  if ParentExists then
    Result := Parent.OleObj.Find
  else
    VarClear(Result);
end;

procedure TWordFind.DoSetOleObj(AOleObj: OleVariant);
begin
  Exit;
end;

function TWordFind.Execute: boolean;
begin
  if Exists then
    Result := OleObj.Execute
  else
    Result := false;
end;

function TWordFind.FindAndReplace(FindStr, ReplaceStr: string): boolean;
const wdReplaceAll=2;
begin
  if Exists then
  begin
    FindForward := true;
    Text := FindStr;
    OleObj.Replacement.Text := ReplaceStr;
    Result := OleObj.Execute(Replace:=wdReplaceAll);
  end else
    Result := false;
end;

function TWordFind.GetFindForward: boolean;
begin
  if Exists then
    Result := OleObj.Forward
  else
    Result := false;
end;

procedure TWordFind.SetFindForward(const Value: boolean);
begin
  if Exists then OleObj.Forward := Value;
end;

end.

