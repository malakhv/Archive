//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "prdIvlSet.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TprnIvl *prnIvl;
//---------------------------------------------------------------------------
__fastcall TprnIvl::TprnIvl(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TprnIvl::Button1Click(TObject *Sender)
{
 selected=true;
 Close();        
}
//---------------------------------------------------------------------------
void __fastcall TprnIvl::Button2Click(TObject *Sender)
{
 selected=false;
 Close();        
}
//---------------------------------------------------------------------------
void __fastcall TprnIvl::FormActivate(TObject *Sender)
{
 selected=false;
 prnIvlFrom->Date=dtFrom;
 prnIvlTo->Date=dtTo;
 fsCombo->ItemIndex=0;
}
//---------------------------------------------------------------------------
void __fastcall TprnIvl::Button3Click(TObject *Sender)
{
 for(int i=0;i<clb->Items->Count;i++) clb->Checked[i]=true;
}
//---------------------------------------------------------------------------

void __fastcall TprnIvl::Button4Click(TObject *Sender)
{
 for(int i=0;i<clb->Items->Count;i++) clb->Checked[i]=false;
}
//---------------------------------------------------------------------------

void __fastcall TprnIvl::cbNakopClick(TObject *Sender)
{
  Nakop = cbNakop->Checked;  
}
//---------------------------------------------------------------------------

