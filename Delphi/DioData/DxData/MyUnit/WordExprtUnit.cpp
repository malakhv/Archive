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
  // Переменные
  TStringList *List = new TStringList;
  AnsiString ReportInfoFile, DioSectionStr;

  // Присвоение значения свойству
  EDioType = Value;
  // Загрузка шаблонов
  // Получение пути к папке с шаблонами
  ReportInfoFile = EReportFileDir + "Info.ini";
  // Формирование имени раздела
  DioSectionStr = "[" + TDioType::DioTypeToStr(EDioType) + "]";
  try
  {
    List->LoadFromFile(ReportInfoFile);
    for(int i=0;i < List->Count;i++)
    {
      if(List->Strings[i] == DioSectionStr)
      {
        // Секция найдена
        int j = i + 1;
        // Обработка имен файлов
        while(j < List->Count)
        {
          // Если в строке есть символ [, значит дошли до следующего раздела
          if(StrPos(List->Strings[j].c_str(),"[") != NULL)
            break;
          // Если пустая строка, завершаем текущую итерацию
          if(Trim(List->Strings[j]) != "")
            // Добавление файла (с проверкой пути)
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

