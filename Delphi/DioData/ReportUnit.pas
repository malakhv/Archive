unit ReportUnit;

interface

uses SysUtils, MyWordApp, MyWordDocs, DioDataLib, DioInfoLib, DioReports;

type

  TDioReportBuilder = class(TWordApp)
  private
    FExportData: TDioData;
    FDioInfo: TDioInfo;
    FReport: TDioReport;
    FMax: boolean;
    FAver: boolean;
    FMin: boolean;
    FSum: boolean;
  protected
    procedure AddInfo;
  public
    property ExportData: TDioData read FExportData write FExportData;
    property DioInfo: TDioInfo read FDioInfo write FDioInfo;
    property Report: TDioReport read FReport write FReport;
    property Min: boolean read FMin write FMin;
    property Max: boolean read FMax write FMax;
    property Sum: boolean read FSum write FSum;
    property Aver: boolean read FAver write FAver;
    function BuildReport: TWordDoc;
    constructor Create(AExportData: TDioData; ADioInfo: TDioInfo; AReport: TDioReport); reintroduce;
  end;

implementation

uses DioFieldInfo, DioFieldLib, Global;

{ TDioReport }

procedure TDioReportBuilder.AddInfo;
begin
  if not Exists then Exit;
  with Selection.Find, ExportData.CSData do
  begin
    FindAndReplace('$HRS$',IntToStr(Hrs));      // Наработка
    FindAndReplace('$NUMBER$',IntToStr(SNum));  // Номер
    FindAndReplace('$TE$', StrItem[iQ]);        // Тепловая энергия (ГКал)
    // Температура теплоносителя канала 1(oC)
    if (ErrorCode and $01) <> $01 then
      FindAndReplace('$T1$',StrItem[iT1])
    else
      FindAndReplace('$T1$','Не подключен');
    // Температура теплоносителя канала 2(oC)
    if (ErrorCode and $02) <> $02 then
      FindAndReplace('$T2$',StrItem[iT2])
    else
      FindAndReplace('$T2$','Не подключен');

    FindAndReplace('$V1$', StrItem[iV1]);   // Объем теплоносителя канала 1(m3)
    FindAndReplace('$V2$', StrItem[iV2]);   // Объем теплоносителя канала 2(m3)
    FindAndReplace('$V3$', StrItem[iV3]);   // Объем теплоносителя канала 3(m3)
    FindAndReplace('$V4$', StrItem[iV4]);   // Объем теплоносителя канала 4(m3)
    FindAndReplace('$M1$', StrItem[iM1]);   // Масса теплоносителя канала 1(т)
    FindAndReplace('$M2$', StrItem[iM2]);   // Масса теплоносителя канала 2(т)
    FindAndReplace('$LI1$', StrItem[iK1]);  // Вес импульса преобразователя канала 1(л/имп)
    FindAndReplace('$LI2$', StrItem[iK2]);  // Вес импульса преобразователя канала 2(л/имп)
    FindAndReplace('$LI3$', StrItem[iK3]);  // Вес импульса преобразователя канала 3(л/имп)
    FindAndReplace('$LI4$', StrItem[iK4]);  // Вес импульса преобразователя канала 4(л/имп)
    FindAndReplace('$PWR$', StrItem[iUB]);  // Батарея
    FindAndReplace('$T$', StrItem[iTA]);    //Температура окружающей среды}
    { Информация о документе }
    with Report, ExportData.HData  do
    begin
      FindAndReplace('$CAPTION$',Caption);
      FindAndReplace('$DOCINFO$',DocInfo + ' ' + DateTimeToStr(Date));
      FindAndReplace('$TABLECAPTION$',TableCaption + ' с ' + DateToStr(StartDate)
                + ' по ' + DateToStr(EndDate) );
    end;
    { Информация о владельце прибора }
    with DioInfo do
    begin
      FindAndReplace('$ADDRESS$',String(Address));
      FindAndReplace('$OWNER$',String(Owner));
    end;
  end;
end;

function TDioReportBuilder.BuildReport: TWordDoc;
const ReportDir = 'Report\';
var Fields: TDioFields;
    i, CurRow, CurCol: integer;
    Table: OleVariant;

procedure AddRow(DataItem: TCustomDioData);
var k: integer;
begin
  CurCol := 1;
  for k := 0 to Fields.Count - 1 do
    if Fields[k].Enabled then
    begin
      Table.Cell(CurRow,CurCol).Range.Text := DataItem.StrItem[Fields[k].FieldIndex];
      Inc(CurCol);
    end;
  Inc(CurRow);
end;

begin
  Result := Documents.Add(AppDir + ReportDir +  Report.FileName);
  if Result.Exists then
  begin
    AddInfo;
    Selection.Find.Text := '$TABLESTART$';
    if Selection.Find.Execute then
    begin
      Fields := TDioFields.Create(ExportData.CSData.DioType);
      try
        Result.Tables.Add(Selection.OleObj.Range,ExportData.HData.EnabledCount + 1 +
        Integer(Min) + Integer(Max) + Integer(Sum) + Integer(Aver),Fields.EnabledCount);
        Table := Result.Tables[1].OleObj;
        Result.Tables[1].AutoFormat(16);
        // Вставка заголовка
        CurCol := 1;
        CurRow := 1;
        for i := 0 to Fields.Count - 1 do
          if Fields[i].Enabled then
          begin
            Table.Cell(CurRow,CurCol).Range.Text := Fields[i].Caption;
            Inc(CurCol);
          end;
        CurRow := 2;
        // Загрузка данных
        for i := 0 to ExportData.HData.Count - 1 do
          if ExportData.HData[i].Enabled then
            AddRow(ExportData.HData[i]);

        // Загрузка статистики

        if Min then
        begin
          AddRow(ExportData.HData.Min);
          Table.Cell(CurRow - 1,1).Range.Text := 'Мин.';
        end;

        if Max then
        begin
          AddRow(ExportData.HData.Max);
          Table.Cell(CurRow - 1,1).Range.Text := 'Макс.';
        end;

        if Aver then
        begin
          AddRow( ExportData.HData.Avarage);
          Table.Cell(CurRow - 1,1).Range.Text := 'Средн.';
        end;

        if Sum then
        begin
          AddRow(ExportData.HData.Sum);
          Table.Cell(CurRow - 1,1).Range.Text := 'Сумма';
        end;

      finally
        Fields.Free;
      end;
    end;
  end else
    Result := nil;
end;

constructor TDioReportBuilder.Create(AExportData: TDioData; ADioInfo: TDioInfo;
  AReport: TDioReport);
begin
  inherited Create(true);
  ExportData := AExportData;
  DioInfo := ADioInfo;
  Report := AReport;
end;

end.
