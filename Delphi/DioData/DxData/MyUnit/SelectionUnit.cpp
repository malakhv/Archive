//---------------------------------------------------------------------------
#pragma hdrstop
#include "SelectionUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)

Variant TBaseOleObject::GetOleObject()
{
  return EOleObject;
}

void TBaseOleObject::SetOleObject(Variant Value)
{
  EOleObject = Value;
}

__fastcall TBaseOleObject::TBaseOleObject()
{
  VarClear(EOleObject);
}

__fastcall TBaseOleObject::~TBaseOleObject()
{
  //VarClear(EOleObject);
}

bool TBaseOleObject::GetIsEmpty()
{
  return OleObjectIsEmpty(EOleObject);
}

bool TBaseOleObject::OleObjectIsEmpty(Variant AOleObject)
{
  return VarIsEmpty(AOleObject) || VarIsNull(AOleObject);
}

//---------------------------------------------------------------------------

TBaseOleObject* TChildBaseObject::GetParent()
{
  return EParent;
}

void TChildBaseObject::SetParent(TBaseOleObject *Value)
{
  EParent = Value;
}

__fastcall TChildBaseObject::TChildBaseObject(TBaseOleObject *AParent)
{
  EParent = AParent;
}

__fastcall TChildBaseObject::TChildBaseObject()
{
  EParent = NULL;
}

//---------------------------------------------------------------------------

__fastcall TFind::TFind(TBaseOleObject *AParent)
{
  Parent = AParent;
  if(!AParent->IsEmpty)
    OleObject = AParent->OleObject.OlePropertyGet("Find");
}

AnsiString TFind::GetText()
{
  if(!IsEmpty)
    return (AnsiString) OleObject.OlePropertyGet("Text");
  else
    return "";
}

void TFind::SetText(AnsiString Value)
{
  if(!IsEmpty)
    OleObject.OlePropertySet("Text",Value.c_str());
}

bool TFind::GetForward()
{
  if(!IsEmpty)
    return (bool) OleObject.OlePropertyGet("Forward");
  else
    return false;
}

void TFind::SetForward(bool Value)
{
  if(!IsEmpty)
    OleObject.OlePropertySet("Forward",Value);
}

bool TFind::Execute()
{
  if(!IsEmpty)
    return (bool) OleObject.OleFunction("Execute");
  else
    return false;
}
//---------------------------------------------------------------------------

__fastcall TSelection::TSelection(TBaseOleObject *AParent)
{
  Parent = AParent;
  if(AParent != NULL)
    if(!AParent->IsEmpty)
      OleObject = AParent->OleObject.OlePropertyGet("Selection");
  EFind = new TFind(this);
}

TFind TSelection::GetFind()
{
  return *EFind;
}

void TSelection::SetFind(TFind Value)
{
  if(!Value.IsEmpty)
    EFind->OleObject = Value.OleObject;
}

AnsiString TSelection::GetText()
{
  if(!IsEmpty)
    return (AnsiString) OleObject.OlePropertyGet("Text");
  else
    return "";
}

void TSelection::SetText(AnsiString Value)
{
  if(!IsEmpty)
    OleObject.OlePropertySet("Text",Value.c_str());
}
//---------------------------------------------------------------------------
