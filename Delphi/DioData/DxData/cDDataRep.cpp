//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "cDDataRep.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TDDataRep *DDataRep;
//---------------------------------------------------------------------------
__fastcall TDDataRep::TDDataRep(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
 