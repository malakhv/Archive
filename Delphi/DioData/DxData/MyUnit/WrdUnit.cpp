//---------------------------------------------------------------------------
#pragma hdrstop
#include "WrdUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)

__fastcall TWordApp::TWordApp(bool AutoCreate)
{
  VarClear(EWordApp);
  TerminateAppOnFree = false;
  if(AutoCreate) CreateWordApp();
}

__fastcall TWordApp::~TWordApp()
{
  if(TerminateAppOnFree) WordAppClose();
}

void TWordApp::SetVisible(bool Value)
{
  EWordApp.OlePropertySet("Visible",Value);
}

bool TWordApp::GetVisible()
{
  return (bool) EWordApp.OlePropertyGet("Visible");
}

int TWordApp::GetDocCount()
{
  if(!IsEmpty(EDocuments))
  {
    return (int) EDocuments.OlePropertyGet("Count");
  }
  return -1;
}

Variant TWordApp::GetActiveDocument()
{
  Variant Result = NULL;
  if(!IsEmpty(EWordApp))
    Result = EWordApp.OlePropertyGet("ActiveDocument");
  if(!VarIsNull(Result))
    return Result;
  else
    return NULL;
}

bool TWordApp::CreateWordApp(bool LoadDocs)
{
  EWordApp = CreateOleObject("Word.Application");
  if(!IsEmpty(EWordApp))
  {
    if(LoadDocs)
      EDocuments = EWordApp.OlePropertyGet("Documents");
  }
  return !IsEmpty(EWordApp);
}

void TWordApp::WordAppClose()
{
  if(!IsEmpty(EDocuments))
  {
    if(DocCount > 0)
      EDocuments.OleProcedure("Close");
  }
  EWordApp.OleFunction("Quit");
}

bool TWordApp::AddDocument(AnsiString DocPath)
{
  if(IsEmpty(EDocuments)) return false;
  if(DocPath != "")
  {
    EDocuments.OleProcedure("Add",DocPath.c_str());
    if(!IsEmpty(EDocuments))
      if(!IsEmpty(ESelection = EWordApp.OlePropertyGet("Selection")))
        EFind = ESelection.OlePropertyGet("Find");
  }
  if(!IsEmpty(ActiveDocument))
    Tables = ActiveDocument.OlePropertyGet("Tables");
  return true;
}

bool TWordApp::SaveDocument(AnsiString FileName, AnsiString ReadPswrd,
  AnsiString WritePswrd)
{
  if( (Trim(FileName) == "") || (VarIsNull(EDocuments)) || (VarIsNull(EWordApp)) )
    return false;
  if(!IsEmpty(ActiveDocument))
    // Вызов метода сохранения документа
    ActiveDocument.OleProcedure("SaveAs", FileName.c_str(), 0, true, ReadPswrd.c_str(),
      false, WritePswrd.c_str(), false, false, false, false);
  return true;
}

bool TWordApp::FindAndReplace(AnsiString FindText, AnsiString NewText)
{
  if(!IsEmpty(EFind))
  {
    Variant Replacement;
    if(!IsEmpty(Replacement = EFind.OlePropertyGet("Replacement")))
    {
      EFind.OleProcedure("ClearFormatting");
      Replacement.OleProcedure("ClearFormatting");
      return (bool) EFind.OleFunction("Execute",FindText.c_str(), false, false, false,
        false, false, true, 1, false, NewText.c_str(), 2);
    } else
      return false;
  }
  else
    return false;
}

bool TWordApp::Find(AnsiString FindText)
{
  if(!IsEmpty(EFind))
  {
    EFind.OleProcedure("ClearFormatting");
    EFind.OlePropertySet("Forward",true);
    EFind.OlePropertySet("Text",FindText.c_str());
    return (bool) EFind.OleFunction("Execute");
  }
  else
    return false;
}

bool TWordApp::IsEmpty(Variant Value)
{
  return VarIsEmpty(Value) || VarIsNull(Value);
}

Variant TWordApp::AddTable(Variant Range, int ColCount, int RowCount)
{
  return Tables.OleFunction("Add",Range, RowCount, ColCount);
}

Variant TWordApp::GetSelectionRange()
{
  if(!IsEmpty(ESelection))
    return  ESelection.OlePropertyGet("Range");
  else
    return NULL;
}

void TWordApp::SetSelectionRange(Variant Value)
{
  if(!IsEmpty(Value) && !IsEmpty(ESelection))
    ESelection.OlePropertySet("Range",Value);
}

void TWordApp::AddStaticInfo(CSData data)
{
  FindAndReplace("$HRS$",IntToStr(data.hrs));                 // Наработка
  FindAndReplace("$NUMBER$",IntToStr(data.snum));             // Номер
  FindAndReplace("$TE$", FloatToStrF(data.Q,ffFixed,12,2));   // Тепловая энергия (ГКал)
  // Температура теплоносителя канала 1(oC)
  FindAndReplace("$T1$", ((data.ErrCd&0x01)?AnsiString("Не подключен."):FloatToStrF(data.t1,ffFixed,5,2)));
  // Температура теплоносителя канала 2(oC)
  FindAndReplace("$T2$", ((data.ErrCd&0x02)?AnsiString("Не подключен."):FloatToStrF(data.t2,ffFixed,5,2)));
  FindAndReplace("$V1$", FloatToStrF(data.V1,ffFixed,12,2));  // Объем теплоносителя канала 1(m3)
  FindAndReplace("$V2$", FloatToStrF(data.V2,ffFixed,12,2));  // Объем теплоносителя канала 2(m3)
  FindAndReplace("$V3$", FloatToStrF(data.V3,ffFixed,12,2));  // Объем теплоносителя канала 3(m3)
  FindAndReplace("$V4$", FloatToStrF(data.V4,ffFixed,12,2));  // Объем теплоносителя канала 4(m3)
  FindAndReplace("$M1$", FloatToStrF(data.m1,ffFixed,12,2));  // Масса теплоносителя канала 1(т)
  FindAndReplace("$M2$", FloatToStrF(data.m2,ffFixed,12,2));  // Масса теплоносителя канала 2(т)
  FindAndReplace("$LI1$", FloatToStrF(data.k1,ffFixed,12,2)); // Вес импульса преобразователя канала 1(л/имп)
  FindAndReplace("$LI2$", FloatToStrF(data.k2,ffFixed,12,2)); // Вес импульса преобразователя канала 2(л/имп)
  FindAndReplace("$LI3$", FloatToStrF(data.k3,ffFixed,12,2)); // Вес импульса преобразователя канала 3(л/имп)
  FindAndReplace("$LI4$", FloatToStrF(data.k4,ffFixed,12,2)); // Вес импульса преобразователя канала 4(л/имп)
  FindAndReplace("$PWR$", FloatToStrF(data.bs,ffFixed,5,2));  // Батарея
  FindAndReplace("$T$", IntToStr((int)data.ta));              //Температура окружающей среды
}

void TWordApp::SetTableBorder(Variant ATable)
{
  ATable.OlePropertyGet("Borders").OlePropertySet("OutsideLineStyle",1);
  // Перебор по столбцам
  Variant Columns = ATable.OlePropertyGet("Columns");
  for(int c = 1; c <= Columns.OlePropertyGet("Count"); c ++)
    Columns.OleFunction("Item",c).OlePropertyGet("Borders").OlePropertySet("OutsideLineStyle",1);
  // Перебор по строкам
  Variant Rows = ATable.OlePropertyGet("Rows");
  for(int r = 1;r <= Rows.OlePropertyGet("Count"); r ++)
    Rows.OleFunction("Item",r).OlePropertyGet("Borders").OlePropertySet("OutsideLineStyle",1);
}
