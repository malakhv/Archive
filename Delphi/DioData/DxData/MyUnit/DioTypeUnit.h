//---------------------------------------------------------------------------
#ifndef DioTypeUnitH
#define DioTypeUnitH
#include <System.hpp>
#include <Classes.hpp>
//---------------------------------------------------------------------------

//typedef enum {dtNone = 0, dtDio2T4V = dio2T4V, dtDio2T3V = dio3T3V} TEnumDioType;

class TDioType
{
  private:
    byte EDioType;
    TNotifyEvent EOnChange;
    byte GetDioType();
    void SetDioType(byte Value);
    AnsiString GetDioTypeStr();
    void SetDioTypeStr(AnsiString Value);
  public:
    __property byte DioType = {read = GetDioType, write = SetDioType};
    __property AnsiString DioTypeStr = {read = GetDioTypeStr, write = SetDioTypeStr};
    __property TNotifyEvent OnChange = {read = EOnChange, write = EOnChange};
    static AnsiString DioTypeToStr(byte ADioType);
    static byte StrToDioType(AnsiString Str);
    TDioType();
};
#endif




