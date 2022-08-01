//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "dmf.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TdampForm *dampForm;
//---------------------------------------------------------------------------
__fastcall TdampForm::TdampForm(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TdampForm::FormPaint(TObject *Sender)
{
    dm->Clear();
    dm->Lines->Add("     00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F");
    int absaddr=0;
   for(int j=0;j<4;j++)
   {
   AnsiString st=IntToHex(j,3)+"0";
    for(int i=0;i<16;i++)
     st+=" "+IntToHex(pa[absaddr++],2);

     dm->Lines->Add(st);
    }

    dm1->Clear();
    dm1->Lines->Add("     00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F");
    absaddr=0;
   for(int j=0;j<4;j++)
   {
   AnsiString st=IntToHex(j,3)+"0";
    for(int i=0;i<16;i++)
     st+=" "+IntToHex(pa0[absaddr++],2);

     dm1->Lines->Add(st);
    }
}
//---------------------------------------------------------------------------
