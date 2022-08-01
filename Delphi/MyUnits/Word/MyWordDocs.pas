unit MyWordDocs;

interface

uses SysUtils, MyOleObject, MyWordObject, MyWordTables;

type

{ Документ }

  TWordDoc = class(TOleItem)
  private
    FRange: TWordRange;
    FTables: TWordTables;
  protected
    function DoGetIndex: integer; override;
  public
    property Range: TWordRange read FRange;
    property Tables: TWordTables read FTables;
    procedure Activate;
    procedure Select;
    procedure SaveAsAttr(FileName: TFileName; FileFormat: integer = 0;
      LockComments: boolean = false; Password: string = '';
      AddToRecentFiles: boolean = true; WritePassword: string = '';
      ReadOnlyRecommended: boolean = false; EmbedTrueTypeFonts: boolean = true;
      SaveNativePictureFormat: boolean = true; SaveFormsData: boolean = false;
      SaveAsAOCELetter: boolean = false);
    procedure SaveAs(FileName: TFileName; FileFormat: integer = 0);
    procedure SaveAsPswrd(FileName: TFileName; ReadPswrd, WritePswrd: string);
    procedure Save;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;

  { Коллекция документов }

  TWordDocs = class(TOleCollection)
  private
    FDoc: TWordDoc;
    function GetItem(Index: integer): TWordDoc;
    function GetCount: integer;
  protected
    function DoGetOleObj: OleVariant; override;
    procedure DoSetOleObj(AOleObj: OleVariant); override;
  public
    property Item[Index: integer]: TWordDoc read GetItem; default;
    property Count: integer read GetCount;
    function Add(TemplateName: TFileName = ''): TWordDoc;
    procedure Close;
    constructor Create(AParent: TOleObject); override;
    destructor Destroy; override;
  end;


implementation

{ TWordDoc }

procedure TWordDoc.Activate;
begin
  if Exists then OleObj.Activate;
end;

constructor TWordDoc.Create(AParent: TOleObject);
begin
  inherited;
  FRange := TWordRange.Create(Self);
  FTables := TWordTables.Create(Self);
end;

destructor TWordDoc.Destroy;
begin
  FRange.Free;
  inherited;
end;

function TWordDoc.DoGetIndex: integer;
begin
  if ParentExists then
    Result := TOleCollection(Parent).IndexOf(OleObj)
  else
    Result := -1;
end;

procedure TWordDoc.Save;
begin
  OleObj.Save;
end;

procedure TWordDoc.SaveAs(FileName: TFileName; FileFormat: integer);
begin
  OleObj.SaveAs(FileName := FileName, FileFormat := FileFormat);
end;

procedure TWordDoc.SaveAsAttr(FileName: TFileName; FileFormat: integer;
  LockComments: boolean; Password: string; AddToRecentFiles: boolean;
  WritePassword: string; ReadOnlyRecommended, EmbedTrueTypeFonts,
  SaveNativePictureFormat, SaveFormsData, SaveAsAOCELetter: boolean);
begin
  OleObj.SaveAs(FileName := FileName, FileFormat := FileFormat,
    LockComments := LockComments, Password := Password,
    AddToRecentFiles := AddToRecentFiles, WritePassword := WritePassword,
    ReadOnlyRecommended := ReadOnlyRecommended,
    EmbedTrueTypeFonts := EmbedTrueTypeFonts,
    SaveNativePictureFormat := SaveNativePictureFormat,
    SaveFormsData := SaveFormsData, SaveAsAOCELetter := SaveAsAOCELetter);
end;

procedure TWordDoc.SaveAsPswrd(FileName: TFileName; ReadPswrd,
  WritePswrd: string);
begin
  SaveAsAttr(FileName,0,false,ReadPswrd,false,WritePswrd,false,true,
    true,false,false);
end;

procedure TWordDoc.Select;
begin
  if Exists then OleObj.Select;
end;

{ TWordDocs }

function TWordDocs.Add(TemplateName: TFileName): TWordDoc;
begin
  if TemplateName <> '' then
    FDoc.OleObj := OleObj.Add(TemplateName)
  else
    FDoc.OleObj := OleObj.Add;
  Result := FDoc;
end;

function TWordDocs.GetCount: integer;
begin
  if Exists then
    Result := OleObj.Count
  else
    Result := 0;
end;

procedure TWordDocs.Close;
begin
  if Exists then OleObj.Close(false);
end;

constructor TWordDocs.Create(AParent: TOleObject);
begin
  inherited;
  FDoc := TWordDoc.Create(Self);
end;

destructor TWordDocs.Destroy;
begin
  FDoc.Free;
  inherited;
end;

function TWordDocs.DoGetOleObj: OleVariant;
begin
  if ParentExists then
    Result := Parent.OleObj.Documents
  else
    VarClear(Result);
end;

procedure TWordDocs.DoSetOleObj(AOleObj: OleVariant);
begin
  inherited;
end;

function TWordDocs.GetItem(Index: integer): TWordDoc;
begin
  if (Index > 0) and (Index <= Count) then
    FDoc.OleObj := OleObj.Item(Index)
  else
    FDoc.Index := -1;
  Result := FDoc;
end;

end.
