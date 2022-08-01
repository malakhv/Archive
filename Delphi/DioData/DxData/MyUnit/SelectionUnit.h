//---------------------------------------------------------------------------

#ifndef SelectionUnitH
#define SelectionUnitH
//---------------------------------------------------------------------------
#include <ComObj.hpp>
#include <sysvari.h>

class TBaseOleObject
{
  private:
    Variant EOleObject;
    Variant GetOleObject();
    void SetOleObject(Variant Value);
    bool GetIsEmpty();
  public:
    __property Variant OleObject = {read = GetOleObject, write = SetOleObject};
    __property bool IsEmpty = {read = GetIsEmpty};
    static bool OleObjectIsEmpty(Variant AOleObject);
    __fastcall TBaseOleObject();
    __fastcall ~TBaseOleObject();
};

class TChildBaseObject: public TBaseOleObject
{
  private:
    TBaseOleObject* EParent;
    TBaseOleObject* GetParent();
    void SetParent(TBaseOleObject *Value);
  public:
    __property TBaseOleObject* Parent = {read = GetParent, write = SetParent};
    __fastcall TChildBaseObject(TBaseOleObject *AParent);
    __fastcall TChildBaseObject();
};

class TFind: public TChildBaseObject
{
  private:
    AnsiString GetText();
    void SetText(AnsiString Value);
    bool GetForward();
    void SetForward(bool Value);
  public:
    __property AnsiString Text = {read = GetText, write = SetText};
    __property bool Forward = {read = GetForward, write = SetForward};
    bool Execute();
    __fastcall TFind(TBaseOleObject *AParent);
};

class TSelection: public TChildBaseObject
{
  private:
    TFind* EFind;
    TFind GetFind();
    void SetFind(TFind Value);
    AnsiString GetText();
    void SetText(AnsiString Value);
  public:
    __property TFind Find = {read = GetFind, write = SetFind};
    __property AnsiString Text = {read = GetText, write = SetText};
    __fastcall TSelection(TBaseOleObject *AParent);
};
#endif
