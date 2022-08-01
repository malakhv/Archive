{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2010 itProject                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

{*******************************************************}
{               XML Document Work Unit                  }
{*******************************************************}

unit MyXML;

interface

uses

  SysUtils, Classes, XMLDoc, XMLIntf, MyClasses;

type

  { Forward Decls }

  IMyXMLNodeCollection = interface;
  IMyXMLNode = interface;

  { IMyXMLNodeCollection }

  IMyXMLNodeCollection = interface(IXMLNodeCollection)
    ['{48F8C58A-A49A-4A7E-90AB-9B7BB567CCD0}']
    { Methods & Properties }
    function Add: IMyXMLNode;
    function Insert(const Index: Integer): IMyXMLNode;
  end;

  { IMyXMLNode }

  IMyXMLNode = interface(IXMLNode)
    ['{B7FEABF2-8F85-41CC-B96D-CB21EF56AB3D}']
    { Property Accessors }
    function GetLevel: integer;
    { Methods & Properties }
    property Leavel: integer read GetLevel;
    function GetNextNode: IMyXMLNode;
    function FindChildByAttr(AttrName: string; AttrValue: OleVariant): IMyXMLNode;
  end;

  { Forward Decls }

  TMyXMLNodeCollection = class;
  TMyXMLNode = class;

  TMyXMLNodeCollection = class(TXMLNodeCollection, IMyXMLNodeCollection)
  protected
    { IMyXMLNodeCollection }
    function Add: IMyXMLNode;
    function Insert(const Index: Integer): IMyXMLNode;
  public
    procedure AfterConstruction; override;
  end;

  TMyXMLNode = class(TXMLNode, IMyXMLNode)
  private
    { IMyXMLNode }
    function GetLevel: integer;
  public
    { IMyXMLNode }
    function GetNextNode: IMyXMLNode;
    function FindChildByAttr(AttrName: string; AttrValue: OleVariant): IMyXMLNode;
  end;

type

  { Базовый класс для работы с XML документами }

  TCustomXMLFile = class(TCustomFileObject)
  private
    FXMLDoc: TXMLDocument;
    { true - если объект создан (вызывался конструктор) }
    EObjCreate: boolean;
    procedure SetXMLDoc(const Value: TXMLDocument);
    function GetFirstNode: IXMLNode;
    function GetDocumentElement: IXMLNode;
  protected
    { Реализация методов предка }
    function DoLoadFromFile(const AFileName: TFileName): boolean; override;
    function DoSaveToFile(const AFileName: TFileName): boolean; override;
    function DoGetAutoSave: boolean; override;
    function DoSetAutoSave(const AAutoSave: boolean): boolean; override;
    function DoGetFileName: TFileName; override;
    function DoSetFileName(const AFileName: TFileName): boolean; override;
  public
    { Самый верхний узел документа }
    property DocElement: IXMLNode read GetDocumentElement;
    { Первый узел }
    property FirstNode: IXMLNode read GetFirstNode;
    { XML документ }
    property XMLDoc: TXMLDocument read FXMLDoc write SetXMLDoc;
    { Поиск узла. FindChild - искать ли среди дочерних элементов. StartNode - узел,
      с которого начинается просмотр (если равен nil, поиск начинается с вершины) }
    function FindNode(NodeName: string; FindChild: boolean = true; StartNode: IXMLNode = nil): IXMLNode;
    { Поиск среди доченрних узлов по заданному значению атрибута AttrName}
    function FindChildByAttr(ParentNode: IXMLNode; AttrName: string; AttrValue: OleVariant): IXMLNode;
    { Функция возвращает следующий узел относительно узла Node}
    function GetNextNode(Node: IXMLNode): IXMLNode;
    { Функция возвращает уровень вложенности узла Node }
    function NodeLevel(Node: IXMLNode): integer;
    { Конструктор, по умолчанию (без создания объекта документа) }
    constructor Create; overload; override;
    { Создание ссылки на объект AXMLDoc }
    constructor Create(AXMLDoc: TXMLDocument); reintroduce; overload;
    { Создание объекта }
    constructor Create(AOwner: TComponent; AFileName: TFileName = ''); reintroduce; overload;
    { Деструктор }
    destructor Destroy; override;
  end;

implementation

{ Рекурсивная функция поиска узла по имени }

function FindNode(StartNode: IXMLNode; NodeName: string; FindChild: boolean): IXMLNode;
var ChildNode: IXMLNode;
begin
  Result := nil;
  // Если источник = nil, выход
  if StartNode = nil then Exit;
  // Если узел не найден, то поиск среди дочерних узлов
  if StartNode.NodeName <> NodeName then
  begin
    if FindChild then
    begin
      ChildNode := StartNode.ChildNodes.First;
      while ChildNode <> nil do
      begin
        Result := FindNode(ChildNode,NodeName, true);
        if Result <> nil then break;
        ChildNode := ChildNode.NextSibling;
      end;
    end;
  end else
    Result := StartNode;
  // Если ничего не найдено, переходим к следующему узлу на уровне StartNode
  if Result = nil then
    Result := FindNode(StartNode.NextSibling,NodeName, FindChild);
end;

{ TCustomXMLFile }

constructor TCustomXMLFile.Create;
begin
  inherited;
  EObjCreate := false;
  { Отключение автосохранения и автозагрузки Автоматическим сохранением и загрузкой
    занимается непосредственно объект XMLDoc }
  AutoLoad := false;
end;

constructor TCustomXMLFile.Create(AXMLDoc: TXMLDocument);
begin
  Create;
  XMLDoc := AXMLDoc;
end;

constructor TCustomXMLFile.Create(AOwner: TComponent; AFileName: TFileName);
begin
  Create;
  { Создание объекта документа }
  FXMLDoc := TXMLDocument.Create(AOwner);
  EObjCreate := true;
  { Установка свойств }
  FXMLDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoSave, doAutoPrefix ];
  FXMLDoc.RegisterDocBinding('',TMyXMLNode);
  //FXMLDoc.NodeIndentStr := #9;
  if AFileName <> '' then FileName := AFileName;
end;

destructor TCustomXMLFile.Destroy;
begin
  if EObjCreate then XMLDoc.Free;
  inherited;
end;

function TCustomXMLFile.DoGetAutoSave: boolean;
begin
  Result := doAutoSave in XMLDoc.Options;
end;

function TCustomXMLFile.DoGetFileName: TFileName;
begin
  Result := XMLDoc.FileName;
end;

function TCustomXMLFile.DoLoadFromFile(const AFileName: TFileName): boolean;
begin
  Result := true;
end;

function TCustomXMLFile.DoSaveToFile(const AFileName: TFileName): boolean;
begin
  Result := true;
  try
    XMLDoc.SaveToFile(AFileName);
  except
    Result := false;
  end;
end;

function TCustomXMLFile.DoSetAutoSave(const AAutoSave: boolean): boolean;
begin
  if AAutoSave then
    XMLDoc.Options := XMLDoc.Options + [doAutoSave]
  else
    XMLDoc.Options := XMLDoc.Options - [doAutoSave];
  Result := true;
end;

function TCustomXMLFile.DoSetFileName(const AFileName: TFileName): boolean;
begin
  Result := false;
  XMLDoc.FileName := AFileName;
  XMLDoc.Active := true;
  Update;
end;

function TCustomXMLFile.FindChildByAttr(ParentNode: IXMLNode; AttrName: string;
  AttrValue: OleVariant): IXMLNode;
var
  Node: IXMLNode;
begin
  if ParentNode <> nil then
    Node := ParentNode.ChildNodes.First
  else
    Node := FirstNode;
  while Node <> nil do
  begin
    if Node.HasAttribute(AttrName) then
      if Node.Attributes[AttrName] = AttrValue then break;
    Node := Node.NextSibling;
  end;
  Result := Node;
end;

function TCustomXMLFile.GetNextNode(Node: IXMLNode): IXMLNode;
var
  ParentNode: IXMLNode;
begin
  if Node = nil then Exit;
  { Поиск среди дочерних узлов, и узлов на уровне узла Node }
  if Node.ChildNodes.First <> nil then
    Result := Node.ChildNodes.First
  else
    Result := Node.NextSibling;
  { Если Result <> nil, узел найден }
  { Иначе переходим на уровень выше }
  ParentNode := Node.ParentNode;
  while (ParentNode <> nil) and (Result = nil) do
  begin
    Result := ParentNode.NextSibling;
    ParentNode := ParentNode.ParentNode;
  end;
end;

function TCustomXMLFile.NodeLevel(Node: IXMLNode): integer;
var
  Parent: IXMLNode;
begin
  Result := -1;
  Parent := Node.ParentNode;
  while Parent <> nil do
  begin
    Inc(Result);
    Parent := Parent.ParentNode;
  end;
end;

function TCustomXMLFile.FindNode(NodeName: string; FindChild: boolean = true;
  StartNode: IXMLNode = nil): IXMLNode;
begin
  if StartNode <> nil then
    Result := MyXML.FindNode(StartNode,NodeName, FindChild)
  else
    Result := MyXML.FindNode(XMLDoc.DocumentElement,NodeName, FindChild);
end;

function TCustomXMLFile.GetDocumentElement: IXMLNode;
begin
  Result := XMLDoc.DocumentElement;
end;

function TCustomXMLFile.GetFirstNode: IXMLNode;
begin
  Result := XMLDoc.DocumentElement.ChildNodes.First;
end;

procedure TCustomXMLFile.SetXMLDoc(const Value: TXMLDocument);
begin
  if EObjCreate then
    XMLDoc.Assign(Value)
  else
    FXMLDoc := Value;
  DoLoad;
end;

{ TMyXMLNodeCollection }

function TMyXMLNodeCollection.Add: IMyXMLNode;
begin
  Result := AddItem(-1) as IMyXMLNode;
end;

procedure TMyXMLNodeCollection.AfterConstruction;
begin
  RegisterChildNode('', TMyXMLNode);
  ItemTag := '';
  ItemInterface := IMyXMLNode;
  inherited;
end;

function TMyXMLNodeCollection.Insert(const Index: Integer): IMyXMLNode;
begin
  Result := AddItem(Index) as IMyXMLNode;
end;

{ TMyXMLNode }

function TMyXMLNode.FindChildByAttr(AttrName: string; AttrValue: OleVariant): IMyXMLNode;
begin

end;

function TMyXMLNode.GetLevel: integer;
var
  Parent: IXMLNode;
begin
  Result := -1;
  Parent := ParentNode;
  while Parent <> nil do
  begin
    Inc(Result);
    Parent := Parent.ParentNode;
  end;
end;

function TMyXMLNode.GetNextNode: IMyXMLNode;
begin
  Result := IMyXMLNode(Self);
end;

end.
