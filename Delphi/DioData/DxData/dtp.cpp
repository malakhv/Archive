//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "dtp.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TdtPreview *dtPreview;
//---------------------------------------------------------------------------
__fastcall TdtPreview::TdtPreview(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TdtPreview::QRExpr1Print(TObject *sender,
      AnsiString &Value)
{
 int    hPos=-1;
 int    i;
 AnsiString aVal="";

 if(Value.Length()==0)
        return;
 for(i=0;i<Value.Length()-1;i++) {
   if(Value[i+1]==';')
    hPos++;
   if((hPos==textColumn)&(Value[i+1]!=';'))
     aVal+=Value[i+1];
   if(hPos>textColumn)
        break;
   } // for

   float f;

        switch(textColumn) {
                case 1:
                   f=StrToFloat(aVal);
                   if(textLines==1)
                    {
                      smr.Qmax=f;
                      smr.Q=f;
                    } else
                     {
                       if(f>smr.Qmax) smr.Qmax=f;
                       if(f<smr.Q) smr.Q=f;
                     }
                 break;
                case 2:
                 f=StrToFloat(aVal);
                        if(f==0)
                          aVal="???"; else
                         {
                         smr.t1+=f;
                         smr.t1Cnts++;
                         }
                 break;
                case 3:
                 f=StrToFloat(aVal);
                        if(f==0)
                          aVal="???"; else
                         {
                         smr.t2+=f;
                         smr.t2Cnts++;
                         }
                 break;
                case 4:
                   f=StrToFloat(aVal);
                   if(textLines==1)
                    {
                      smr.v1max=f;
                      smr.v1=f;
                    } else
                     {
                       if(f>smr.v1max) smr.v1max=f;
                       if(f<smr.v1) smr.v1=f;
                     }
                 break;
                case 5:
                   f=StrToFloat(aVal);
                   if(textLines==1)
                    {
                      smr.v2max=f;
                      smr.v2=f;
                    } else
                     {
                       if(f>smr.v2max) smr.v2max=f;
                       if(f<smr.v2) smr.v2=f;
                     }
                 break;
                case 6:
                   f=StrToFloat(aVal);
                   if(textLines==1)
                    {
                      smr.v3max=f;
                      smr.v3=f;
                    } else
                     {
                       if(f>smr.v3max) smr.v3max=f;
                       if(f<smr.v3) smr.v3=f;
                     }
                 break;
                case 7:
                   f=StrToFloat(aVal);
                   if(textLines==1)
                    {
                      smr.v4max=f;
                      smr.v4=f;
                    } else
                     {
                       if(f>smr.v4max) smr.v4max=f;
                       if(f<smr.v4) smr.v4=f;
                     }
                 break;
                case 8:
                 break;
                case 9:
                 break;
        }
    textColumn++;
    Value=aVal;
 }
//---------------------------------------------------------------------------




void __fastcall TdtPreview::sband1BeforePrint(TQRCustomBand *Sender,
      bool &PrintBand)
{
        textColumn=0;
        textLines++;
}
//---------------------------------------------------------------------------
void __fastcall TdtPreview::QRBand4BeforePrint(TQRCustomBand *Sender,
      bool &PrintBand)
{
if(smr.t1Cnts!=0) smr.t1/=smr.t1Cnts;
if(smr.t2Cnts!=0) smr.t2/=smr.t2Cnts;
 qSum->Caption = FloatToStrF(smr.Qmax-smr.Q,ffFixed,12,2);
 t1Expr->Caption=(smr.t1Cnts!=0)?FloatToStrF(smr.t1,ffFixed,5,2):AnsiString("???");
 t2Expr->Caption=(smr.t2Cnts!=0)?FloatToStrF(smr.t2,ffFixed,5,2):AnsiString("???");
 v1Sum->Caption=FloatToStrF(smr.v1max-smr.v1,ffFixed,12,2);
 v2Sum->Caption=FloatToStrF(smr.v2max-smr.v2,ffFixed,12,2);
 v3Sum->Caption=FloatToStrF(smr.v3max-smr.v3,ffFixed,12,2);
 v4Sum->Caption=FloatToStrF(smr.v4max-smr.v4,ffFixed,12,2);
}
//---------------------------------------------------------------------------



void __fastcall TdtPreview::FormActivate(TObject *Sender)
{
  textLines=0;
  smr.t1Cnts=0;
  smr.t2Cnts=0;
}
//---------------------------------------------------------------------------




void __fastcall TdtPreview::QRBand1AfterPrint(TQRCustomBand *Sender,
      bool BandPrinted)
{
textLines=0;
smr.t1Cnts=0;
smr.t2Cnts=0;
smr.t1=0;
smr.t2=0;
}
//---------------------------------------------------------------------------


