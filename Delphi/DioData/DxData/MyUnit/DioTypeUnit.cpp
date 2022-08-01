//---------------------------------------------------------------------------
#pragma hdrstop
#include "DioTypeUnit.h"
#include "wincard\wcrd.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)

byte TDioType::GetDioType()
{
  return EDioType;
}

void TDioType::SetDioType(byte Value)
{
  EDioType = Value;
  if(EOnChange != NULL) EOnChange((TObject*)this);
}

AnsiString TDioType::GetDioTypeStr()
{
  return DioTypeToStr(EDioType);
}

void TDioType::SetDioTypeStr(AnsiString Value)
{
  DioType = StrToDioType(Value);
}

AnsiString TDioType::DioTypeToStr(byte ADioType)
{
  switch (ADioType) {
    case dio2T4V: return "dio2T4V";
    case dio3T3V: return "dio3T3V";
    default: return "UncType";
  }
}

byte TDioType::StrToDioType(AnsiString Str)
{
  if(Str == UpperCase("DIO2T4V")) return dio2T4V;
  if(Str == UpperCase("DIO3T3V")) return dio3T3V;
  return 0;
}

TDioType::TDioType()
{
  EDioType = dio2T4V;
}



