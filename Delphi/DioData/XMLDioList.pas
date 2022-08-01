
{*******************************************************************************************************}
{                                                                                                       }
{                                           XML Data Binding                                            }
{                                                                                                       }
{         Generated on: 22.12.2009 23:54:22                                                             }
{       Generated from: C:\Users\b1ind\Documents\RAD Studio\Projects\Test Project\DioMngr\DioList.xml   }
{   Settings stored in: C:\Users\b1ind\Documents\RAD Studio\Projects\Test Project\DioMngr\DioList.xdb   }
{                                                                                                       }
{*******************************************************************************************************}

unit XMLDioList;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLDioList = interface;
  IXMLDioInfo = interface;
  IXMLDataFile = interface;

{ IXMLDioList }

  IXMLDioList = interface(IXMLNodeCollection)
    ['{4B696B95-6683-4688-A5C1-F593E6D7EC3C}']
    { Property Accessors }
    function Get_Name: string;
    function Get_Version: Integer;
    function Get_DioInfo(Index: Integer): IXMLDioInfo;
    procedure Set_Name(Value: string);
    procedure Set_Version(Value: Integer);
    { My Methods & Properties }
    function Add(ANumber: integer; AAddress, ADioOwner: string; AInfo1: string = '';
      AInfo2: string = ''): IXMLDioInfo; overload;
    function HasDioInfo(const Number: integer): boolean;
    function GetDioInfoByNumber(const Number: integer): IXMLDioInfo;
    { Methods & Properties }
    function Add: IXMLDioInfo; overload;
    function Insert(const Index: Integer): IXMLDioInfo;
    property Name: string read Get_Name write Set_Name;
    property Version: Integer read Get_Version write Set_Version;
    property DioInfo[Index: Integer]: IXMLDioInfo read Get_DioInfo; default;
  end;

{ IXMLDioInfo }

  IXMLDioInfo = interface(IXMLNodeCollection)
    ['{BF4F01D4-F94C-4112-B5DD-86CDD0D2C5FD}']
    { Property Accessors }
    function Get_Number: Integer;
    function Get_NumberAsStr: string;
    function Get_Address: string;
    function Get_DioOwner: string;
    function Get_Info1: string;
    function Get_Info2: string;
    function Get_DataFile(Index: Integer): IXMLDataFile;
    procedure Set_Number(Value: Integer);
    procedure Set_NumberAsStr(Value: string);
    procedure Set_Address(Value: string);
    procedure Set_DioOwner(Value: string);
    procedure Set_Info1(Value: string);
    procedure Set_Info2(Value: string);
    { Methods & Properties }
    function Add: IXMLDataFile;
    function Insert(const Index: Integer): IXMLDataFile;
    function GetCaption(Mask: string): string;
    property Number: Integer read Get_Number write Set_Number;
    property NumberAsStr: string read Get_NumberAsStr write Set_NumberAsStr;
    property Address: string read Get_Address write Set_Address;
    property DioOwner: string read Get_DioOwner write Set_DioOwner;
    property Info1: string read Get_Info1 write Set_Info1;
    property Info2: string read Get_Info2 write Set_Info2;
    property DataFile[Index: Integer]: IXMLDataFile read Get_DataFile; default;
  end;

{ IXMLDataFile }

  IXMLDataFile = interface(IXMLNode)
    ['{9261A6B2-82BE-4FE3-B333-BF637AA3EEDF}']
    { Property Accessors }
    function Get_FileName: string;
    function Get_DioDate: TDateTime;
    function Get_DioType: Byte;
    function Get_ArcType: Byte;
    procedure Set_FileName(Value: string);
    procedure Set_DioDate(Value: TDateTime);
    procedure Set_DioType(Value: Byte);
    procedure Set_ArcType(Value: Byte);
    { Methods & Properties }
    property FileName: string read Get_FileName write Set_FileName;
    property DioDate: TDateTime read Get_DioDate write Set_DioDate;
    property DioType: Byte read Get_DioType write Set_DioType;
    property ArcType: Byte read Get_ArcType write Set_ArcType;
  end;

{ Forward Decls }

  TXMLDioList = class;
  TXMLDioInfo = class;
  TXMLDataFile = class;

{ TXMLDioList }

  TXMLDioList = class(TXMLNodeCollection, IXMLDioList)
  protected
    { IXMLDioList }
    function Get_Name: string;
    function Get_Version: Integer;
    function Get_DioInfo(Index: Integer): IXMLDioInfo;
    procedure Set_Name(Value: string);
    procedure Set_Version(Value: Integer);
    function Add: IXMLDioInfo; overload;
    function Insert(const Index: Integer): IXMLDioInfo;
  public
    procedure AfterConstruction; override;
    { My Methods & Properties }
    function Add(ANumber: integer; AAddress, ADioOwner: string; AInfo1: string = '';
      AInfo2: string = ''): IXMLDioInfo; overload;
    function HasDioInfo(const Number: integer): boolean;
    function GetDioInfoByNumber(const Number: integer): IXMLDioInfo;
  end;

{ TXMLDioInfo }

  TXMLDioInfo = class(TXMLNodeCollection, IXMLDioInfo)
  protected
    { IXMLDioInfo }
    function Get_Number: Integer;
    function Get_NumberAsStr: string;
    function Get_Address: string;
    function Get_DioOwner: string;
    function Get_Info1: string;
    function Get_Info2: string;
    function Get_DataFile(Index: Integer): IXMLDataFile;
    procedure Set_Number(Value: Integer);
    procedure Set_NumberAsStr(Value: string);
    procedure Set_Address(Value: string);
    procedure Set_DioOwner(Value: string);
    procedure Set_Info1(Value: string);
    procedure Set_Info2(Value: string);
    function Add: IXMLDataFile;
    function Insert(const Index: Integer): IXMLDataFile;
    function GetCaption(Mask: string): string;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDataFile }

  TXMLDataFile = class(TXMLNode, IXMLDataFile)
  protected
    { IXMLDataFile }
    function Get_FileName: string;
    function Get_DioDate: TDateTime;
    function Get_DioType: Byte;
    function Get_ArcType: Byte;
    procedure Set_FileName(Value: string);
    procedure Set_DioDate(Value: TDateTime);
    procedure Set_DioType(Value: Byte);
    procedure Set_ArcType(Value: Byte);
  end;

{ Global Functions }

function GetDioList(Doc: IXMLDocument): IXMLDioList;
function LoadDioList(const FileName: string): IXMLDioList;
function NewDioList: IXMLDioList;
function DeleteXMLNode(XMLNode: IXMLNode): boolean;
procedure FreeDioList(DioList: IXMLDioList);

const
  TargetNamespace = '';

implementation

uses SysUtils, Variants, MyXMLUtils;

{ Global Functions }

function GetDioList(Doc: IXMLDocument): IXMLDioList;
begin
  Result := Doc.GetDocBinding('DioList', TXMLDioList, TargetNamespace) as IXMLDioList;
end;

function LoadDioList(const FileName: string): IXMLDioList;
var
  IXMLDoc: IXMLDocument;
begin
  IXMLDoc := LoadXMLDocument(FileName);
  IXMLDoc.Options := IXMLDoc.Options + [doAutoSave];
  Result := IXMLDoc.GetDocBinding('DioList', TXMLDioList, TargetNamespace) as IXMLDioList;
end;

function NewDioList: IXMLDioList;
begin
  Result := NewXMLDocument.GetDocBinding('DioList', TXMLDioList, TargetNamespace) as IXMLDioList;
end;

function DeleteXMLNode(XMLNode: IXMLNode): boolean;
begin
  Result := false;
  if (XMLNode = nil) or (XMLNode.ParentNode = nil) then Exit;
  Result := XMLNode.ParentNode.ChildNodes.Remove(XMLNode) > -1;
end;


procedure FreeDioList(DioList: IXMLDioList);
begin
  TXMLDocument(DioList.OwnerDocument).Free;
end;

{ TXMLDioList }

function TXMLDioList.Add(ANumber: integer; AAddress, ADioOwner, AInfo1,
  AInfo2: string): IXMLDioInfo;
begin
  if not HasDioInfo(ANumber) then
  begin
    Result := Add;
    if Result <> nil then
      with Result do
      begin
        Number := ANumber;
        Address := AAddress;
        DioOwner := ADioOwner;
        Info1 := AInfo1;
        Info2 := AInfo2;
      end;
  end else
    Result := nil;
end;

procedure TXMLDioList.AfterConstruction;
begin
  RegisterChildNode('DioInfo', TXMLDioInfo);
  ItemTag := 'DioInfo';
  ItemInterface := IXMLDioInfo;
  inherited;
end;

function TXMLDioList.Get_Name: string;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TXMLDioList.Set_Name(Value: string);
begin
  SetAttribute('Name', Value);
end;

function TXMLDioList.Get_Version: Integer;
begin
  Result := AttributeNodes['version'].NodeValue;
end;

function TXMLDioList.HasDioInfo(const Number: integer): boolean;
begin
  Result := GetDioInfoByNumber(Number) <> nil;
end;

procedure TXMLDioList.Set_Version(Value: Integer);
begin
  SetAttribute('version', Value);
end;

function TXMLDioList.GetDioInfoByNumber(const Number: integer): IXMLDioInfo;
begin
  Result := (FindChildByAttr(Self,'Number',Number) as IXMLDioInfo);
end;

function TXMLDioList.Get_DioInfo(Index: Integer): IXMLDioInfo;
begin
  Result := List[Index] as IXMLDioInfo;
end;

function TXMLDioList.Add: IXMLDioInfo;
begin
  Result := AddItem(-1) as IXMLDioInfo;
end;

function TXMLDioList.Insert(const Index: Integer): IXMLDioInfo;
begin
  Result := AddItem(Index) as IXMLDioInfo;
end;

{ TXMLDioInfo }

procedure TXMLDioInfo.AfterConstruction;
begin
  RegisterChildNode('DataFile', TXMLDataFile);
  ItemTag := 'DataFile';
  ItemInterface := IXMLDataFile;
  inherited;
end;

function TXMLDioInfo.Get_Number: Integer;
begin
  Result := AttributeNodes['Number'].NodeValue;
end;

function TXMLDioInfo.Get_NumberAsStr: string;
begin
  Result := IntToStr(Get_Number);
end;

procedure TXMLDioInfo.Set_Number(Value: Integer);
begin
  SetAttribute('Number', Value);
end;

procedure TXMLDioInfo.Set_NumberAsStr(Value: string);
begin
  Set_Number(StrToIntDef(Value,0));
end;

function TXMLDioInfo.GetCaption(Mask: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(Mask) do
    case Mask[i] of
      'n': Result := Result + Get_NumberAsStr;
      'a': Result := Result + Get_Address;
      'o': Result := Result + Get_DioOwner;
      '1': Result := Result + Get_Info1;
      '2': Result := Result + Get_Info2;
    else
      Result := Result + Mask[i];
    end;
end;

function TXMLDioInfo.Get_Address: string;
begin
  Result := AttributeNodes['Address'].Text;
end;

procedure TXMLDioInfo.Set_Address(Value: string);
begin
  SetAttribute('Address', Value);
end;

function TXMLDioInfo.Get_DioOwner: string;
begin
  Result := AttributeNodes['DioOwner'].Text;
end;

procedure TXMLDioInfo.Set_DioOwner(Value: string);
begin
  SetAttribute('DioOwner', Value);
end;

function TXMLDioInfo.Get_Info1: string;
begin
  Result := AttributeNodes['Info1'].Text;
end;

procedure TXMLDioInfo.Set_Info1(Value: string);
begin
  SetAttribute('Info1', Value);
end;

function TXMLDioInfo.Get_Info2: string;
begin
  Result := AttributeNodes['Info2'].Text;
end;

procedure TXMLDioInfo.Set_Info2(Value: string);
begin
  SetAttribute('Info2', Value);
end;

function TXMLDioInfo.Get_DataFile(Index: Integer): IXMLDataFile;
begin
  Result := List[Index] as IXMLDataFile;
end;

function TXMLDioInfo.Add: IXMLDataFile;
begin
  Result := AddItem(-1) as IXMLDataFile;
end;

function TXMLDioInfo.Insert(const Index: Integer): IXMLDataFile;
begin
  Result := AddItem(Index) as IXMLDataFile;
end;

{ TXMLDataFile }

function TXMLDataFile.Get_FileName: string;
begin
  Result := AttributeNodes['FileName'].Text;
end;

procedure TXMLDataFile.Set_FileName(Value: string);
begin
  SetAttribute('FileName', Value);
end;

function TXMLDataFile.Get_DioDate: TDateTime;
begin
  Result := VarToDateTime(AttributeNodes['DioDate'].NodeValue);
end;

procedure TXMLDataFile.Set_DioDate(Value: TDateTime);
begin
  SetAttribute('DioDate', Value);
end;

function TXMLDataFile.Get_DioType: Byte;
begin
  Result := AttributeNodes['DioType'].NodeValue;
end;

procedure TXMLDataFile.Set_DioType(Value: Byte);
begin
  SetAttribute('DioType', Value);
end;

function TXMLDataFile.Get_ArcType: Byte;
begin
  Result := AttributeNodes['ArcType'].NodeValue;
end;

procedure TXMLDataFile.Set_ArcType(Value: Byte);
begin
  SetAttribute('ArcType', Value);
end;

end.