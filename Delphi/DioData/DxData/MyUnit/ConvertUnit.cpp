//---------------------------------------------------------------------------
#pragma hdrstop
#include "ConvertUnit.h"
#include <SysUtils.hpp>
//---------------------------------------------------------------------------

#pragma package(smart_init)

static AnsiString BollToStr(bool Value, byte Format)
{
  AnsiString ResultStr;
  switch (Format) {
    case 1 :
              if(Value) ResultStr = "1";
              else ResultStr = "0";
              break;
    case 2 :
              if(Value) ResultStr = "true";
              else ResultStr = "false";
              break;
    default: ResultStr = "";
  }
  ResultStr = IntToStr((int) Value);
  return ResultStr;
}

static bool StrToBool(AnsiString Value)
{
  if(Value.UpperCase() == "true") return true;
  return StrToIntDef(Value,-10) > 0;
}
