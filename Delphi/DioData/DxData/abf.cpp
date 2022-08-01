//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "abf.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TaboutForm *aboutForm;
//---------------------------------------------------------------------------
__fastcall TaboutForm::TaboutForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TaboutForm::Timer1Timer(TObject *Sender)
{
 Close();        
}
//---------------------------------------------------------------------------
void __fastcall TaboutForm::FormCreate(TObject *Sender)
{
 Brush->Style=bsClear;
}
//---------------------------------------------------------------------------
void __fastcall TaboutForm::FormActivate(TObject *Sender)
{
if(!noTimer)
 Timer1->Enabled=true;
}
//---------------------------------------------------------------------------
void __fastcall TaboutForm::FormClose(TObject *Sender,
      TCloseAction &Action)
{
 Timer1->Enabled=false;
}
//---------------------------------------------------------------------------
void __fastcall TaboutForm::Image1Click(TObject *Sender)
{
 if(noTimer)
        Close();        
}
//---------------------------------------------------------------------------

