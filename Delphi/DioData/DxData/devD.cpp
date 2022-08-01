//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "devD.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TdevDescr *devDescr;
//---------------------------------------------------------------------------
__fastcall TdevDescr::TdevDescr(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TdevDescr::Button1Click(TObject *Sender)
{
 ModalResult=mrCancel;
}
//---------------------------------------------------------------------------
void __fastcall TdevDescr::Button2Click(TObject *Sender)
{
 ModalResult=mrOk;
}
//---------------------------------------------------------------------------
