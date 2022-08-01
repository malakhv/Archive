//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "SetIvl.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TsetIvlFrm *setIvlFrm;
//---------------------------------------------------------------------------
__fastcall TsetIvlFrm::TsetIvlFrm(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TsetIvlFrm::Button1Click(TObject *Sender)
{
  selected=true;
    Close();
}
//---------------------------------------------------------------------------
void __fastcall TsetIvlFrm::FormActivate(TObject *Sender)
{
 dtFrom->Date=Now();
 dtTo->Date=Now();
 selected=false;
}
//---------------------------------------------------------------------------

void __fastcall TsetIvlFrm::Button2Click(TObject *Sender)
{
Close();    
}
//---------------------------------------------------------------------------


