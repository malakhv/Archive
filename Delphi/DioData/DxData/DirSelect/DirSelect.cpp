//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "DirSelect.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cdiroutl"
#pragma resource "*.dfm"
Tods *ods;
//---------------------------------------------------------------------------
__fastcall Tods::Tods(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall Tods::Button1Click(TObject *Sender)
{
 Close();
}
//---------------------------------------------------------------------------


