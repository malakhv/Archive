unit DioReports;

interface

uses SysUtils, Classes, MyClasses, DioXML, DioTypes;

type

  { Класс для работы с информацией об отчете }

  TDioReport = class(TCustomDioXML)
  private
    function GetDocInfo: string;
    function GetFileName: TFileName;
    function GetReportType: TDioArcType;
    function GetTableCaption: string;
    procedure SetDocInfo(const Value: string);
    procedure SetFileName(const Value: TFileName);
    procedure SetReportType(const Value: TDioArcType);
    procedure SetTableCaption(const Value: string);
  public
    property ReportType: TDioArcType read GetReportType write SetReportType;
    property FileName: TFileName read GetFileName write SetFileName;
    property DocInfo: string read GetDocInfo write SetDocInfo;
    property TableCaption: string read GetTableCaption write SetTableCaption;
  end;

  { Класс для работы со списком Отчетов }

  TDioReports = class(TXMLDioCollection)
  private
    EDioReport: TDioReport;
    function GetItem(Index: integer): TDioReport;
  public
    property Item[Index: integer]: TDioReport read GetItem; default;
    constructor Create(ADioType: byte); override;
    destructor Destroy; override;
  end;

implementation

const

  { Имена атрибутов XML }

  aType = 'Type';
  aFileName = 'FileName';
  aDocInfo = 'DocInfo';
  aTableCaption = 'TableCaption';



{ TDioReport }

function TDioReport.GetDocInfo: string;
begin
  Result := Attribute[aDocInfo];
end;

function TDioReport.GetFileName: TFileName;
begin
  Result := Attribute[aFileName];
end;

function TDioReport.GetReportType: TDioArcType;
begin
  Result := TDioArcType(Integer(Attribute[aType]));
end;

function TDioReport.GetTableCaption: string;
begin
  Result := Attribute[aTableCaption];
end;

procedure TDioReport.SetDocInfo(const Value: string);
begin
  Attribute[aDocInfo] := Value;
end;

procedure TDioReport.SetFileName(const Value: TFileName);
begin
  Attribute[aFileName] := Value;
end;

procedure TDioReport.SetReportType(const Value: TDioArcType);
begin
  Attribute[aType] := Integer(Value);
end;

procedure TDioReport.SetTableCaption(const Value: string);
begin
  Attribute[aTableCaption] := Value;
end;

{ TDioFields }

constructor TDioReports.Create(ADioType: byte);
begin
  inherited;
  EDioReport := TDioReport.Create(nil);
  XMLType := dxtReports;
end;

destructor TDioReports.Destroy;
begin
  EDioReport.Free;
  inherited;
end;

function TDioReports.GetItem(Index: integer): TDioReport;
begin
  EDioReport.XMLNode := XMLNode.ChildNodes[Index];
  if EDioReport.Exists then
    Result := EDioReport
  else
    Result := nil;
end;

end.
