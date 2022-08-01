unit uDioOpt;

interface

uses Classes, XMLIntf, XMLDoc, MyProgOpt;

const

  { XML Node }

  nDioOptions = 'DioOptions';
  nDio = 'Dio';
  nFields = 'Fields';
  nStats = 'Stats';
  nReports = 'Reports';

  { Имена атрибутов }

  aName = 'Name';
  aType = 'Type';
  aCaption = 'Caption';


const

  { Имена узлов настройки приложения }

  opDataDir = 'DataDir';
  opDioMask = 'DioMask';

var

  { Настройки приложения }

  ProgOpt: TCustomProgOptions;

  { Фунеция возвращает ссылку на узел Dio, у которого тип DioType }

  function GetDioNode(DioType: string): IXMLNode; overload;
  function GetDioNode(DioType: byte): IXMLNode; overload;
  function GetNodeByName(NodeName: string; DioType: byte): IXMLNode;

implementation

uses DioTypeLib;

  { Функция возвращает первый узел в списке дочерних для ParentNode }

  function GetFirstChild(ParentNode: IXMLNode): IXMLNode;
  begin
    if ParentNode.HasChildNodes then
      Result := ParentNode.ChildNodes.First
    else
      Result := nil;
  end;

function GetDioNode(DioType: string): IXMLNode;
begin
  //Result := GetFirstChild(XML.ChildNodes[nDioOptions]);
  Result := GetFirstChild(ProgOpt.XMLDoc.ChildNodes[nDioOptions]);
  while Result <> nil do
  begin
    if Result.NodeName = nDio then
      if Result.Attributes[aType] = DioType then break;
    Result := Result.NextSibling;
  end;
end;

function GetDioNode(DioType: byte): IXMLNode;
begin
  Result := GetDioNode(TDioType.DioTypeToStr(DioType));
end;

function GetNodeByName(NodeName: string; DioType: byte): IXMLNode;
begin
  Result := GetDioNode(DioType);
  if Result <> nil then
    Result := Result.ChildNodes[NodeName];
end;

end.
