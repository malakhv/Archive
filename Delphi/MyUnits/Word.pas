unit Word;

interface

uses SysUtils, Classes;

const
  OLE_NO_ERROR        = 0;
  OLE_CREATEOBJ_ERROR = 1;
  OLE_PROPERTY_ERROR  = 2;
  OLE_METHOD_ERROR    = 3;
  OLE_OWNERDONTEXISTS = 4;
  OLE_SETOBJECT_ERROR = 5;

const
  COUNT_ERROR = -1;

type
  TObjectName = string[255];
  TDocName    = string[255];

type
  TBaseObject = class(TPersistent)
  private
    FName: TObjectName;
    FLastError: integer;
    FOleObject: Variant;
    procedure SetName(const Value: TObjectName);
    procedure SetOleObject(const Value: Variant);
  protected
    procedure DoSetOleObject(Value: Variant); virtual;
    procedure SetLastError(ErrorCode: integer); virtual;
    procedure ClearError;
    procedure ClearObj;
  public
    property Name: TObjectName read FName write SetName;
    property OleObject: Variant read FOleObject write SetOleObject;
    function Exists: boolean; virtual;
    function GetLastError: integer; virtual;
    procedure Assign(Source: TPersistent);override;
    procedure Clear; virtual;
    constructor Create;
    destructor Destroy; override;
  end;

const
  // Форматы сохранения файла
  WdFormatDocument          = 0;
  WdFormatTemplate          = 1;
  WdFormatText              = 2;
  WdFormatTextLineBreaks    = 3;
  WdFormatDOSText           = 4;
  WdFormatDOSTextLineBreaks = 5;
  WdFormatRTF               = 6;
  WdFormatUnicodeText       = 7;

type
  TDocument = class(TBaseObject)
  private
    function GetSaved: Variant;
    function GetDocName: TDocName;
  public
    property Saved: Variant read GetSaved;
    property DocName: TDocName read GetDocName;
    procedure SaveAsAttr(FileName: TFileName; FileFormat: integer = 0;
      LockComments: boolean = false; Password: string = '';
      AddToRecentFiles: boolean = true; WritePassword: string = '';
      ReadOnlyRecommended: boolean = false; EmbedTrueTypeFonts: boolean = true;
      SaveNativePictureFormat: boolean = true; SaveFormsData: boolean = false;
      SaveAsAOCELetter: boolean = false);
    procedure SaveAs(FileName: TFileName; FileFormat: integer = 0);
    procedure Save;
    procedure Activate;
    procedure Select;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOleObject: Variant);
  end;

const
  // Форматы открываемых файлов
  WdOpenFormatAuto          = 0;
  WdOpenFormatDocument      = 1;
  WdOpenFormatRTF           = 3;
  WdOpenFormatTemplate      = 2;
  WdOpenFormatText          = 4;
  WdOpenFormatUnicodeText   = 5;

type

  TWordApplication = class;

  TDocuments = class(TBaseObject)
  private
    FDoc: TDocument;
    function GetCount: integer;
    function GetItem(i: integer): TDocument;
  public
    property Item[i: integer]: TDocument read GetItem;
    property DocCount: integer read GetCount;
    function Add(TemplateName: TFileName = ''): Variant;
    function OpenAttr(FileName: TFileName; ConfirmConversions: boolean = false;
      ReadOnly: boolean = false; AddToRecentFiles: boolean = true;
      PasswordDocument: string = ''; PasswordTemplate: string = '';
      Revert: boolean = false; WritePasswordDocument: string = '';
      WritePasswordTemplate: string = ''; Format: integer = WdOpenFormatAuto): Variant;
    function Open(FileName: TFileName): Variant;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TWordApplication);
    destructor Destroy; override;
  end;

  TWordApplication = class(TBaseObject)
  private
    FDocuments: TDocuments;
    FActiveDoc: TDocument;
    FQuitOnFree: boolean;
    function CreateWordObject: boolean;
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    procedure SetDocuments(const Value: TDocuments);
    function GetActiveDoc: TDocument;
  public
    property ActiveDoc: TDocument read GetActiveDoc;
    property QuitOnFree: boolean read FQuitOnFree write FQuitOnFree;
    property Visible: boolean read GetVisible write SetVisible;
    property Documents: TDocuments read FDocuments write SetDocuments;
    function GetDocObj: Variant;
    procedure Open;
    procedure Quit;
    procedure Assign(Source: TPersistent); override;
    constructor Create(AutoCreate: boolean = false);
    destructor Destroy; override;
  end;

implementation

uses Variants, ComObj;

{ TBaseObject }

constructor TBaseObject.Create;
begin
  inherited Create;
  Clear;
end;

destructor TBaseObject.Destroy;
begin
  Clear;
  inherited;
end;

procedure TBaseObject.DoSetOleObject(Value: Variant);
begin
  Clear;
  if VarIsType(Value,varDispatch) then
    FOleObject := Value
  else
    SetLastError(OLE_SETOBJECT_ERROR);
end;

function TBaseObject.Exists: boolean;
begin
  Result := not VarIsEmpty(FOleObject);
end;

function TBaseObject.GetLastError: integer;
begin
  Result := FLastError;
end;

procedure TBaseObject.SetLastError(ErrorCode: integer);
begin
  FLastError := ErrorCode;
end;

procedure TBaseObject.SetName(const Value: TObjectName);
begin
  FName := Trim(Value);
end;

procedure TBaseObject.SetOleObject(const Value: Variant);
begin
  DoSetOleObject(Value);
end;

procedure TBaseObject.ClearError;
begin
  SetLastError(OLE_NO_ERROR);
end;

procedure TBaseObject.Clear;
begin
  ClearObj;
  ClearError;
end;

procedure TBaseObject.ClearObj;
begin
  VarClear(FOleObject);
end;

procedure TBaseObject.Assign(Source: TPersistent);
begin
  FName := TBaseObject(Source).Name;
  FOleObject := TBaseObject(Source).OleObject;
  inherited Assign(Source);
end;

{ TDocuments }

constructor TDocuments.Create(AOwner: TWordApplication);
begin
  inherited Create;
  OleObject := AOwner.GetDocObj;
  FDoc := TDocument.Create(VarEmpty);
end;

procedure TDocuments.Assign(Source: TPersistent);
begin
  inherited;
end;

destructor TDocuments.Destroy;
begin
  inherited;
end;

function TDocuments.GetCount: integer;
begin
  ClearError;
  try
    Result := OleObject.Count;
  except
    Result := COUNT_ERROR;
  end;
    SetLastError(OLE_PROPERTY_ERROR);
end;

function TDocuments.GetItem(i: integer): TDocument;
begin
  try
    FDoc.OleObject := Self.OleObject.Item(i + 1);
    Result := FDoc;
  except
    SetLastError(OLE_PROPERTY_ERROR);
    Result := nil;
  end;
end;

function TDocuments.Add(TemplateName: TFileName): Variant;
begin
  ClearError;
  try
    if Trim(TemplateName) = '' then
      Result := OleObject.Add
    else
      Result := OleObject.Add(TemplateName);
  except
    VarClear(Result);
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

function TDocuments.OpenAttr(FileName: TFileName; ConfirmConversions, ReadOnly,
  AddToRecentFiles: boolean; PasswordDocument, PasswordTemplate: string;
  Revert: boolean; WritePasswordDocument: string; WritePasswordTemplate: string;
  Format: integer): Variant;
begin
  ClearError;
  try
    Result := OleObject.Open(FileName := FileName,
      ConfirmConversions := ConfirmConversions, ReadOnly := ReadOnly,
      AddToRecentFiles := AddToRecentFiles, PasswordDocument := Trim(PasswordDocument),
      PasswordTemplate := Trim(PasswordTemplate), Revert := Revert,
      WritePasswordDocument := Trim(WritePasswordDocument),
      WritePasswordTemplate := Trim(WritePasswordTemplate), Format := Format);
  except
    VarClear(Result);
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

function TDocuments.Open(FileName: TFileName): Variant;
begin
  Result := OpenAttr(FileName);
end;

{ TWordApplication }

const
  WORD_APP = 'Word.Application';

constructor TWordApplication.Create(AutoCreate: boolean);
begin
  inherited Create;
  if AutoCreate then
    CreateWordObject;
  FDocuments := TDocuments.Create(Self);
  FActiveDoc := TDocument.Create(varEmpty);
  FQuitOnFree := false;
end;

destructor TWordApplication.Destroy;
begin
  if FQuitOnFree then
    Self.Quit;
  FDocuments.Free;
  Self.Clear;
  inherited;
end;

function TWordApplication.CreateWordObject: boolean;
begin
  Result := true;
  if Self.Exists then
    Self.Clear;
  try
    Self.OleObject := CreateOleObject(WORD_APP);
  except
    Result := false;
    SetLastError(OLE_CREATEOBJ_ERROR);
  end;
end;

procedure TWordApplication.Quit;
begin
  ClearError;
  try
    Self.OleObject.Quit;
  except
    SetLastError(OLE_METHOD_ERROR);
  end;
  Self.ClearObj;
end;

function TWordApplication.GetActiveDoc: TDocument;
begin
  ClearError;
  FActiveDoc.Clear;
  try
    FActiveDoc.OleObject := Self.OleObject.ActiveDocument;
    FActiveDoc.Name      := Self.OleObject.ActiveDocument.Name;
  except
    SetLastError(OLE_PROPERTY_ERROR);
  end;
  Result := FActiveDoc;
end;

function TWordApplication.GetDocObj: Variant;
begin
  ClearError;
  try
    Result := Self.OleObject.Documents;
  except
    SetLastError(OLE_PROPERTY_ERROR);
    VarClear(Result);
  end;
end;

function TWordApplication.GetVisible: boolean;
begin
  ClearError;
  try
    Result := Self.OleObject.Visible;
  except
    Result := false;
    SetLastError(OLE_PROPERTY_ERROR);
  end;
end;

procedure TWordApplication.SetVisible(const Value: boolean);
begin
  ClearError;
  try
    Self.OleObject.Visible := Value;
  except
    SetLastError(OLE_PROPERTY_ERROR);
  end;
end;

procedure TWordApplication.Open;
begin
  CreateWordObject;
end;

procedure TWordApplication.SetDocuments(const Value: TDocuments);
begin
  if Assigned(Value) then
    FDocuments.Assign(Value);
end;

procedure TWordApplication.Assign(Source: TPersistent);
begin
  FDocuments.Assign(TWordApplication(Source).Documents);
  inherited;
end;

{ TDocument }

procedure TDocument.Activate;
begin
  ClearError;
  try
    OleObject.Activate;
  except
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

procedure TDocument.Assign(Source: TPersistent);
begin
  FOleObject := (Source as TDocument).OleObject;
  FName      := (Source as TDocument).Name;
  FLastError := (Source as TDocument).GetLastError;
  inherited;
end;

constructor TDocument.Create(AOleObject: Variant);
begin
  inherited Create;
  OleObject := AOleObject;
end;

function TDocument.GetDocName: TDocName;
begin
  ClearError;
  try
    Result := OleObject.Name;
  except
    SetLastError(OLE_PROPERTY_ERROR);
  end;
end;

function TDocument.GetSaved: Variant;
begin
  ClearError;
  VarClear(Result);
  try
    Result := Self.OleObject.Saved;
  except
    SetLastError(OLE_PROPERTY_ERROR);
  end;
end;

procedure TDocument.Save;
begin
  ClearError;
  try
    OleObject.Save;
  finally
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

procedure TDocument.SaveAsAttr(FileName: TFileName; FileFormat: integer;
  LockComments: boolean; Password: string; AddToRecentFiles: boolean;
  WritePassword: string; ReadOnlyRecommended, EmbedTrueTypeFonts,
  SaveNativePictureFormat, SaveFormsData, SaveAsAOCELetter: boolean);
begin
  ClearError;
  try
    OleObject.SaveAs(FileName := FileName, FileFormat := FileFormat,
     LockComments := LockComments, Password := Password,
     AddToRecentFiles := AddToRecentFiles, WritePassword := WritePassword,
     ReadOnlyRecommended := ReadOnlyRecommended,
     EmbedTrueTypeFonts := EmbedTrueTypeFonts,
     SaveNativePictureFormat := SaveNativePictureFormat,
     SaveFormsData := SaveFormsData, SaveAsAOCELetter := SaveAsAOCELetter);
  except
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

procedure TDocument.SaveAs(FileName: TFileName; FileFormat: integer);
begin
  ClearError;
  try
    OleObject.SaveAs(FileName := FileName, FileFormat := FileFormat);
  except
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

procedure TDocument.Select;
begin
  ClearError;
  try
    OleObject.Select;
  except
    SetLastError(OLE_METHOD_ERROR);
  end;
end;

end.
