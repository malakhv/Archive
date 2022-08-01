//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "ExportMasterUnit.h"
#include "DioTypeUnit.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMasterExportForm *MasterExportForm;
//---------------------------------------------------------------------------
__fastcall TMasterExportForm::TMasterExportForm(TComponent* Owner)
  : TForm(Owner)
{
  RepInfo = new TRepInfo;
  RepInfo->DioType.OnChange = SetDioType;
  EReportFileDir = ExtractFilePath(Application->ExeName) + "Report\\";
  EPageIndex = 0;
  EPageCount = 4;
}
//---------------------------------------------------------------------------

void TMasterExportForm::SetPageIndex(byte Value)
{
  EPageIndex = Value;
  // Управление панелями
  StartPanel->Visible = EPageIndex == 0;
  TimePanel->Visible  = EPageIndex == 1;
  ViewPanel->Visible  = EPageIndex == 2;
  SavePanel->Visible  = EPageIndex == 3;

  btnPrev->Visible = !StartPanel->Visible;

  if(EPageIndex == 3)
    btnNext->Caption = "Экспорт";
  else
    btnNext->Caption = "Далее >";
}

byte TMasterExportForm::NextPage()
{
  if(EPageIndex + 1 < EPageCount)
    PageIndex++;
  return PageIndex;
}

byte TMasterExportForm::PrevPage()
{
  if(EPageIndex > 0)
		PageIndex--;
	return PageIndex;
}

void __fastcall TMasterExportForm::SetDioType(TObject* Sender)
{
  // Присвоение значения свойству
  RepInfo->LoadInfoFromFile(EReportFileDir + RepInfo->DioType.DioTypeStr + ".ini");
  // Загрузка шаблонов
  cbShablon->Items->Clear();
  RepInfo->LoadShablonList(cbShablon->Items);
  if(cbShablon->Items->Count > 0) cbShablon->ItemIndex = 0;
}

AnsiString TMasterExportForm::GetReportFileName()
{
  if(cbShablon->ItemIndex == -1) return "";
  return  EReportFileDir + cbShablon->Items->Strings[cbShablon->ItemIndex];
}

void TMasterExportForm::SetDateTo(TDateTime Value)
{
  dtpEndDate->Date = Value;
  EDateTo = Value;
}

void TMasterExportForm::SetDateFrom(TDateTime Value)
{
  dtpStartDate->Date = Value;
  EDateFrom = Value;
}

int TMasterExportForm::GetColCount()
{
  return (int) crColDate->Checked + (int) cbColQ->Checked +
    (int) cbColT1->Checked + (int) cbColT2->Checked + (int) cbColV1->Checked +
    (int) cbColV2->Checked + (int) cbColV3->Checked + (int) cbColV4->Checked +
    (int) cbColTOkr->Checked + (int) cbColU->Checked + (int) cbColDT->Checked;
}

//---------------------------------------------------------------------------
void __fastcall TMasterExportForm::cbSaveAsClick(TObject *Sender)
{
  btnSaveDocFile->Enabled = cbSaveAs->Checked;
  edDocFileName->Enabled = cbSaveAs->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::cbPswrdGenerateClick(TObject *Sender)
{
  edPswrdWrite->Enabled = cbPswrdGenerate->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::btnSaveDocFileClick(TObject *Sender)
{
  if(SaveDialog->Execute())
    edDocFileName->Text = SaveDialog->FileName;
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::cbShablonChange(TObject *Sender)
{
  btnNext->Enabled = cbShablon->ItemIndex != - 1;
}
//---------------------------------------------------------------------------


void __fastcall TMasterExportForm::btnNextClick(TObject *Sender)
{
  if(EPageIndex == 3)
    this->ModalResult = mrOk;
  NextPage();
  ActiveControl = btnNext;
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::btnPrevClick(TObject *Sender)
{
  PrevPage();
  if(btnPrev->Visible)
    ActiveControl = btnPrev;
  else
    ActiveControl = btnNext;
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::btnCancelClick(TObject *Sender)
{
  this->ModalResult = mrCancel;  
}
//---------------------------------------------------------------------------

void __fastcall TMasterExportForm::FormShow(TObject *Sender)
{
  PageIndex = 0;
  edDocFileName->Text = "";
  cbSaveAs->Checked = false;
  edPswrdWrite->Text = "";
  edPswrdOpen->Text = "";
}
//---------------------------------------------------------------------------



