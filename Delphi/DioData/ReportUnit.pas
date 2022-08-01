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
    FindAndReplace('$HRS$',IntToStr(Hrs));      // ���������
    FindAndReplace('$NUMBER$',IntToStr(SNum));  // �����
    FindAndReplace('$TE$', StrItem[iQ]);        // �������� ������� (����)
    // ����������� ������������� ������ 1(oC)
    if (ErrorCode and $01) <> $01 then
      FindAndReplace('$T1$',StrItem[iT1])
    else
      FindAndReplace('$T1$','�� ���������');
    // ����������� ������������� ������ 2(oC)
    if (ErrorCode and $02) <> $02 then
      FindAndReplace('$T2$',StrItem[iT2])
    else
      FindAndReplace('$T2$','�� ���������');

    FindAndReplace('$V1$', StrItem[iV1]);   // ����� ������������� ������ 1(m3)
    FindAndReplace('$V2$', StrItem[iV2]);   // ����� ������������� ������ 2(m3)
    FindAndReplace('$V3$', StrItem[iV3]);   // ����� ������������� ������ 3(m3)
    FindAndReplace('$V4$', StrItem[iV4]);   // ����� ������������� ������ 4(m3)
    FindAndReplace('$M1$', StrItem[iM1]);   // ����� ������������� ������ 1(�)
    FindAndReplace('$M2$', StrItem[iM2]);   // ����� ������������� ������ 2(�)
    FindAndReplace('$LI1$', StrItem[iK1]);  // ��� �������� ��������������� ������ 1(�/���)
    FindAndReplace('$LI2$', StrItem[iK2]);  // ��� �������� ��������������� ������ 2(�/���)
    FindAndReplace('$LI3$', StrItem[iK3]);  // ��� �������� ��������������� ������ 3(�/���)
    FindAndReplace('$LI4$', StrItem[iK4]);  // ��� �������� ��������������� ������ 4(�/���)
    FindAndReplace('$PWR$', StrItem[iUB]);  // �������
    FindAndReplace('$T$', StrItem[iTA]);    //����������� ���������� �����}
    { ���������� � ��������� }
    with Report, ExportData.HData  do
    begin
      FindAndReplace('$CAPTION$',Caption);
      FindAndReplace('$DOCINFO$',DocInfo + ' ' + DateTimeToStr(Date));
      FindAndReplace('$TABLECAPTION$',TableCaption + ' � ' + DateToStr(StartDate)
                + ' �� ' + DateToStr(EndDate) );
    end;
    { ���������� � ��������� ������� }
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
        // ������� ���������
        CurCol := 1;
        CurRow := 1;
        for i := 0 to Fields.Count - 1 do
          if Fields[i].Enabled then
          begin
            Table.Cell(CurRow,CurCol).Range.Text := Fields[i].Caption;
            Inc(CurCol);
          end;
        CurRow := 2;
        // �������� ������
        for i := 0 to ExportData.HData.Count - 1 do
          if ExportData.HData[i].Enabled then
            AddRow(ExportData.HData[i]);

        // �������� ����������

        if Min then
        begin
          AddRow(ExportData.HData.Min);
          Table.Cell(CurRow - 1,1).Range.Text := '���.';
        end;

        if Max then
        begin
          AddRow(ExportData.HData.Max);
          Table.Cell(CurRow - 1,1).Range.Text := '����.';
        end;

        if Aver then
        begin
          AddRow( ExportData.HData.Avarage);
          Table.Cell(CurRow - 1,1).Range.Text := '�����.';
        end;

        if Sum then
        begin
          AddRow(ExportData.HData.Sum);
          Table.Cell(CurRow - 1,1).Range.Text := '�����';
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
