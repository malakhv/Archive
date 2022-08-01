unit MyProgOpt;

interface

uses SysUtils, Classes, MyClasses, MyXML, XMLIntf, XMLDoc, MyXMLNode;

type

  TXMLOptions = class(TCustomXMLFile)
  private
    FOptionsNode: TXMLNodeObject;
    function GetOption(OptionName: string): OleVariant;
    procedure SetOption(OptionName: string; const Value: OleVariant);
    procedure SetOptionsNode(const Value: TXMLNodeObject);
  public
    property OptionsNode: TXMLNodeObject read FOptionsNode write SetOptionsNode;
    property Option[OptionName: string]: OleVariant read GetOption write SetOption;
    constructor Create; override;
    destructor Destroy; override;
  end;

type

  TCustomProgOptions = class(TCustomFileObject)
  private
    FXMLDoc: TXMLDocument;
    EObjCreate: boolean;
    FNodeOpt: TXMLNodeObject;
    procedure SetXMLDoc(const Value: TXMLDocument);
    function GetNodeOptName: string;
    procedure SetNodeOpt(const Value: TXMLNodeObject);
    procedure SetNodeOptName(const Value: string);
    function GetOption(OptName: string): OleVariant;
    procedure SetOption(OptName: string; const Value: OleVariant);
  protected
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
  public
    property NodeOpt: TXMLNodeObject read FNodeOpt write SetNodeOpt;
    property NodeOptName: string read GetNodeOptName write SetNodeOptName;
    property Option[OptName: string]: OleVariant read GetOption write SetOption;
    property XMLDoc: TXMLDocument read FXMLDoc write SetXMLDoc;
    constructor Create; override;
    constructor CerateAssign(AXMLDoc: TXMLDocument); reintroduce; overload;
    constructor CreateXML(AOwner: TComponent; AFileName: TFileName = '');
    destructor Destroy; override;
  end;

implementation


{ TProgOptions }

constructor TCustomProgOptions.CerateAssign(AXMLDoc: TXMLDocument);
begin
  Create;
  XMLDoc := AXMLDoc;
end;

constructor TCustomProgOptions.CreateXML(AOwner: TComponent; AFileName: TFileName);
begin
  Create;
  FXMLDoc := TXMLDocument.Create(AOwner);
  FXMLDoc.Options := [doAttrNull, doAutoSave];
  if AFileName <> '' then FileName := AFileName;
end;

constructor TCustomProgOptions.Create;
begin
  inherited;
  FNodeOpt := TXMLNodeObject.Create(nil);
  EObjCreate := false;
end;

destructor TCustomProgOptions.Destroy;
begin
  if EObjCreate then FXMLDoc.Free;
  inherited;
end;

function TCustomProgOptions.DoLoadFromFile(const AFileName: TFileName): boolean;
begin
  XMLDoc.LoadFromFile(AFileName);
  Result := true;
end;

function TCustomProgOptions.DoSaveToFile(const AFileName: TFileName): boolean;
begin
  XMLDoc.SaveToFile(AFileName);
  Result := true;
end;

function TCustomProgOptions.GetNodeOptName: string;
begin
  if NodeOpt.Exists then
    Result := NodeOpt.XMLNode.NodeName
  else
    Result := '';
end;

function TCustomProgOptions.GetOption(OptName: string): OleVariant;
begin
  Result := NodeOpt.ChildValue[OptName];
end;

procedure TCustomProgOptions.SetNodeOpt(const Value: TXMLNodeObject);
begin
  FNodeOpt := Value;
end;

procedure TCustomProgOptions.SetNodeOptName(const Value: string);
begin
  NodeOpt.XMLNode := FindNode(XMLDoc.ChildNodes.First,Value);
end;

procedure TCustomProgOptions.SetOption(OptName: string; const Value: OleVariant);
begin
  NodeOpt.ChildValue[OptName] := Value;
end;

procedure TCustomProgOptions.SetXMLDoc(const Value: TXMLDocument);
begin
  if EObjCreate then
    FXMLDoc.Assign(Value)
  else
    FXMLDoc := Value;
end;

{ TXMLOptions }

constructor TXMLOptions.Create;
begin
  inherited;
  //FOptionsNode := TXMLNodeObject.Create(nil);
end;

destructor TXMLOptions.Destroy;
begin
  //FOptionsNode.Free;
  inherited;
end;

function TXMLOptions.GetOption(OptionName: string): OleVariant;
begin
  Result := OptionsNode.ChildValue[OptionName];
end;

procedure TXMLOptions.SetOption(OptionName: string; const Value: OleVariant);
begin
  OptionsNode.ChildValue[OptionName] := Value;
end;

procedure TXMLOptions.SetOptionsNode(const Value: TXMLNodeObject);
begin
  if Value <> nil then
    FOptionsNode.Assign(Value);
end;

end.
