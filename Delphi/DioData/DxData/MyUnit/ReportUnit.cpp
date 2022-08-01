//--------------------------------------------------------------------------------------------------
#pragma hdrstop
#include "ReportUnit.h"
//--------------------------------------------------------------------------------------------------
#pragma package(smart_init)

//--------------------------------------------------------------------------------------------------
//															TRepColInfo
//--------------------------------------------------------------------------------------------------

AnsiString TRepColInfo::TextOf(AnsiString ColName)
{
	int AIndex = IndexOf(ColName);
	if (AIndex != -1)
		return ColTexts[AIndex];
	else
		return "";
}

AnsiString TRepColInfo::TextOf(int Index)
{
	if( (Index >= 0) && (Index < ColumnCount) )
		return ColTexts[Index];
	else
		return "";
}

int TRepColInfo::IndexOf(AnsiString ColName)
{
	int AIndex = -1;
	for(int i = 0; i < ColumnCount; i++)
		if( ColNames[i] == Trim(ColName.UpperCase()) )
		{
				AIndex = i;
				break;
		}
	return AIndex;
}

//--------------------------------------------------------------------------------------------------
//                                        TRepColumn
//--------------------------------------------------------------------------------------------------

AnsiString TRepColumn::GetText()
{
		return TRepColInfo::TextOf(EName);
}

AnsiString TRepColumn::GetCaption()
{
		return EName + ", " + Text;
}

void TRepColumn::SetName(AnsiString Value)
{
	if(Trim(Value) != "")
		EName = Value;
}

void TRepColumn::Assign(TRepColumn Source)
{
	Name = Source.Name;
	Enabled = Source.Enabled;
}

TRepColumn::TRepColumn()
{
	EName = "";
	EEnabled = false;
}

//--------------------------------------------------------------------------------------------------
//                                        TRepColumns
//--------------------------------------------------------------------------------------------------

TRepColumn TRepColumns::GetItem(int Index)
{
	return *EColumns[Index];
}

int TRepColumns::GetCount()
{
  return EColumns.Length;
}

int TRepColumns::GetEnabledCount()
{
  int Result = 0;
  for(int i = 0; i < EColumns.Length; i++)
    if(EColumns[i]->Enabled) Result++;
  return Result;
}

AnsiString TRepColumns::GetNames(int Index)
{
  return EColumns[Index]->Name;
}

void TRepColumns::SetItem(int Index, TRepColumn Value)
{
	EColumns[Index]->Assign(Value);
}

void TRepColumns::SetNames(int Index, AnsiString AName)
{
  EColumns[Index]->Name = AName;
}

int TRepColumns::Add()
{
	EColumns.Length = EColumns.Length + 1;
  EColumns[EColumns.Length - 1] = new TRepColumn;
	return EColumns.Length - 1;
}

int TRepColumns::Add(TRepColumn ARepColumn)
{
	int AIndex = -1;
  AIndex = Add();
  EColumns[AIndex]->Assign(ARepColumn);
	return AIndex;
}

int TRepColumns::Add(AnsiString Name, bool Enabled)
{
	int AIndex = - 1;
	if(Trim(Name) != "")
	{
		AIndex = Add();
		EColumns[AIndex]->Name = Trim(Name);
		EColumns[AIndex]->Enabled = Enabled;
	}
	return AIndex;
}

void TRepColumns::Clear()
{
  for(int i = 0; i < EColumns.Length; i++)
    delete EColumns[i];
	EColumns.Length = 0;
}

int TRepColumns::IndexOf(AnsiString ColName)
{
  int Result = -1;
  for(int i = 0; i < EColumns.Length; i++)
    if(EColumns[i]->Name == ColName)
    {
      Result = i;
      break;
    }
  return Result;
}

TRepColumns::TRepColumns()
{
  EColumns.Length = 0;
}

TRepColumns::~TRepColumns()
{
  Clear();
}

//--------------------------------------------------------------------------------------------------
//                                        TRepType
//--------------------------------------------------------------------------------------------------

AnsiString TRepType::GetRepTypeStr()
{
  return RepTypeToStr(EEnumRepType);
}


void TRepType::SetRepType(TEnumRepType Value)
{
  if(EEnumRepType != Value)
  {
    EEnumRepType = Value;
    if( EOnChange != NULL ) EOnChange((TObject*)this);
  }
}

void TRepType::SetRepTypeStr(AnsiString Value)
{
  RepType = StrToRepType(Value);
}

TRepType::operator = (TEnumRepType Value)
{
  RepType = Value;
  return RepType;
}

AnsiString TRepType::RepTypeToStr(TEnumRepType ARepType)
{
  switch (ARepType) {
		case rpNone : return "";
		case rpDay  : return "DAY";
		case rpHour : return "HOUR";
	}
	return "";
}

TEnumRepType TRepType::StrToRepType(AnsiString ARepTypeStr)
{
  AnsiString AValue = Trim(ARepTypeStr.UpperCase());
  if(AValue == "DAY") return rpDay;
  if(AValue == "HOUR") return rpHour;
  return rpNone;
}

TRepType::TRepType()
{
  EEnumRepType = rpDay;
}

//--------------------------------------------------------------------------------------------------
//                                        TValue
//--------------------------------------------------------------------------------------------------

int TValue::GetVarType()
{
  return EValue.Type();
}

bool TValue::GetNumeric()
{
  return VarIsNumeric(EValue);
}

bool TValue::GetString()
{
  return VarIsString(EValue);
}

void TValue::SetVarType(int Value)
{
  //EValue.SetType(Value);
}

bool TValue::GetEmpty()
{
  return VarIsEmpty(EValue) || VarIsNull(EValue);
}

void TValue::Assign(TValue Source)
{
  EValue = Source.Value;
}

void TValue::Clear()
{
  VarClear(EValue);
}

bool TValue::VarIsNumeric(Variant AValue)
{
  return AValue.Type() == (varSmallint	| varInteger | varSingle | varDouble |
    varCurrency | varByte );
}

bool TValue::VarIsString(Variant AValue)
{
  return AValue.Type() == (varOleStr | varString	);
}

AnsiString TValue::ToStr( TFloatFormat Format, int Precision, int Digits)
{
  AnsiString Result = "";
  switch(EValue.VType) {
    case varSmallint, varInteger, varByte: Result = IntToStr((int)EValue);
    case varSingle, varDouble, varCurrency: Result = FloatToStrF((float)EValue, Format, Precision, Digits);
    default: Result = "";
  }
  return Result;
}

TValue::TValue()
{
  Clear();
}

TValue::~TValue()
{
  Clear();
}


//--------------------------------------------------------------------------------------------------
//                                        TValueList
//--------------------------------------------------------------------------------------------------

TValue TValueList::GetItem(int Index)
{
  return *EValueList[Index];
}

int TValueList::GetCount()
{
  return EValueList.Length;
}

void TValueList::SetItem(int Index, TValue AValue)
{
  EValueList[Index]->Assign(AValue);
}

void TValueList::SetAutoCalc(bool Value)
{
  EAutoCalc = Value;
  if(EAutoCalc) Calculate();
}

int TValueList::Add()
{
  EValueList.Length = EValueList.Length + 1;
	return EValueList.Length - 1;
}

int TValueList::Add(Variant AValue)
{
  int AIndex = Add();
  EValueList[AIndex]->Value = AValue;
  if(AutoCalc && EValueList[AIndex]->Numeric)
  {
    if(EMin.Value < AValue) EMin.Assign(*EValueList[AIndex]);
    if(EMax.Value < AValue) EMax.Assign(*EValueList[AIndex]);
    ESumma.Value = ESumma.Value + AValue;
    EAverage.Value = ESumma.Value / Count;
  }
  return AIndex;
}

int TValueList::Add(TValue AValue)
{
  int AIndex = Add();
  EValueList[AIndex]->Assign(AValue);
  if(AutoCalc && EValueList[AIndex]->Numeric)
  {
    if(EMin.Value < AValue.Value) EMin.Assign(*EValueList[AIndex]);
    if(EMax.Value < AValue.Value) EMax.Assign(*EValueList[AIndex]);
    ESumma.Value = ESumma.Value + AValue.Value;
    EAverage.Value = ESumma.Value / Count;
  }
  return AIndex;
}

void TValueList::Calculate()
{
  if(Count < 1) return;
  EMin.Assign(*EValueList[0]);
  EMax.Assign(*EValueList[0]);
  ESumma.Clear();
  ESumma.Value = 0;
  EAverage.Clear();
  EAverage.Value = 0;

  for(int i = 0; i < Count; i++)
    if(EValueList[i]->Numeric)
    {
      if(EValueList[i]->Value < EMin.Value) EMin.Assign(*EValueList[i]);
      if(EValueList[i]->Value > EMax.Value) EMax.Assign(*EValueList[i]);
      ESumma.Value = ESumma.Value + EValueList[i]->Value;
    }
  EAverage.Value = ESumma.Value / Count;
}

void TValueList::Clear()
{
  ClearStatistic();
  ClearValues();
  EValueList.Length = 0;
}

void TValueList::ClearValues()
{
  for(int i = 0; i<Count; i++)
    EValueList[i]->Clear();
}

void TValueList::ClearStatistic()
{
  EMinIndex = -1;
  EMaxIndex = -1;
  EMin.Clear();
  EMax.Clear();
  ESumma.Clear();
  EAverage.Clear();
}

TValueList::TValueList()
{
  ClearStatistic();
  EAutoCalc = true;
}

TValueList::~TValueList()
{
  Clear();
}

//--------------------------------------------------------------------------------------------------
//                                        TValueList
//--------------------------------------------------------------------------------------------------

TValueList TMatrix::GetItem(int Index)
{
  return *EMatrix[Index];
}

int TMatrix::GetCount()
{
  return EMatrix.Length;
}

void TMatrix::SetItem(int Index, TValueList Value)
{
  EMatrix[Index]->Assign(Value);
}

void TMatrix::Clear()
{
  for(int i = 0; i < Count; i++)
  {
    EMatrix[i]->Clear();
    delete EMatrix[i];
  }
  EMatrix.Length = 0;
}

int TMatrix::Add(AnsiString Name)
{
  int index = Count;
  EMatrix.Length = EMatrix.Length + 1;
  EMatrix[index]->Name = Name;
	return index;
}

TMatrix::TMatrix()
{
  Clear();
}

TMatrix::~TMatrix()
{
  Clear();
}

//--------------------------------------------------------------------------------------------------
//                                         TRepInfo
//--------------------------------------------------------------------------------------------------

AnsiString TRepInfo::GetDocName()
{
  return getDocName(ERepType.RepType);
}

AnsiString TRepInfo::GetDocInfo()
{
  return getDocInfo(ERepType.RepType);
}

AnsiString TRepInfo::GetTableCaption()
{
  return getTableCaption(ERepType.RepType);
}

void TRepInfo::SetFileName(AnsiString Value)
{
  if(!Value.IsEmpty()) EFileName = Value;
}

void TRepInfo::SetDocName(AnsiString Value)
{
  setDocName(Value, ERepType.RepType);
}

void TRepInfo::SetDocInfo(AnsiString Value)
{
  setDocInfo(Value, ERepType.RepType);
}

void TRepInfo::SetTableCaption(AnsiString Value)
{
  setTableCaption(Value, ERepType.RepType);
}

bool TRepInfo::NameExists(AnsiString AName)
{
  return List->IndexOfName(AName) != -1;
}

AnsiString TRepInfo::GetValue(AnsiString AName)
{
  if(NameExists(AName))
    return List->Values[AName];
  else
    return "";
}

void TRepInfo::SetValue(AnsiString AName, AnsiString AValue)
{
  if(NameExists(AName))
    List->Values[AName] = AValue;
}

void TRepInfo::LoadInfoFromFile(AnsiString AFileName)
{
  if(FileExists(AFileName))
  {
    List->LoadFromFile(AFileName);
    FileName = AFileName;
    EIsOpen = true;
    LoadColumnsInfo();
  }
}

void TRepInfo::SaveInfoToFile(AnsiString AFileName)
{
  if(!AFileName.IsEmpty())
    FileName = AFileName;
  if(!FileName.IsEmpty())
  {
    List->SaveToFile(FileName);
  }
}

AnsiString TRepInfo::getDocName(TEnumRepType ARepType)
{
  return GetValue("DOCNAME" + TRepType::RepTypeToStr(ARepType));
}

AnsiString TRepInfo::getDocInfo(TEnumRepType ARepType)
{
  return GetValue("DOCINFO" + TRepType::RepTypeToStr(ARepType));
}

AnsiString TRepInfo::getTableCaption(TEnumRepType ARepType)
{
  return GetValue("TABLECAPTION" + TRepType::RepTypeToStr(ARepType));
}

void TRepInfo::setDocName(AnsiString ADocName, TEnumRepType ARepType)
{
  SetValue("DOCNAME" + TRepType::RepTypeToStr(ARepType), ADocName);
}

void TRepInfo::setDocInfo(AnsiString ADocInfo, TEnumRepType ARepType)
{
  SetValue("DOCINFO" + TRepType::RepTypeToStr(ARepType), ADocInfo);
}

void TRepInfo::setTableCaption(AnsiString ATableCaption, TEnumRepType ARepType)
{
  SetValue("TABLECAPTION" + TRepType::RepTypeToStr(ARepType), ATableCaption);
}

bool TRepInfo::StartSectionExists(AnsiString Str)
{
  return StrPos(Str.c_str(),"[") != NULL;
}

bool TRepInfo::EndSectionExists(AnsiString Str)
{
  return StrPos(Str.c_str(),"]") != NULL;
}

int TRepInfo::GetSectionIndex(AnsiString SectionName)
{
  int Index = -1;
  if(!IsSectionName(SectionName))
    SectionName = StrToSectionName(SectionName);
  for(int i =0; i < List->Count; i++)
    if(List->Strings[i] == SectionName)
    {
      Index = i + 1;
      break;
    }
  return Index;
}

bool TRepInfo::IsSectionName(AnsiString Str)
{
  return StartSectionExists(Str) && EndSectionExists(Str);
}

AnsiString TRepInfo::StrToSectionName(AnsiString Str)
{
  AnsiString ResultStr = Trim(Str);
  if(ResultStr.IsEmpty()) ResultStr = "NotName";
  if(!IsSectionName(ResultStr))
  {
    if(!StartSectionExists(ResultStr)) ResultStr = "[" + ResultStr;
    if(!EndSectionExists(ResultStr)) ResultStr = ResultStr + "]";
  };
  return ResultStr;
}

void TRepInfo::LoadColumnsInfo()
{
  if(List->Count == 0) return;
  AnsiString TmpStr;
  EColumns.Clear();
  int SectStart = GetSectionIndex("[COLUMNS]");
  if(SectStart == -1) return;
  for(int i = SectStart; i < List->Count; i++)
  {
    TmpStr = List->Strings[i];
    if( IsSectionName(TmpStr) ) break;
    if(Trim(List->Strings[i]) != "")
      EColumns.Add(List->Names[i], StrToBoolDef(Trim(List->Values[List->Names[i]]),false));
  }
}

void TRepInfo::LoadShablonList(TStrings* Des)
{
  Des->Clear();
  AnsiString TmpStr;
  int StartIndex = GetSectionIndex("[SHABLONS]");
  if(StartIndex != -1)
    for(int i = StartIndex; i < List->Count; i++)
    {
      TmpStr = List->Strings[i];
      if(IsSectionName(TmpStr)) break;
      if(Trim(List->Strings[i]) != "")
          Des->Add(Trim(List->Strings[i]));
    }
}

TRepInfo::TRepInfo()
{
  EIsOpen = false;
  EAutoLoad = true;
  List = new TStringList;
}

TRepInfo::~TRepInfo()
{
  List->Free();
}
