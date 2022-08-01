unit DataExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, DioTypes, DioReports;

type
  TExportFrm = class(TForm)
    LogoImage: TImage;
    btnPanel: TPanel;
    StartPanel: TPanel;
    lblHead: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnCancel: TButton;
    btnNext: TButton;
    btnPrev: TButton;
    Label1: TLabel;
    SavePanel: TPanel;
    PageSaveHead: TLabel;
    PageSaveText: TLabel;
    PageSaveLine1: TBevel;
    edDocFileName: TEdit;
    cbSaveAs: TCheckBox;
    cbOpenMSWord: TCheckBox;
    btnSaveDocFile: TSpeedButton;
    PageSaveLine2: TBevel;
    edPswrdOpen: TEdit;
    edPswrdWrite: TEdit;
    cbPswrdGenerate: TCheckBox;
    lblPswrdOpen: TLabel;
    lblPswrdWrite: TLabel;
    SaveDialog: TSaveDialog;
    TimePanel: TPanel;
    ViewPanel: TPanel;
    Panel3: TPanel;
    lblTimePanelHead: TLabel;
    lblTimePanelText: TLabel;
    dtpStartDate: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    lblSDate: TLabel;
    lblEDate: TLabel;
    cbNakop: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    cbReport: TComboBox;
    lblShablon: TLabel;
    btnAddShablon: TSpeedButton;
    lblCount: TLabel;
    cbMin: TCheckBox;
    cbMax: TCheckBox;
    cbAver: TCheckBox;
    cbSum: TCheckBox;
    DateBox: TComboBox;
    btnField: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnFieldClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbSaveAsClick(Sender: TObject);
    procedure btnSaveDocFileClick(Sender: TObject);
  private
    FPageIndex: byte;
    FPageCount: byte;
    FDioType: byte;
    FArcType: TDioArcType;
    EReport: TDioReport;
    procedure SetPageIndex(const Value: byte);
    procedure SetDioType(const Value: byte);
    procedure SetViewType(const Value: TDioViewType);
    function GetEDate: TDate;
    function GetSDate: TDate;
    procedure SetEDate(const Value: TDate);
    procedure SetSDate(const Value: TDate);
    procedure SetArcType(const Value: TDioArcType);
    function GetViewType: TDioViewType;
    function GetReport: TDioReport;
  protected
    procedure UpdateReportList;
  public
    property PageIndex: byte read FPageIndex write SetPageIndex;
    property PageCount: byte read FPageCount;
    property DioType: byte read FDioType write SetDioType;
    property ArcType: TDioArcType read FArcType write SetArcType;
    property Report: TDioReport read GetReport;
    property ViewType: TDioViewType read GetViewType write SetViewType;
    property SDate: TDate read GetSDate write SetSDate;
    property EDate: TDate read GetEDate write SetEDate;
    function PagePrev: byte;
    function PageNext: byte;
  end;

var
  ExportFrm: TExportFrm;

implementation

uses XMLIntf, XMLDoc, Global, FieldInfoUnit;

const
  ReportDir = 'Report\';

{$R *.dfm}

procedure TExportFrm.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TExportFrm.btnFieldClick(Sender: TObject);
var frmFields: TFieldInfoForm;
begin
  frmFields := TFieldInfoForm.Create(Application);
  try
    frmFields.DioType := DioType;
    if frmFields.ShowModal = mrOK then
    begin
      //RepFields.Assign(frmFields.Fields);
    end;
  finally
    frmFields.Free;
  end;
end;

procedure TExportFrm.btnNextClick(Sender: TObject);
begin
  if PageIndex = 3 then
    ModalResult := mrOk;
  PageNext;
  ActiveControl := btnNext;
end;

procedure TExportFrm.btnPrevClick(Sender: TObject);
begin
  PagePrev;
  if btnPrev.Visible then
    ActiveControl := btnPrev
  else
    ActiveControl := btnNext;
end;

procedure TExportFrm.btnSaveDocFileClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    edDocFileName.Text := SaveDialog.FileName;
end;

procedure TExportFrm.cbSaveAsClick(Sender: TObject);
begin
  btnSaveDocFile.Enabled := cbSaveAs.Checked;
end;

procedure TExportFrm.FormCreate(Sender: TObject);
begin
  EReport := TDioReport.Create(nil);
  PageIndex := 0;
  FPageCount := 4;
end;

procedure TExportFrm.FormDestroy(Sender: TObject);
begin
  EReport.Free;
end;

function TExportFrm.GetEDate: TDate;
begin
  Result := dtpEndDate.Date;
end;

function TExportFrm.GetReport: TDioReport;
begin
  EReport.XMLNode := TXMLNode(cbReport.Items.Objects[cbReport.ItemIndex]);
  if EReport.Exists then
    Result := EReport
  else
    Result := nil;
end;

function TExportFrm.GetSDate: TDate;
begin
  Result := dtpStartDate.Date;
end;

function TExportFrm.GetViewType: TDioViewType;
begin
  if not cbNakop.Checked then
    Result := vtCurrent
  else
    Result := vtSavings;
end;

function TExportFrm.PageNext: byte;
begin
  if FPageIndex + 1 < FPageCount then
    PageIndex := PageIndex + 1;
  Result := PageIndex;
end;

function TExportFrm.PagePrev: byte;
begin
  if PageIndex > 0 then
		PageIndex := PageIndex - 1;
  Result := PageIndex;
end;

procedure TExportFrm.SetArcType(const Value: TDioArcType);
begin
  FArcType := Value;
  dtpStartDate.Visible := FArcType = atDay;
  dtpEndDate.Visible := FArcType = atDay;
  lblEDate.Visible := FArcType = atDay;
  DateBox.Visible := FArcType = atHour;
  if FArcType = atDay then
    lblSDate.Caption := 'Начальная дата:'
  else
    lblSDate.Caption := 'Дата:';
  UpdateReportList;
end;

procedure TExportFrm.SetDioType(const Value: byte);
begin
  FDioType := Value;
  UpdateReportList;
end;

procedure TExportFrm.SetEDate(const Value: TDate);
begin
  dtpEndDate.Date := Value;
end;

procedure TExportFrm.SetPageIndex(const Value: byte);
begin
  FPageIndex := Value;
  // Управление панелями
  StartPanel.Visible := FPageIndex = 0;
  TimePanel.Visible  := FPageIndex = 1;
  ViewPanel.Visible  := FPageIndex = 2;
  SavePanel.Visible  := FPageIndex = 3;
  // Управление кнопками
  btnPrev.Visible := not StartPanel.Visible;
  if FPageIndex = 3 then
    btnNext.Caption := 'Экспорт'
  else
    btnNext.Caption := 'Далее >';
end;

procedure TExportFrm.SetSDate(const Value: TDate);
begin
  dtpStartDate.Date := Value;
end;

procedure TExportFrm.SetViewType(const Value: TDioViewType);
begin
  cbNakop.Checked := Value = vtSavings;
end;

procedure TExportFrm.UpdateReportList;
var Reports: TDioReports;
    i: integer;
begin
  cbReport.Clear;
  Reports := TDioReports.Create(DioType);
  try
    for i := 0 to Reports.Count - 1 do
      if Reports[i].ReportType = ArcType then
        cbReport.AddItem(Reports[i].Name,TObject(Reports[i].XMLNode));
  finally
    Reports.Free;
  end;
  if cbReport.Items.Count > 0 then cbReport.ItemIndex := 0;
end;

end.
