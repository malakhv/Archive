unit WordObj;

interface

uses SysUtils, Classes,  MyOleObj;

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


type

  TWordRange = class(TParOleObject)
  protected
    procedure DoSetParent(AParent: TBaseOleObject); override;
  public
    procedure Copy;
    procedure Cut;
    procedure Paste;
    procedure InsertBefor(Str: string);
    procedure InsertAfter(Str: string);
    procedure Select;
    procedure SetRange(RStart,REnd: integer);
    constructor Create(AParent: TBaseOleObject); override;
  end;

type

  TWordDocument = class(TBaseOleObject)
  private
    FRange: TWordRange;
    function GetDocName: string;
  protected
    procedure UpdateObject;
  public
    property DocName: string read GetDocName;
    property Range: TWordRange read FRange;
    function SaveAsAttr(FileName: TFileName; FileFormat: integer = 0;
      LockComments: boolean = false; Password: string = '';
      AddToRecentFiles: boolean = true; WritePassword: string = '';
      ReadOnlyRecommended: boolean = false; EmbedTrueTypeFonts: boolean = true;
      SaveNativePictureFormat: boolean = true; SaveFormsData: boolean = false;
      SaveAsAOCELetter: boolean = false): boolean;
    function SaveAs(FileName: TFileName; FileFormat: integer = 0): boolean;
    function SaveAsPswrd(FileName: TFileName; ReadPswrd, WritePswrd: string): boolean;
    procedure Activate;
    procedure Select;
    constructor Create(AOleObject: Variant); reintroduce;
    destructor Destroy; override;
  end;

type

  TWordDocuments = class(TParOleObject)
  private
    FDoc: TWordDocument;
    function GetCount: integer;
    function GetItem(i: integer): TWordDocument;
  public
    property Item[i: integer]: TWordDocument read GetItem;
    property DocCount: integer read GetCount;
    function Add(TemplateName: TFileName = ''): Variant;
    function OpenAttr(FileName: TFileName; ConfirmConversions: boolean = false;
      ReadOnly: boolean = false; AddToRecentFiles: boolean = true;
      PasswordDocument: string = ''; PasswordTemplate: string = '';
      Revert: boolean = false; WritePasswordDocument: string = '';
      WritePasswordTemplate: string = ''; Format: integer = WdOpenFormatAuto): Variant;
    function Open(FileName: TFileName): Variant;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AParent: TBaseOleObject); override;
    destructor Destroy; override;
  end;

  TWordApplication = class(TBaseOleObject)
  private
    FDocuments: TWordDocuments;
    FActiveDoc: TWordDocument;
    FQuitOnFree: boolean;
    function CreateWordObject: boolean;
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    procedure SetDocuments(const Value: TWordDocuments);
    function GetActiveDoc: TWordDocument;
  public
    property ActiveDoc: TWordDocument read GetActiveDoc;
    property QuitOnFree: boolean read FQuitOnFree write FQuitOnFree;
    property Visible: boolean read GetVisible write SetVisible;
    property Documents: TWordDocuments read FDocuments write SetDocuments;
    function GetDocObj: Variant;
    procedure Open;
    procedure Quit;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AutoCreate: boolean = false); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses ComObj;

const
  WORD_APP = 'Word.Application';

{ TRange }

procedure TWordRange.Copy;
begin
  if Exists then OleObject.Copy;
end;

constructor TWordRange.Create(AParent: TBaseOleObject);
begin
  inherited;
  if Parent <> nil then
    if Parent.Exists then
      OleObject := Parent.OleObject.Range;
end;

procedure TWordRange.Cut;
begin
  if Exists then OleObject.Cut;
end;

procedure TWordRange.DoSetParent(AParent: TBaseOleObject);
begin
  inherited;
  if Parent <> nil then
    if Parent.Exists then
      OleObject := Parent.OleObject.Range;
end;

procedure TWordRange.InsertAfter(Str: string);
begin
  if Exists then OleObject.InsertAfter(Str);
end;

procedure TWordRange.InsertBefor(Str: string);
begin
  if Exists then OleObject.InsertBefor(Str);
end;

procedure TWordRange.Paste;
begin
  if Exists then OleObject.Paste;
end;

procedure TWordRange.Select;
begin
  if Exists then OleObject.Select;
end;

procedure TWordRange.SetRange(RStart, REnd: integer);
begin

end;

{ TWordDocument }

procedure TWordDocument.Activate;
begin
  if Exists then OleObject.Activate;
end;

constructor TWordDocument.Create(AOleObject: Variant);
begin
  inherited Create;
  FRange := TWordRange.Create(nil);
  if Exists then UpdateObject;
end;

destructor TWordDocument.Destroy;
begin
  FRange.Free;
  inherited;
end;

function TWordDocument.GetDocName: string;
begin
  if Exists then
    Result := OleObject.Name
  else
    Result := '';
end;

function TWordDocument.SaveAs(FileName: TFileName; FileFormat: integer): boolean;
begin
  Result := SaveAsAttr(FileName,FileFormat);
end;

function TWordDocument.SaveAsAttr(FileName: TFileName; FileFormat: integer; LockComments: boolean;
  Password: string; AddToRecentFiles: boolean; WritePassword: string; ReadOnlyRecommended,
  EmbedTrueTypeFonts, SaveNativePictureFormat, SaveFormsData, SaveAsAOCELetter: boolean): boolean;
begin
  Result := true;
  try
    OleObject.SaveAs(FileName := FileName, FileFormat := FileFormat,
      LockComments := LockComments, Password := Password,
      AddToRecentFiles := AddToRecentFiles, WritePassword := WritePassword,
      ReadOnlyRecommended := ReadOnlyRecommended,
      EmbedTrueTypeFonts := EmbedTrueTypeFonts,
      SaveNativePictureFormat := SaveNativePictureFormat,
      SaveFormsData := SaveFormsData, SaveAsAOCELetter := SaveAsAOCELetter);
  except
    Result := false;
  end;
end;

function TWordDocument.SaveAsPswrd(FileName: TFileName; ReadPswrd, WritePswrd: string): boolean;
begin
  Result := SaveAsAttr(FileName, 0, true, ReadPswrd, false, WritePswrd, false, false, false,
    false, false);
end;

procedure TWordDocument.Select;
begin
  if Exists then OleObject.Select;
end;

procedure TWordDocument.UpdateObject;
begin
  FRange.Parent := Self;
end;

{ TDocuments }

function TWordDocuments.Add(TemplateName: TFileName): Variant;
begin
  try
    if Trim(TemplateName) = '' then
      Result := OleObject.Add
    else
      Result := OleObject.Add(TemplateName);
  except
    VarClear(Result);
  end;
end;

procedure TWordDocuments.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TWordDocuments then
    FDoc.Assign( (Source as TWordDocuments).FDoc );
end;

constructor TWordDocuments.Create(AParent: TBaseOleObject);
begin
  inherited;
  if Parent <> nil then
    if Parent.Exists then
      OleObject := Parent.OleObject.Documents;
  FDoc := TWordDocument.Create(VarEmpty);
end;

destructor TWordDocuments.Destroy;
begin
  inherited;
end;

function TWordDocuments.GetCount: integer;
begin
  try
    Result := OleObject.Count;
  except
    Result := -1;
  end;
end;

function TWordDocuments.GetItem(i: integer): TWordDocument;
begin
  try
    FDoc.OleObject := Self.OleObject.Item(i + 1);
    Result := FDoc;
  except
    Result := nil;
  end;
end;

function TWordDocuments.Open(FileName: TFileName): Variant;
begin
  Result := OpenAttr(FileName);
end;

function TWordDocuments.OpenAttr(FileName: TFileName; ConfirmConversions, ReadOnly,
  AddToRecentFiles: boolean; PasswordDocument, PasswordTemplate: string; Revert: boolean;
  WritePasswordDocument, WritePasswordTemplate: string; Format: integer): Variant;
begin
  try
    Result := OleObject.Open(FileName := FileName,
      ConfirmConversions := ConfirmConversions, ReadOnly := ReadOnly,
      AddToRecentFiles := AddToRecentFiles, PasswordDocument := Trim(PasswordDocument),
      PasswordTemplate := Trim(PasswordTemplate), Revert := Revert,
      WritePasswordDocument := Trim(WritePasswordDocument),
      WritePasswordTemplate := Trim(WritePasswordTemplate), Format := Format);
  except
    VarClear(Result);
  end;
end;

{ TWordApplication }

constructor TWordApplication.Create(AutoCreate: boolean);
begin
  inherited Create;
  if AutoCreate then CreateWordObject;
  FDocuments := TWordDocuments.Create(Self);
  FActiveDoc := TWordDocument.Create(varEmpty);
  FQuitOnFree := false;
end;

destructor TWordApplication.Destroy;
begin
  if FQuitOnFree then Quit;
  FDocuments.Free;
  Clear;
  inherited;
end;

function TWordApplication.CreateWordObject: boolean;
begin
  Result := true;
  if Exists then Clear;
  try
    OleObject := CreateOleObject(WORD_APP);
  except
    Result := false;
  end;
end;

procedure TWordApplication.Quit;
begin
  if Exists then OleObject.Quit;
  Clear;
end;

function TWordApplication.GetActiveDoc: TWordDocument;
begin
  FActiveDoc.Clear;
  try
    FActiveDoc.OleObject := Self.OleObject.ActiveDocument;
    Result := FActiveDoc;
  except
    Result := nil;
  end;
end;

function TWordApplication.GetDocObj: Variant;
begin
  try
    Result := OleObject.Documents;
  except
    VarClear(Result);
  end;
end;

function TWordApplication.GetVisible: boolean;
begin
  try
    Result := OleObject.Visible;
  except
    Result := false;
  end;
end;

procedure TWordApplication.SetVisible(const Value: boolean);
begin
  if Exists then
    OleObject.Visible := Value;
end;

procedure TWordApplication.Open;
begin
  CreateWordObject;
end;

procedure TWordApplication.SetDocuments(const Value: TWordDocuments);
begin
  if Assigned(Value) then
    FDocuments.Assign(Value);
end;

procedure TWordApplication.Assign(Source: TPersistent);
begin
  FDocuments.Assign(TWordApplication(Source).Documents);
  inherited;
end;


end.
