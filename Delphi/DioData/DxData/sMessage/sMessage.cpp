//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "sMessage.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TsMsg *sMsg;
//---------------------------------------------------------------------------
__fastcall TsMsg::TsMsg(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------


void __fastcall TsMsg::FormPaint(TObject *Sender)
{
TRect r;
 r.left=0; r.top=0; r.right=Width; r.bottom=Height;
 Canvas->Brush->Color=clBlack;
 Canvas->FrameRect(r);
}
//---------------------------------------------------------------------------

