//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include "WordExprtUnit.h"
#include "DioTypeUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TWordExprtForm *WordExprtForm;
//---------------------------------------------------------------------------
__fastcall TWordExprtForm::TWordExprtForm(TComponent* Owner)
  : TForm(Owner)
{
  EReportFileDir = ExtractFilePath(Application->ExeName) + "Report\\";
}
//---------------------------------------------------------------------------
void __fastcall TWordExprtForm::btnOKClick(TObject *Sender)
{
  this->ModalResult = mrOk;  
}
//---------------------------------------------------------------------------
void __fastcall TWordExprtForm::btnCancelClick(TObject *Sender)
{
  this->ModalResult = mrCancel;  
}
//---------------------------------------------------------------------------
void TWordExprtForm::SetDioType(byte Value)
{
  // ����������
  TStringList *List = new TStringList;
  AnsiString ReportInfoFile, DioSectionStr;

  // ���������� �������� ��������
  EDioType = Value;
  // �������� ��������
  // ��������� ���� � ����� � ���������
  ReportInfoFile = EReportFileDir + "Info.ini";
  // ������������ ����� �������
  DioSectionStr = "[" + TDioType::DioTypeToStr(EDioType) + "]";
  try
  {
    List->LoadFromFile(ReportInfoFile);
    for(int i=0;i < List->Count;i++)
    {
      if(List->Strings[i] == DioSectionStr)
      {
        // ������ �������
        int j = i + 1;
        // ��������� ���� ������
        while(j < List->Count)
        {
          // ���� � ������ ���� ������ [, ������ ����� �� ���������� �������
          if(StrPos(List->Strings[j].c_str(),"[") != NULL)
            break;
          // ���� ������ ������, ��������� ������� ��������
          if(Trim(List->Strings[j]) != "")
            // ���������� ����� (� ��������� ����)
            if(FileExists(EReportFileDir + List->Strings[j]))
              cbShablon->Items->Add(List->Strings[j]);
          j++;
        }
        break;
      }
    }
  }
  __finally
  {
    List->Free();
  }
  if(cbShablon->Items->Count > 0)
    cbShablon->ItemIndex = 0;
}
//---------------------------------------------------------------------------
void __fastcall TWordExprtForm::cbShablonChange(TObject *Sender)
{
  btnOK->Enabled = (cbShablon->ItemIndex != - 1) &&
    (Trim(edDocName->Text) != "");
}
//---------------------------------------------------------------------------

void __fastcall TWordExprtForm::FormShow(TObject *Sender)
{
  edDocName->Text = DateToStr(Date());
}
//---------------------------------------------------------------------------
AnsiString TWordExprtForm::GetReportFileName()
{
  if(cbShablon->ItemIndex == -1) return "";
  return  EReportFileDir + cbShablon->Items->Strings[cbShablon->ItemIndex];
}

