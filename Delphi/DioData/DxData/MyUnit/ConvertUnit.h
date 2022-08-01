//---------------------------------------------------------------------------

#ifndef ConvertUnitH
#define ConvertUnitH
#include <System.hpp>
//---------------------------------------------------------------------------

class TConvert
{
  public:
    static AnsiString BollToStr(bool Value, byte Format = 1);
    static bool StrToBool(AnsiString Value);
};
#endif
