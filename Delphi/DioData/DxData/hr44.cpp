//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "hr44.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
ThrPreview44 *hrPreview44;
//---------------------------------------------------------------------------
__fastcall ThrPreview44::ThrPreview44(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------


void __fastcall ThrPreview44::hr44Print(TObject *sender,
      AnsiString &Value)
{
 //123
 int    hPos=-1;
 int    i,l1,l2,l3,l4;
 AnsiString aVal="";

  l1=smr.t1Cnts;
  l2=smr.t2Cnts;
  l3=smr.t3Cnts;
  l4=smr.t4Cnts;
 if(Value.Length()==0)
        return;
 for(i=11;i<Value.Length()-1;i++) {
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
                         l1++;
                         }
                 break;
                case 3:
                 f=StrToFloat(aVal);
                        if(f==0)
                          aVal="???"; else
                         {
                         smr.t2+=f;
                         l2++;
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
                      smr.Q1max=f;
                      smr.Q1=f;
                    } else
                     {
                       if(f>smr.Q1max) smr.Q1max=f;
                       if(f<smr.Q1) smr.Q1=f;
                     }
                 break;
                case 7:
                 f=StrToFloat(aVal);
                        if(f==0)
                          aVal="???"; else
                         {
                         smr.t3+=f;
                         l3++;
                         }
                 break;
                case 8:
                 f=StrToFloat(aVal);
                        if(f==0)
                          aVal="???"; else
                         {
                         smr.t4+=f;
                         l4++;
                         }
                 break;
                case 9:
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
                case 10:
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
                case 11:
                break;
                case 12:
                break;
        }
    textColumn++;
    Value=aVal;
  smr.t1Cnts=l1;
  smr.t2Cnts=l2;
  smr.t3Cnts=l3;
  smr.t4Cnts=l4;
}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::sband1BeforePrint(TQRCustomBand *Sender,
      bool &PrintBand)
{
   if(AnsiString(sband1->Items->Strings[sband1->Index].c_str(),11)!=";"+smd->Items->Strings[smd->Index])
           PrintBand=false;
        textColumn=0;
}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::FormCreate(TObject *Sender)
{
  textLines=1;
  hasNewPage=false;
  lastHr=0;
        
}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::qr2EndPage(TCustomQuickRep *Sender)
{
 textLines=1;
 hasNewPage=false;

}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::qr2StartPage(TCustomQuickRep *Sender)
{
 textLines=1;

}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::smdAfterPrint(TQRCustomBand *Sender,
      bool BandPrinted)
{
textLines=1;
smr.t1Cnts=0;
smr.t2Cnts=0;
smr.t3Cnts=0;
smr.t4Cnts=0;
smr.t1=0;
smr.t2=0;
smr.t3=0;
smr.t4=0;

}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::smbAfterPrint(TQRCustomBand *Sender,
      bool BandPrinted)
{
 textLines=1;
}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::smbBeforePrint(TQRCustomBand *Sender,
      bool &PrintBand)
{
  textColumn=0;
}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::sband1AfterPrint(TQRCustomBand *Sender,
      bool BandPrinted)
{
int i;
 i=textLines;
if(BandPrinted) {
 smb->Items->Clear();
 smb->Items->Add(";"+FloatToStrF(smr.Qmax-smr.Q,ffFixed,12,2)+
 ";"+((smr.t1Cnts!=0)?FloatToStrF(smr.t1/smr.t1Cnts,ffFixed,5,2):AnsiString("???"))+
 ";"+((smr.t2Cnts!=0)?FloatToStrF(smr.t2/smr.t2Cnts,ffFixed,5,2):AnsiString("???"))+
 ";"+FloatToStrF(smr.v1max-smr.v1,ffFixed,12,2)+
 ";"+FloatToStrF(smr.v2max-smr.v2,ffFixed,12,2)+
 ";"+FloatToStrF(smr.Q1max-smr.Q1,ffFixed,12,2)+
 ";"+((smr.t3Cnts!=0)?FloatToStrF(smr.t3/smr.t3Cnts,ffFixed,5,2):AnsiString("???"))+
 ";"+((smr.t4Cnts!=0)?FloatToStrF(smr.t4/smr.t4Cnts,ffFixed,5,2):AnsiString("???"))+
 ";"+FloatToStrF(smr.v3max-smr.v3,ffFixed,12,2)+
 ";"+FloatToStrF(smr.v4max-smr.v4,ffFixed,12,2)+";");
 i++;
 }
 textLines=i;

}
//---------------------------------------------------------------------------

void __fastcall ThrPreview44::hrTotalPrint(TObject *sender,
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

    textColumn++;
    Value=aVal;
       
}
//---------------------------------------------------------------------------

