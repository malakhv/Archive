//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "ExportProgresUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CGAUGES"
#pragma resource "*.dfm"
TExportProgresForm *ExportProgresForm;
//---------------------------------------------------------------------------
__fastcall TExportProgresForm::TExportProgresForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TExportProgresForm::FormShow(TObject *Sender)
{
  Progress->Progress = 0;
}
//---------------------------------------------------------------------------

void TExportProgresForm::AddProgress(int Value)
{
  Progress->Progress = Progress->Progress + Value;
}

AnsiString TExportProgresForm::GetInfo()
{
  return lblInfo->Caption;
}

void TExportProgresForm::SetInfo(AnsiString Value)
{
  lblInfo->Caption = Value;
}
