//---------------------------------------------------------------------------
#include <excpt.h>
#include <vcl.h>
#include <FDCon.h>
#include <cVals.h>
#include <stdio.h>
#include <math.h>
#include <Clipbrd.hpp>
#include <dir.h>
#pragma hdrstop

#include "devD.h"
#include "dmf.h"
#include "abf.h"
#include "ddata.h"
#include "dtp.h"
#include "dtp3.h"
#include "dtp4.h"
#include "sMessage.h"
#include "dfr.h"
#include "SetIvl.h"
#include "configForm.h"
#include "prdIvlSet.h"
#include "hrRep.h"
#include "hr44.h"
#include "dtform.h"
#include "wincard\wcrd.h"
#include "WordExprtUnit.h"
#include "WrdUnit.h"
#include "ExportMasterUnit.h"
#include "SelectionUnit.h"
#include "ExportProgresUnit.h"
#include "ReportUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

#define bDate   __DATE__

double cnvVal=1.0000025500065280167117227820103;
bool dstsShow = false;
AnsiString devAbout;

fDescript desc;

LPSTR com_char="COM1";
TForm1 *Form1;
TList *HDLines;
TList *DDLines;
PHData  astr;
CSData  csdt;
int MouseX,MouseY;
LPSTR W_MSG1 =  "Проверьте надежность соединения\n"
                "кабеля RS-232 с прибором и корректность\n"
                "установки ноиера COM порта в пункте\n"
                "меню 'Порт'";

   unsigned int	  aargb0;
   unsigned int   aargb1;
   unsigned int   aargb2;
   unsigned int   aexp;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
}

//---------------------------------------------------------------------------

float far TForm1::Dec_2_Float(unsigned char ex,unsigned char a1,unsigned char a2,
                        unsigned char a3)
{
  double                        t,e;
  unsigned long			k1,k2;
  double                         z;

if(a1>127)
 return 0;
if( (ex==255)|(a1==255))
 return 0;
if(ex>100)
 return 0;
if (ex==0)
 {
  return 0;
 } else {
      k1=((a1 + 0x80))*65536 + a2*256 + a3;
      t=0;
      e = ex - 0x27;
     for(int i = 0;i!=-23;i--)
     {
       k2 = k1;
      if (k2 & 0x800000)
       {
         t+=powl(2,double(i));
       }
      k1<<=1;
     }
     z=powl(2.,double(e))*t;
    return z;
  }
}

void  TForm1::Float_2_Dec(float iee)
{
float   x,z;
int	  e,k,t;
long    b;
const   n=24;

 if (iee==0)
  {
   aexp=0;
   aargb0=0;
   aargb1=0;
   aargb2=0;
  } else {
		  b=0;
		  z=log(iee)/log(2);
		  e=int(z);
			if (e<=z)
			 {
			 e++;
			 }
			  x=iee/(pow(2,e));
			  k=1;
			 while (k<=n)
			  {
             b=b<<1;
             if (x>=pow(2,-k))
             {
             	t=1;
               b++;
             } else
             {
              t=0;
	          };
         	x=x-t*pow(2,-k);
           k++;
	        }
         e+=38;
        b=b-pow(2,23);

 aexp=e;

 aargb0=(b >> 16) & 0xff;
 aargb1=(b >> 8) & 0xff;
 aargb2=(b & 0xff);
 };
}


//---------------------------------------------------------------------------
void TForm1::storePHDataL(PHData astr,unsigned char *recvBuf)
{
char buf[20];
        sprintf(buf,"%02i.%02i.%04i",recvBuf[0],recvBuf[1],2000+recvBuf[2]);
        astr->dt=buf;
        astr->hr=recvBuf[3];
  if(csdt.dioType==dio2T4V) {
        astr->Q=Dec_2_Float(recvBuf[7],recvBuf[4],recvBuf[5],recvBuf[6]);
        astr->t1=Dec_2_Float(recvBuf[10],recvBuf[8],recvBuf[9],0);
        astr->t2=Dec_2_Float(recvBuf[13],recvBuf[11],recvBuf[12],0);
        }
  if(csdt.dioType==dio3T3V) {
        astr->Q=Dec_2_Float(recvBuf[7],recvBuf[4],recvBuf[5],recvBuf[6]);
        astr->t1=float(recvBuf[8]*256+recvBuf[9])/100;
        astr->t2=float(recvBuf[10]*256+recvBuf[11])/100;
        astr->t3=float(recvBuf[12]*256+recvBuf[13])/100;
         if((astr->t1>180)||(astr->t1<0)) astr->t1=0;
         if((astr->t2>180)||(astr->t2<0)) astr->t2=0;
         if((astr->t3>180)||(astr->t3<0)) astr->t3=0;
        }
  if(csdt.dioType==dio4T4V) {
  /// --- !!!
        astr->Q=cnvVal*Dec_2_Float(recvBuf[6],recvBuf[4],recvBuf[5],0);
        astr->t1=float(recvBuf[7]*256+recvBuf[8])/100;
        astr->t2=float(recvBuf[9]*256+recvBuf[10])/100;
        astr->V1=cnvVal*Dec_2_Float(recvBuf[13],recvBuf[11],recvBuf[12],0);
        astr->V2=cnvVal*Dec_2_Float(recvBuf[16],recvBuf[14],recvBuf[15],0);
        astr->Q1=cnvVal*Dec_2_Float(recvBuf[19],recvBuf[17],recvBuf[18],0);
        astr->t3=float(recvBuf[20]*256+recvBuf[21])/100;
        astr->t4=float(recvBuf[22]*256+recvBuf[23])/100;
        astr->V3=cnvVal*Dec_2_Float(recvBuf[26],recvBuf[24],recvBuf[25],0);
        astr->V4=cnvVal*Dec_2_Float(recvBuf[29],recvBuf[27],recvBuf[28],0);

        if((astr->t1>180)||(astr->t1<1)) {
                astr->t1=0; astr->t2=0; }

        if((astr->t2>180)||(astr->t2<1)) {
                astr->t1=0; astr->t2=0; }

        if((astr->t3>180)||(astr->t3<1)) {
                astr->t3=0; astr->t4=0; }

        if((astr->t4>180)||(astr->t4<1)) {
                astr->t3=0; astr->t4=0; }

        }
  if((csdt.dioType==dio3T3V)|(csdt.dioType==dio2T4V)) {
        astr->V1=Dec_2_Float(recvBuf[17],recvBuf[14],recvBuf[15],recvBuf[16]);
        astr->V2=Dec_2_Float(recvBuf[21],recvBuf[18],recvBuf[19],recvBuf[20]);
        astr->V3=Dec_2_Float(recvBuf[25],recvBuf[22],recvBuf[23],recvBuf[24]);
        astr->V4=Dec_2_Float(recvBuf[29],recvBuf[26],recvBuf[27],recvBuf[28]);
        astr->Q1=astr->V4;
        }
      astr->ta=recvBuf[30]-103;
      astr->Ubat=recvBuf[31]*0.0214647888;
}

void TForm1::storePHDataH(PHData astr,unsigned char *recvBuf)
{
char buf[20];
        sprintf(buf,"%02i.%02i.%04i",recvBuf[32],recvBuf[33],2000+recvBuf[34]);
        astr->dt=buf;
        astr->hr=recvBuf[35];
  if(csdt.dioType==dio2T4V) {
        astr->Q=Dec_2_Float(recvBuf[39],recvBuf[36],recvBuf[37],recvBuf[38]);
        astr->t1=Dec_2_Float(recvBuf[42],recvBuf[40],recvBuf[41],0);
        astr->t2=Dec_2_Float(recvBuf[45],recvBuf[43],recvBuf[44],0);
        }
  if(csdt.dioType==dio3T3V) {
        astr->Q=Dec_2_Float(recvBuf[39],recvBuf[36],recvBuf[37],recvBuf[38]);
        astr->t1=float(recvBuf[40]*256+recvBuf[41])/100;
        astr->t2=float(recvBuf[42]*256+recvBuf[43])/100;
        astr->t3=float(recvBuf[44]*256+recvBuf[45])/100;
         if((astr->t1>180)||(astr->t1<0)) astr->t1=0;
         if((astr->t2>180)||(astr->t2<0)) astr->t2=0;
         if((astr->t3>180)||(astr->t3<0)) astr->t3=0;
        }
  if(csdt.dioType==dio4T4V) {
  /// --- !!!
        astr->Q=cnvVal*Dec_2_Float(recvBuf[38],recvBuf[36],recvBuf[37],0);
        astr->t1=float(recvBuf[39]*256+recvBuf[40])/100;
        astr->t2=float(recvBuf[41]*256+recvBuf[42])/100;
        astr->V1=cnvVal*Dec_2_Float(recvBuf[45],recvBuf[43],recvBuf[44],0);
        astr->V2=cnvVal*Dec_2_Float(recvBuf[48],recvBuf[46],recvBuf[47],0);
        astr->Q1=cnvVal*Dec_2_Float(recvBuf[51],recvBuf[49],recvBuf[50],0);
        astr->t3=float(recvBuf[52]*256+recvBuf[53])/100;
        astr->t4=float(recvBuf[54]*256+recvBuf[55])/100;
        astr->V3=cnvVal*Dec_2_Float(recvBuf[58],recvBuf[56],recvBuf[57],0);
        astr->V4=cnvVal*Dec_2_Float(recvBuf[61],recvBuf[59],recvBuf[60],0);

        if((astr->t1>180)||(astr->t1<1)) {
                astr->t1=0; astr->t2=0; }

        if((astr->t2>180)||(astr->t2<1)) {
                astr->t1=0; astr->t2=0; }

        if((astr->t3>180)||(astr->t3<1)) {
                astr->t3=0; astr->t4=0; }

        if((astr->t4>180)||(astr->t4<1)) {
                astr->t3=0; astr->t4=0; }
        }

  if((csdt.dioType==dio3T3V)|(csdt.dioType==dio2T4V)) {
        astr->V1=Dec_2_Float(recvBuf[49],recvBuf[46],recvBuf[47],recvBuf[48]);
        astr->V2=Dec_2_Float(recvBuf[53],recvBuf[50],recvBuf[51],recvBuf[52]);
        astr->V3=Dec_2_Float(recvBuf[57],recvBuf[54],recvBuf[55],recvBuf[56]);
        astr->V4=Dec_2_Float(recvBuf[61],recvBuf[58],recvBuf[59],recvBuf[60]);
         astr->Q1=astr->V4;
       }
        astr->ta=recvBuf[62]-103;
        astr->Ubat=recvBuf[63]*0.0214647888;
}

//---------------------------------------------------------------------------

void __fastcall TForm1::ToolButton2Click(TObject *Sender)
{
byte recvBuf[64];
char buf[100];
bool noNeedCnt=false;
bool dtExist=false;
bool timeOut = false;
bool toDayData=false;           // преобразование в суточные из почасовых
allSaved=false;

if(RefCombo->ItemIndex==-1)
{
 RefCombo->DroppedDown=true;
} else {
    DCon->ClearCntrs();
    DCon->ConPB->Position=0;

if(RefCombo->ItemIndex!=7)
 {
  if(!getCSData(&csdt))
            return;
     csdt.archCompDate=Now();

    updateCoolBar();
 }
     cdiPanel->Visible=true;
    switch(RefCombo->ItemIndex)
    {
//-----------------------------------------------------
//---- все суточные показания
//-----------------------------------------------------
    case(0): {
    DSel->Clear();
    ClearHData();
    delete HDLines;
    HDLines = new TList;
    AnsiString   cdate;
    int addr = 0x40;
    int maxk = 511;
    int Crc,Crc1;
    bool recvOk = false;
    DCon->ConPB->Max=maxk;
        DCon->Show();
        DCon->Invalidate();
        DCon->Repaint();
           DCon->OpenConnection(com_char);
           DCon->delayMilliSeconds(100);
    for(int k=0;k<maxk;k++)
    {
    DCon->ConPB->Position=k;
    recvOk=false;
      while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa2);
        DCon->SendByteSeq((byte)(addr/256));
        DCon->SendByteSeq((byte)(addr));
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }

     if(!timeOut) break;

  if((recvBuf[0]==0xff)||(recvBuf[32]==0xff)) { noNeedCnt=true; }
    if((recvBuf[0]<=31)&(recvBuf[0]!=0)) {
     astr=new THData;
     sprintf(buf,"%02i.%02i.%04i",recvBuf[0],recvBuf[1],2000+recvBuf[2]);
        cdate=buf;
        storePHDataL(astr,recvBuf);
     HDLines->Add(astr);
      }

   if((recvBuf[32]<=31)&(recvBuf[32]!=0)) {
     astr=new THData;
     sprintf(buf,"%02i.%02i.%04i",recvBuf[32],recvBuf[33],2000+recvBuf[34]);
        cdate=buf;
        storePHDataH(astr,recvBuf);
     HDLines->Add(astr);
      }

      if(noNeedCnt) break;
     addr+=0x40;
    }
    DCon->CloseConnection();
    if(!timeOut)
       MessageBox(NULL,W_MSG1,"Ошибка соединения",MB_OK|MB_ICONEXCLAMATION);
    DCon->Hide();
   break;
     } // case
//-----------------------------------------------------
//---- суточные за текущий месяц
//-----------------------------------------------------
    case(1):
    {
    unsigned short currentMonth,currentYear,currentDay;
    TDateTime currentDate=Date();
    currentDate.DecodeDate(&currentYear,&currentMonth,&currentDay);
        ClearHData();
        delete HDLines;
        HDLines = new TList;
        int Crc, Crc1;
        bool recvOk = false;
        int currentAddr,addr,maxk;
        DCon->Show();
        DCon->OpenConnection(com_char);
     // получение текущего адреса архива суточных показаний
      while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa2);
        DCon->SendByteSeq(0);
        DCon->SendByteSeq(0);
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }
      if(recvOk==true)
       {
         currentAddr=recvBuf[2]*256+recvBuf[3];
         addr=currentAddr-currentDay*32; // смещение к началу месяца
         maxk=ceil(currentDay/2)+1;
         DCon->ConPB->Max=maxk;
          for(int k=0;k<maxk;k++)
          {
            DCon->ConPB->Position=k;
            recvOk=false;
              while(!recvOk) {
                timeOut=DCon->SendByteSeq(0x1e);
             if(!timeOut) break;
                DCon->SendByteSeq(0xa2);
                DCon->SendByteSeq((byte)(addr/256));
                DCon->SendByteSeq((byte)(addr));
                Crc=0;
                for(int i=0;i<64;i++) {
                recvBuf[i]=DCon->RecvByte();
                Crc+=(byte)(64-i)^recvBuf[i];
                if(DCon->UserCancelled) break;
                }
               Crc1=DCon->RecvByte()*256+DCon->RecvByte();
              recvOk=(Crc==Crc1)?true:false;
              } // while
         if(!timeOut) break;

         if(!DCon->UserCancelled)
          {
        if((recvBuf[0]<=31)&(recvBuf[0]!=0)) {
         astr=new THData;
            storePHDataL(astr,recvBuf);
          HDLines->Add(astr);
          }
       if((recvBuf[32]<=31)&(recvBuf[32]!=0)) {
        astr=new THData;
            storePHDataH(astr,recvBuf);
          HDLines->Add(astr);
          }

          } // if(!DCon->UserCancelled)
         addr+=0x40;
          } // for
       }
    if(!timeOut)
       MessageBox(NULL,W_MSG1,"Ошибка соединения",MB_OK|MB_ICONEXCLAMATION);
     DCon->CloseConnection();
     DCon->Hide();
    break;
    }
//-----------------------------------------------------
//---- суточные за указанный промежуток
//-----------------------------------------------------
    case(2):
    {
    unsigned short currentMonth,currentYear,currentDay;
    TDateTime currentDate=Date();
    TDateTime ddtFrom,ddtTo;
    currentDate.DecodeDate(&currentYear,&currentMonth,&currentDay);
        ClearHData();
        delete HDLines;
        HDLines = new TList;
        int Crc, Crc1;
        bool recvOk = false;
        int currentAddr,fromAddr,toAddr,addr,maxk;
         setIvlFrm->ShowModal();
   if(setIvlFrm->selected)
   {
     // получение текущего адреса архива суточных показаний
       DCon->Show();
       DCon->OpenConnection(com_char);
       while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa2);
        DCon->SendByteSeq(0);
        DCon->SendByteSeq(0);
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }
      if(recvOk==true)
       {
        currentAddr=recvBuf[2]*256+recvBuf[3];  // адрес текущей даты
        ddtFrom=(ddtFrom>currentDate)?currentDate:setIvlFrm->dtFrom->Date;
        ddtTo=(setIvlFrm->dtTo->Date<ddtFrom)?ddtFrom:setIvlFrm->dtTo->Date;

        toAddr=(currentDate<ddtTo)?currentAddr:currentAddr-(int)(currentDate-ddtTo)*32-64;
        if(toAddr<0x80) toAddr=0x80;
        fromAddr=(currentDate<ddtFrom)?currentAddr:currentAddr-(int)(currentDate-ddtFrom)*32-64;
        if(fromAddr<0x40) fromAddr=0x40;

        maxk=((toAddr-fromAddr)>0)?(ceil((toAddr-fromAddr)/64)+1):1;
        DCon->ConPB->Max=maxk;
        sprintf(buf,"%i\n%i\n%i",fromAddr,toAddr,maxk);
//        MessageBox(NULL,buf,"",MB_OK|MB_ICONEXCLAMATION);
        addr=fromAddr;
          for(int k=0;k<maxk;k++)
          {
            DCon->ConPB->Position=k;
            recvOk=false;
              while(!recvOk) {
                timeOut=DCon->SendByteSeq(0x1e);
             if(!timeOut) break;
                DCon->SendByteSeq(0xa2);
                DCon->SendByteSeq((byte)(addr/256));
                DCon->SendByteSeq((byte)(addr));
                Crc=0;
                for(int i=0;i<64;i++) {
                recvBuf[i]=DCon->RecvByte();
                Crc+=(byte)(64-i)^recvBuf[i];
                if(DCon->UserCancelled) break;
                }
               Crc1=DCon->RecvByte()*256+DCon->RecvByte();
              recvOk=(Crc==Crc1)?true:false;
              } // while
        if(!timeOut) break;

        if(!DCon->UserCancelled)
          {
        if((recvBuf[0]<=31)&(recvBuf[0]!=0)) {
         astr=new THData;
            storePHDataL(astr,recvBuf);
          HDLines->Add(astr);
          }
      if((addr+0x20)<=toAddr)
       if((recvBuf[32]<=31)&(recvBuf[32]!=0)) {
        astr=new THData;
            storePHDataH(astr,recvBuf);
          HDLines->Add(astr);
          }

          } // if(!DCon->UserCancelled)
         addr+=0x40;
          } // for
       }
   if(!timeOut)
       MessageBox(NULL,W_MSG1,"Ошибка соединения",MB_OK|MB_ICONEXCLAMATION);
     DCon->CloseConnection();
     DCon->Hide();
     } // if
     break;
    }
//-----------------------------------------------------
//---- все почасовые показания
//-----------------------------------------------------
    case(5):
    {
//    if(Application->MessageBox("Передача полного архива часовых\nпоказаний может занять от 6 до 8 минут.\nНачать процесс передачи?","Внимание",MB_OKCANCEL+MB_ICONEXCLAMATION)!=IDOK)
//        break;
    DSel->Clear();
    ClearHData();
    delete HDLines;
    HDLines = new TList;
    AnsiString   cdate;
    int addr = 0x40;
    int maxk = 511;
    int Crc,Crc1;
    bool recvOk = false;

    DCon->ConPB->Max=maxk;

        DCon->Show();
        DCon->Invalidate();
        DCon->Repaint();
           DCon->OpenConnection(com_char);
           DCon->delayMilliSeconds(100);

    for(int k=0;k<maxk;k++)
    {
    DCon->ConPB->Position=k;
    recvOk=false;
      while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa0);
        DCon->SendByteSeq((byte)(addr/256));
        DCon->SendByteSeq((byte)(addr));
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }

     if(!timeOut) break;

  if(!DCon->UserCancelled)
  {
  if((recvBuf[0]==0xff)||(recvBuf[32]==0xff)) { noNeedCnt=true; }
    if((recvBuf[0]<=31)&(recvBuf[0]!=0)) {
     astr=new THData;
     sprintf(buf,"%02i.%02i.%04i",recvBuf[0],recvBuf[1],2000+recvBuf[2]);
        cdate=buf;
        storePHDataL(astr,recvBuf);

     dtExist=false;
     if(DSel->Items->Count!=0)
      for(int j=0;j<DSel->Items->Count;j++) {
       if(cdate==DSel->Items->Strings[j]) {
        dtExist=true;
        break; }
            }
       if(!dtExist)
         DSel->Items->Add(cdate);
     HDLines->Add(astr);
      }

   if((recvBuf[32]<=31)&(recvBuf[32]!=0)) {
     astr=new THData;
     sprintf(buf,"%02i.%02i.%04i",recvBuf[32],recvBuf[33],2000+recvBuf[34]);
        cdate=buf;
            storePHDataH(astr,recvBuf);

     dtExist=false;
     if(DSel->Items->Count!=0)
      for(int j=0;j<DSel->Items->Count;j++) {
       if(cdate==DSel->Items->Strings[j]) {
        dtExist=true;
        break; }
        }
       if(!dtExist)
         DSel->Items->Add(cdate);
     HDLines->Add(astr);
      }
//
    addr+=0x40;
    DCon->Invalidate();
    DCon->Repaint();
    if(noNeedCnt) break;
    } else { break; }
    }
        DCon->CloseConnection();
    if(!timeOut)
       MessageBox(NULL,W_MSG1,"Ошибка соединения",MB_OK|MB_ICONEXCLAMATION);
        DCon->Hide();
    DSel->ItemIndex=0;
       break;   // 5
      }
//
// данные из карты
//
    case(7):
    {
    int ofs=64;
    AnsiString   cdate;
        cardMan->ShowModal();
   if(cardMan->eDataValid)
      {
  // заполнение ifo-структуры
   memcpy(recvBuf,cardMan->eData,64);
   csdt.dioType=recvBuf[0x3e];

   if((csdt.dioType != dio2T4V) || (csdt.dioType != dio4T4V) || (csdt.dioType != dio3T3V))
        csdt.dioType = dio2T4V;

   csdt.Q=Dec_2_Float(recvBuf[5],recvBuf[2],recvBuf[3],recvBuf[4]);
   csdt.V1=Dec_2_Float(recvBuf[19],recvBuf[16],recvBuf[17],recvBuf[18]);
   csdt.V2=Dec_2_Float(recvBuf[23],recvBuf[20],recvBuf[21],recvBuf[22]);
   csdt.V3=Dec_2_Float(recvBuf[27],recvBuf[24],recvBuf[25],recvBuf[26]);
   csdt.V4=Dec_2_Float(recvBuf[31],recvBuf[28],recvBuf[29],recvBuf[30]);
   csdt.m1=Dec_2_Float(recvBuf[35],recvBuf[32],recvBuf[33],recvBuf[34]);
   csdt.m2=Dec_2_Float(recvBuf[39],recvBuf[36],recvBuf[37],recvBuf[38]);
   csdt.k1=Dec_2_Float(recvBuf[43],recvBuf[40],recvBuf[41],recvBuf[42]);
   csdt.k2=Dec_2_Float(recvBuf[47],recvBuf[44],recvBuf[45],recvBuf[46]);
   csdt.k3=Dec_2_Float(recvBuf[51],recvBuf[48],recvBuf[49],recvBuf[50]);
   csdt.k4=csdt.k3;
   csdt.t1=Dec_2_Float(recvBuf[9],recvBuf[6],recvBuf[7],recvBuf[8]);
   csdt.t2=Dec_2_Float(recvBuf[13],recvBuf[10],recvBuf[11],recvBuf[12]);
   csdt.bs=recvBuf[15]*0.0214647888;
   csdt.ta=recvBuf[14]-103;
   csdt.snum=recvBuf[0x3c]*256+recvBuf[0x3d];
   csdt.hrs=recvBuf[52]+recvBuf[53]*256;
   csdt.refComboIndex=RefCombo->ItemIndex;

   csdt.archCompDate=Now();

            DSel->Clear();
            ClearHData();
            delete HDLines;
            HDLines = new TList;
            toDayData=cardMan->toDayData->Checked;
        while(ofs<32768) {
         memcpy(recvBuf,&(cardMan->eData[ofs]),32);
         ofs+=32;
          if((recvBuf[0]<=31)&(recvBuf[0]!=0)) {
          astr=new THData;
            storePHDataL(astr,recvBuf);
              HDLines->Add(astr);
            sprintf(buf,"%02i.%02i.%04i",recvBuf[0],recvBuf[1],2000+recvBuf[2]);
            cdate=buf;
            dtExist=false;
             if(!toDayData) {                   //почасовые
                if(DSel->Items->Count!=0)
                        for(int j=0;j<DSel->Items->Count;j++) {
                        if(cdate==DSel->Items->Strings[j]) {
                        dtExist=true;
                        break; } //if
                        } //for
                if(!dtExist)
                        DSel->Items->Add(cdate);
                } // if
            } //if!toDayData
        } // while
       timeOut=true;
       DSel->ItemIndex=0;
     updateCoolBar();
   } // if
   else
   {
   allSaved=true;
    }
    break;
    }           // 7
    } // switch
    if(timeOut) {
 sMsg->Show();
 sMsg->Update();
Screen->Cursor = crHourGlass;
    SortListByDate();
    if(toDayData) {              //преобразование в суточные (если надо)
    RefCombo->ItemIndex=0;
    csdt.refComboIndex=0;
     int element=0;
     AnsiString tmpDate;
     tmpDate=((PHData)HDLines->Items[0])->dt;
        while(1) {
           astr=(PHData)HDLines->Items[element+1];
           if(astr->dt==tmpDate)
                 HDLines->Delete(element);
               else
                {
                 tmpDate=astr->dt;
                 element++;
                }
           if(element>=(HDLines->Count-1))
                break;
        } //while
    }
Screen->Cursor = crArrow;
 sMsg->Hide();
    UpdateHGrid();
    UpdateGraps();
     }
   } // else
 sb1->SimpleText="Считано "+IntToStr(HDLines->Count)+" строк.";
}
//---------------------------------------------------------------------------
// обновление сетки почасовых показаний
void TForm1::UpdateHGrid()
{
     AnsiString cdate;
     PHData  astr = new THData;
     cdate=DSel->Items->Strings[DSel->ItemIndex];
     DF->DGrid->FixedRows=0;
     DF->DGrid->RowCount=1;


     switch(csdt.dioType) {
     case(dio2T4V):
        DF->DGrid->ColCount=10;
        DF->DGrid->Cells[0][0]="Дата";
        DF->DGrid->Cells[1][0]="Q";
        DF->DGrid->Cells[2][0]="t1";
        DF->DGrid->Cells[3][0]="t2";
        DF->DGrid->Cells[4][0]="V1";
        DF->DGrid->Cells[5][0]="V2";
        DF->DGrid->Cells[6][0]="V3";
        DF->DGrid->Cells[7][0]="V4";
        DF->DGrid->Cells[8][0]="t окр.";
        DF->DGrid->Cells[9][0]="Бат.";
     break;
     case(dio3T3V):
        DF->DGrid->ColCount=11;
        DF->DGrid->Cells[0][0]="Дата";
        DF->DGrid->Cells[1][0]="Q отопл.";
        DF->DGrid->Cells[2][0]="t под.";
        DF->DGrid->Cells[3][0]="t обр.";
        DF->DGrid->Cells[4][0]="V под.";
        DF->DGrid->Cells[5][0]="V обр.";
        DF->DGrid->Cells[6][0]="Q гвс.";
        DF->DGrid->Cells[7][0]="t гвс.";
        DF->DGrid->Cells[8][0]="V гвс.";
        DF->DGrid->Cells[9][0]="t окр.";
        DF->DGrid->Cells[10][0]="Бат.";
       break;
     case(dio4T4V):
        DF->DGrid->ColCount=13;
        DF->DGrid->Cells[0][0]="Дата";
        DF->DGrid->Cells[1][0]="Q1.";
        DF->DGrid->Cells[2][0]="t1 под.";
        DF->DGrid->Cells[3][0]="t2 обр.";
        DF->DGrid->Cells[4][0]="V1 под.";
        DF->DGrid->Cells[5][0]="V2 обр.";
        DF->DGrid->Cells[6][0]="Q2";
        DF->DGrid->Cells[7][0]="t3 под. .";
        DF->DGrid->Cells[8][0]="t4 обр.";
        DF->DGrid->Cells[9][0]="V3 под.";
        DF->DGrid->Cells[10][0]="V4 обр.";
        DF->DGrid->Cells[11][0]="t окр.";
        DF->DGrid->Cells[12][0]="Бат.";
       break;
     } //switch
 if(RefCombo->ItemIndex<3) {
  DF->DGrid->Cells[0][0]="Дата";

  int  CurRow=1;
     if(HDLines->Count!=0)
       for(int i=0;i<HDLines->Count;i++)
       {
         astr=(PHData)HDLines->Items[i];
                DF->DGrid->RowCount++;
           if(csdt.dioType==dio2T4V) {
                DF->DGrid->Cells[0][CurRow]=astr->dt;
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->V4,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[9][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
                }
           if(csdt.dioType==dio3T3V) {
                DF->DGrid->Cells[0][CurRow]=astr->dt;
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->Q1,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->t3,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[9][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[10][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
              }
           if(csdt.dioType==dio4T4V) {
                DF->DGrid->Cells[0][CurRow]=astr->dt;
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->Q1,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->t3,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=FloatToStrF(astr->t4,ffFixed,10,2);
                DF->DGrid->Cells[9][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[10][CurRow]=FloatToStrF(astr->V4,ffFixed,10,2);
                DF->DGrid->Cells[11][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[12][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
              }
                CurRow++;
       }
   if(DF->DGrid->RowCount<2) DF->DGrid->RowCount=2;
   DF->DGrid->FixedRows=1;
 }
 if(RefCombo->ItemIndex>=3) {
  DF->DGrid->Cells[0][0]="Время";
  int   CurRow=1;
     if(HDLines->Count!=0)
       for(int i=0;i<HDLines->Count;i++)
       {
         astr=(PHData)HDLines->Items[i];
            if(astr->dt==cdate)
             {
                DF->DGrid->RowCount++;
           if(csdt.dioType==dio2T4V) {
                DF->DGrid->Cells[0][CurRow]=IntToStr(astr->hr)+":00";
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->V4,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[9][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
                }
           if(csdt.dioType==dio3T3V) {
                DF->DGrid->Cells[0][CurRow]=IntToStr(astr->hr)+":00";
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->Q1,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->t3,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[9][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[10][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
              }
           if(csdt.dioType==dio4T4V) {
                DF->DGrid->Cells[0][CurRow]=IntToStr(astr->hr)+":00";
                DF->DGrid->Cells[1][CurRow]=FloatToStrF(astr->Q,ffFixed,10,2);
                DF->DGrid->Cells[2][CurRow]=FloatToStrF(astr->t1,ffFixed,10,2);
                DF->DGrid->Cells[3][CurRow]=FloatToStrF(astr->t2,ffFixed,10,2);
                DF->DGrid->Cells[4][CurRow]=FloatToStrF(astr->V1,ffFixed,10,2);
                DF->DGrid->Cells[5][CurRow]=FloatToStrF(astr->V2,ffFixed,10,2);
                DF->DGrid->Cells[6][CurRow]=FloatToStrF(astr->Q1,ffFixed,10,2);
                DF->DGrid->Cells[7][CurRow]=FloatToStrF(astr->t3,ffFixed,10,2);
                DF->DGrid->Cells[8][CurRow]=FloatToStrF(astr->t4,ffFixed,10,2);
                DF->DGrid->Cells[9][CurRow]=FloatToStrF(astr->V3,ffFixed,10,2);
                DF->DGrid->Cells[10][CurRow]=FloatToStrF(astr->V4,ffFixed,10,2);
                DF->DGrid->Cells[11][CurRow]=IntToStr((int)astr->ta);
                DF->DGrid->Cells[12][CurRow]=FloatToStrF(astr->Ubat,ffFixed,10,2);
              }
                CurRow++;
             }
       }
 if(DF->DGrid->RowCount<2) DF->DGrid->RowCount=2;
 DF->DGrid->FixedRows=1;
 }
}


void __fastcall TForm1::RefComboChange(TObject *Sender)
{
   switch(RefCombo->ItemIndex){
    case 0:
        DSel->Enabled=false;
        bkBut->Enabled=false;
        fwBut->Enabled=false;
     break;
    case 1:
        DSel->Enabled=false;
        bkBut->Enabled=false;
        fwBut->Enabled=false;
     break;
    case 2:
        DSel->Enabled=false;
        bkBut->Enabled=false;
        fwBut->Enabled=false;
     break;
    case 3:
        DSel->Enabled=false;
        bkBut->Enabled=false;
        fwBut->Enabled=false;
     break;
    case 4:
        DSel->Enabled=false;
        bkBut->Enabled=false;
        fwBut->Enabled=false;
     break;
    case 5:
        DSel->Enabled=true;
        bkBut->Enabled=true;
        fwBut->Enabled=true;
     break;
    case 6:
        DSel->Enabled=false;
        bkBut->Enabled=true;
        fwBut->Enabled=true;
     break;
    case 7:
        DSel->Enabled=true;
        bkBut->Enabled=true;
        fwBut->Enabled=true;
     break;
    }
   }
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
allSaved=true;
DateSeparator = '.';
ShortDateFormat = "dd.mm.yyyy";
DecimalSeparator = '.';

coolBarOpened=false;
csdt.Q=0;
csdt.t1=0;
csdt.t2=0;
csdt.V1=0; csdt.V2=0;
csdt.V3=0; csdt.V4=0;
csdt.m1=0; csdt.m2=0;
csdt.k1=0; csdt.k2=0;
csdt.k3=0; csdt.k4=0;
csdt.bs=0; csdt.ta=0;
csdt.hrs=0; csdt.snum=0;
csdt.archCompDate=Now();
HDLines = new TList;
com_char="COM1";
Form1->WindowState=wsMaximized;
//for(int i=0;i<DF->DGrid->ColCount;i++) {
// DF->DGridCW[i]=DF->DGrid->Width/DF->DGrid->ColWidths[i]; }
if(chdir("DIODATA")!=0) {
    mkdir("DIODATA");
}
 updateCoolBar();
 updateDtTree();
 cdiPanel->Visible=false;

 loadConfig();
 Form1->Caption=AnsiString("DxData V9.00.01 ");
}

void TForm1::ClearHData()
{
    PHData a=new THData;
    if(HDLines->Count!=0) {
    for(int i=0;i<HDLines->Count;i++) {
    a = (PHData) HDLines->Items[i];
    delete a;
    }
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
    ClearHData();
    delete HDLines;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::DSelChange(TObject *Sender)
{
    UpdateHGrid();
    UpdateGraps();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormActivate(TObject *Sender)
{
   COM11->Checked=true;
   COM12->Checked=true;
   DCon->Hide();
}
//---------------------------------------------------------------------------



void __fastcall TForm1::ToolButton8Click(TObject *Sender)
{
    DF->cbrd->Clear();
    AnsiString cbbuf="";

 // добавление заголовка
   switch(RefCombo->ItemIndex) {
    case(5): {
    cbbuf+=DSel->Items->Strings[DSel->ItemIndex]+'\n';
    }
    }
    for(int j=1;j<=DF->DGrid->RowCount;j++) {
    for(int i=0;i<=DF->DGrid->ColCount-1;i++) {
      cbbuf=cbbuf+DF->DGrid->Cells[i][j]+'\t'; }
      cbbuf+='\n';
     }
    DF->cbrd->SetTextBuf(cbbuf.c_str());
  MessageBox(0,"Таблица помещена в буфер обмена\nи может быть вставлена как\nтекст.","",0);
}

void TForm1::UpdateGraps()
{
}
//---------------------------------------------------------------------------




void __fastcall TForm1::ToolButton1Click(TObject *Sender)
{
  char szFileName[MAXFILE+4];
  int iFileHandle;
  int iLength;
  LPSTR hdrStr;
  HDataSL as;
  char buf[100];
  unsigned short adt,amn,ayr,ahr,amin,asec,amsec;

 if(HDLines->Count==0)
  {   MessageBox(0,"Нет данных для сохранения","Ошибка.",MB_OK|MB_ICONEXCLAMATION);
  return; }
  csdt.archCompDate.DecodeDate(&ayr,&amn,&adt);
  csdt.archCompDate.DecodeTime(&ahr,&amin,&asec,&amsec);
  sd->FileName=IntToStr(csdt.snum)+IntToStr(adt)+IntToStr(amn)+
        IntToStr(ayr)+IntToStr(ahr)+IntToStr(amin)+((RefCombo->ItemIndex>=3)?"h":"");
 if(sd->Execute())
 {
   if (FileExists(sd->FileName))
    {
      fnsplit(sd->FileName.c_str(), 0, 0, szFileName, 0);
      strcat(szFileName, ".BAK");
      if(FileExists(szFileName))
       DeleteFile(szFileName);
      RenameFile(sd->FileName, szFileName);
    }
     strcat(szFileName,".d9m");
    iFileHandle = FileCreate(sd->FileName);

    FileWrite(iFileHandle, &csdt, sizeof(csdt));
    for(int i=0;i<HDLines->Count;i++) {
     astr=(PHData)HDLines->Items[i];
     strcpy(as.dt,astr->dt.c_str());
     as.Q=astr->Q;
     as.Q1=astr->Q1;      as.hr=astr->hr;
     as.t1=astr->t1;    as.t2=astr->t2; as.t3=astr->t3; as.t4=astr->t4;
     as.V1=astr->V1;    as.V2=astr->V2;
     as.V3=astr->V3;    as.V4=astr->V4;
     as.Ubat=astr->Ubat; as.ta=astr->ta;
     FileWrite(iFileHandle, &as, sizeof(THDataSL));
     allSaved=true;
     }
    FileClose(iFileHandle);
    updateDtTree();
 }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N4Click(TObject *Sender)
{
 ToolButton1Click(this);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::csbClick(TObject *Sender)
{
 comsel->Popup(this->Left+csb->Left,this->Top+csb->Top+50);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM11Click(TObject *Sender)
{
 COM11->Checked=true;
 COM21->Checked=false;
 COM31->Checked=false;
 COM41->Checked=false;
 COM12->Checked=true;
 COM22->Checked=false;
 COM32->Checked=false;
 COM42->Checked=false;
 com_char="COM1";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM21Click(TObject *Sender)
{
 COM12->Checked=false;
 COM22->Checked=true;
 COM32->Checked=false;
 COM42->Checked=false;
 COM11->Checked=false;
 COM21->Checked=true;
 COM31->Checked=false;
 COM41->Checked=false;
 com_char="COM2";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM31Click(TObject *Sender)
{
 COM12->Checked=false;
 COM22->Checked=false;
 COM32->Checked=true;
 COM42->Checked=false;
 COM11->Checked=false;
 COM21->Checked=false;
 COM31->Checked=true;
 COM41->Checked=false;
 com_char="COM3";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM41Click(TObject *Sender)
{
 COM12->Checked=false;
 COM22->Checked=false;
 COM32->Checked=false;
 COM42->Checked=true;
 COM11->Checked=false;
 COM21->Checked=false;
 COM31->Checked=false;
 COM41->Checked=true;
 com_char="COM4";
}
//---------------------------------------------------------------------------


void __fastcall TForm1::COM12Click(TObject *Sender)
{
 COM11->Checked=true;
 COM21->Checked=false;
 COM31->Checked=false;
 COM41->Checked=false;
 COM12->Checked=true;
 COM22->Checked=false;
 COM32->Checked=false;
 COM42->Checked=false;
 com_char="COM1";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM22Click(TObject *Sender)
{
 COM11->Checked=false;
 COM21->Checked=true;
 COM31->Checked=false;
 COM41->Checked=false;
 COM12->Checked=false;
 COM22->Checked=true;
 COM32->Checked=false;
 COM42->Checked=false;
 com_char="COM2";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM32Click(TObject *Sender)
{
 COM11->Checked=false;
 COM21->Checked=false;
 COM31->Checked=true;
 COM41->Checked=false;
 COM12->Checked=false;
 COM22->Checked=false;
 COM32->Checked=true;
 COM42->Checked=false;
 com_char="COM3";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::COM42Click(TObject *Sender)
{
 COM11->Checked=false;
 COM21->Checked=false;
 COM31->Checked=false;
 COM41->Checked=true;
 COM12->Checked=false;
 COM22->Checked=false;
 COM32->Checked=false;
 COM42->Checked=true;
 com_char="COM4";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::comselPopup(TObject *Sender)
{
   COM11->Enabled=DCon->OpenConnection("COM1")?true:false;
  DCon->CloseConnection();
   COM21->Enabled=DCon->OpenConnection("COM2")?true:false;
  DCon->CloseConnection();
   COM31->Enabled=DCon->OpenConnection("COM3")?true:false;
  DCon->CloseConnection();
   COM41->Enabled=DCon->OpenConnection("COM4")?true:false;
  DCon->CloseConnection();
}
//---------------------------------------------------------------------------


void __fastcall TForm1::N6Click(TObject *Sender)
{
 Close();
}
//---------------------------------------------------------------------------


void __fastcall TForm1::N2Click(TObject *Sender)
{
   COM12->Enabled=DCon->OpenConnection("COM1")?true:false;
  DCon->CloseConnection();
   COM22->Enabled=DCon->OpenConnection("COM2")?true:false;
  DCon->CloseConnection();
   COM32->Enabled=DCon->OpenConnection("COM3")?true:false;
  DCon->CloseConnection();
   COM42->Enabled=DCon->OpenConnection("COM4")?true:false;
  DCon->CloseConnection();
}
//---------------------------------------------------------------------------


void __fastcall TForm1::N8Click(TObject *Sender)
{
ToolButton2Click(this);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::ToolButton5Click(TObject *Sender)
{
CSData csd;
 if(getCSData(&csd)) {
 csdt=csd;
  if((csdt.dioType==dio4T4V))
   {
    Application->MessageBox("Опция поддерживается только для DIO-99M версии 2T4V и 3T3V","",0);
    return;
   }
 //updateCoolBar();
   cfVals->q1=csd.Q;
   cfVals->q2=csd.Q1;
   cfVals->v1=csd.V1;   cfVals->v2=csd.V2;
   cfVals->v3=csd.V3;   cfVals->v4=csd.V4;
   cfVals->m1=csd.m1;   cfVals->m2=csd.m2;
   cfVals->k1=csd.k1;   cfVals->k2=csd.k2;
   cfVals->k3=csd.k3;   cfVals->k4=csd.k3;
   cfVals->t1=csd.t1;   cfVals->t2=csd.t2;
   cfVals->t3=csd.t3;   cfVals->t4=csd.t4;
   cfVals->bs=csd.bs;
   cfVals->ta=csd.ta;
   cfVals->snum=csd.snum;
   cfVals->hrs=csd.hrs;
   cfVals->ErrCd=csd.ErrCd;
   cfVals->dioType=csdt.dioType;
   cfVals->ShowModal();
  } else
  Application->MessageBox(W_MSG1,"Ошибка соединения",MB_OK|MB_ICONEXCLAMATION);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N10Click(TObject *Sender)
{
ToolButton5Click(this);
}
//---------------------------------------------------------------------------




void __fastcall TForm1::abfClick(TObject *Sender)
{
aboutForm->noTimer=true;
aboutForm->ShowModal();
}
//---------------------------------------------------------------------------

int TForm1::findDate(TDateTime dt)
{
  PHData astr;
  int i;
  // astr = new THData;
  for(i=0;i<HDLines->Count;i++)
  {
    astr=(PHData)HDLines->Items[i];
    if(StrToDate(astr->dt)>=dt)
      break;
  }
  // delete astr;
  return i-1;
}

void __fastcall TForm1::N15Click(TObject *Sender)
{
  AnsiString st;
  int sIndex,eIndex;
  //------------------
  float Q, V1, V2, V3, V4;
  float SumQ, SumV1, SumV2, SumV3, SumV4;
  //------------------

  if(HDLines->Count>0)
  {

    if(csdt.refComboIndex<3)
    {
      prnIvl->dtFrom=StrToDate(((PHData)(HDLines->Items[0]))->dt);
      prnIvl->dtTo=StrToDate(((PHData)(HDLines->Items[HDLines->Count-1]))->dt);
      prnIvl->hrdtSheet->TabVisible=false;
      prnIvl->hdtSheet->TabVisible=true;
    } else
    {
      prnIvl->hrdtSheet->TabVisible=true;
      prnIvl->hdtSheet->TabVisible=false;
      prnIvl->clb->Clear();
      for(int i=0;i<DSel->Items->Count;i++)
        prnIvl->clb->Items->Add(DSel->Items->Strings[i]);
    }
    prnIvl->ShowModal();

    if(!prnIvl->selected) return;

    if(csdt.refComboIndex<3)
    {
      if(csdt.dioType==dio3T3V)
      {
        sIndex=findDate(prnIvl->prnIvlFrom->Date);
        eIndex=findDate(prnIvl->prnIvlTo->Date);
        if(eIndex>HDLines->Count) eIndex=HDLines->Count;
        if(sIndex<0) sIndex=0;
        dtPreview33->sband1->Items->Clear();
        dtPreview33->textLines=0;
        dtPreview33->smr.t1=0;      dtPreview33->smr.t2=0;
        dtPreview33->smr.t3=0;      dtPreview33->smr.t4=0;
        dtPreview33->smr.t1Cnts=0;  dtPreview33->smr.t2Cnts=0;
        dtPreview33->smr.t3Cnts=0;  dtPreview33->smr.t4Cnts=0;
        dtPreview33->smr.Qmax=0;    dtPreview33->smr.Q1max=0;
        dtPreview33->smr.v1max=0;   dtPreview33->smr.v2max=0;
        dtPreview33->smr.v3max=0;   dtPreview33->smr.v4max=0;

        dtPreview33->qrInf->Caption="Адрес: "+AnsiString(desc.addr)+ "  Владелец: "+AnsiString(desc.owner);
        dtPreview33->smd->Items->Add("Архив суточных показаний за период с "+ DateToStr(prnIvl->prnIvlFrom->Date)+" по "+ DateToStr(prnIvl->prnIvlTo->Date));
        dtPreview33->sband1->Items->Clear();
        dtPreview33->hrSNum->Caption="N: "+IntToStr(csdt.snum);
        dtPreview33->hrsl->Caption="Наработка: "+IntToStr(csdt.hrs)+" ч.";
        dtPreview33->qmh->Lines->Clear();
        dtPreview33->qml->Lines->Clear();
        dtPreview33->qmh->Lines->Add("Тепловая энергия (ГКал): "+ FloatToStrF(csdt.Q,ffFixed,12,3));
        dtPreview33->qmh->Lines->Add("Температура теплоносителя канала 1(oC): "+ ((csdt.ErrCd&0x01)?AnsiString("Не подключен."):FloatToStrF(csdt.t1,ffFixed,5,2)));
        dtPreview33->qmh->Lines->Add("Температура теплоносителя канала 2(oC): "+ ((csdt.ErrCd&0x02)?AnsiString("Не подключен."):FloatToStrF(csdt.t2,ffFixed,5,2)));
        dtPreview33->qmh->Lines->Add("Объем теплоносителя канала 1(m3): "+ FloatToStrF(csdt.V1,ffFixed,12,2));
        dtPreview33->qmh->Lines->Add("Объем теплоносителя канала 2(m3): "+ FloatToStrF(csdt.V2,ffFixed,12,2));
        dtPreview33->qmh->Lines->Add("Масса теплоносителя канала 1(т): "+ FloatToStrF(csdt.m1,ffFixed,12,2));
        dtPreview33->qmh->Lines->Add("Масса теплоносителя канала 2(т): "+ FloatToStrF(csdt.m2,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Тепловая энергия ГВС(ГКал): "+ FloatToStrF(csdt.Q1,ffFixed,12,3));
        dtPreview33->qml->Lines->Add("Температура теплоносителя ГВС(oC): "+ ((csdt.ErrCd&0x04)?AnsiString("Не подключен."):FloatToStrF(csdt.t3,ffFixed,5,2)));
        dtPreview33->qml->Lines->Add("Объем теплоносителя ГВС(m3): "+ FloatToStrF(csdt.V3,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Масса теплоносителя ГВС(т): "+ FloatToStrF(csdt.m3,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Вес импульса преобразователя канала 1(л/имп): "+ FloatToStrF(csdt.k1,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Вес импульса преобразователя канала 2(л/имп): "+ FloatToStrF(csdt.k2,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Вес импульса преобразователя канала 3(л/имп): "+ FloatToStrF(csdt.k3,ffFixed,12,2));
        dtPreview33->qml->Lines->Add("Батарея: "+FloatToStrF(csdt.bs,ffFixed,5,2)+ " В. t окр. "+IntToStr((int)csdt.ta)+" oC.");

        // My Code Start
        if(!prnIvl->Nakop)
        {
          // Reset Value
          Q = 0; V1 = 0; V2 = 0; V3 = 0; V4 = 0;
          SumQ = 0; SumV1 = 0; SumV2 = 0; SumV3 = 0; SumV4 = 0;
          if(sIndex > 0)
          {
            astr=(PHData)HDLines->Items[sIndex - 1];
            Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3; V4 = astr->V4;
          } else
            prnIvl->Nakop = true;
        }
        // My Code End;

        for(int i=sIndex;i<=eIndex;i++)
        {
          astr=(PHData)HDLines->Items[i];
          st=";"+astr->dt+";"+
            FloatToStrF(astr->Q - Q,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->t1,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->t2,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->V1 - V1,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->V2 - V2,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->Q1,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->t3,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->V3,ffFixed,12,2)+" ;"+
            IntToStr((int)astr->ta)+" ;"+
            FloatToStrF(astr->Ubat,ffFixed,5,2)+" ;";
          // My Code Start
          if(!prnIvl->Nakop)
          {
            SumQ += astr->Q - Q; SumV1 += astr->V1 - V1;
            SumV2 += astr->V2 - V2; SumV3 += astr->V3 - V3;
            SumV4 += astr->V4 - V4;
            Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3;
            V4 = astr->V4;
          }
          // My Code End;
          dtPreview33->sband1->Items->Add(st);
        }
        // My Code Start
        dtPreview->Nakop = prnIvl->Nakop;
        if(!prnIvl->Nakop)
        {
          dtPreview->qSum->Caption=FloatToStrF(SumQ,ffFixed,12,2);
          dtPreview->v1Sum->Caption=FloatToStrF(SumV1,ffFixed,12,2);
          dtPreview->v2Sum->Caption=FloatToStrF(SumV2,ffFixed,12,2);
          dtPreview->v3Sum->Caption=FloatToStrF(SumV3,ffFixed,12,2);
          dtPreview->v4Sum->Caption=FloatToStrF(SumV4,ffFixed,12,2);
        }
        // My Code End;
        dtPreview->qr2->Preview();
        dtPreview33->qr2->Preview();
      }

      // печать суточных 2T4V
      if(csdt.dioType==dio2T4V)
      {
        sIndex=findDate(prnIvl->prnIvlFrom->Date);
        eIndex=findDate(prnIvl->prnIvlTo->Date);
        if(eIndex>HDLines->Count) eIndex=HDLines->Count;
        if(sIndex<0) sIndex=0;
        // My Code Start
        if(!prnIvl->Nakop)
        {
          // Reset Value
          Q = 0; V1 = 0; V2 = 0; V3 = 0; V4 = 0;
          SumQ = 0; SumV1 = 0; SumV2 = 0; SumV3 = 0; SumV4 = 0;
          if(sIndex > 0)
          {
            astr=(PHData)HDLines->Items[sIndex - 1];
            Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3; V4 = astr->V4;
          } else
          prnIvl->Nakop = true;
        }
        // My Code End;
        dtPreview->sband1->Items->Clear();
        for(int i=sIndex;i<=eIndex;i++)
        {
          astr=(PHData)HDLines->Items[i];
          st=";"+astr->dt+";"+FloatToStrF(astr->Q - Q,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->t1,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->t2,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->t1 - astr->t2,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->V1 - V1,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->V2 - V2,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->V3 - V3,ffFixed,12,2)+" ;"+
            //FloatToStrF((astr->V1 - V1) - (astr->V2 - V2),ffFixed,12,2)+" ;"+
            IntToStr((int)astr->ta)+" ;"+
            FloatToStrF(astr->Ubat,ffFixed,5,2)+" ;";
          // My Code Start
          if(!prnIvl->Nakop)
          {
            SumQ += astr->Q - Q; SumV1 += astr->V1 - V1;
            SumV2 += astr->V2 - V2; SumV3 += astr->V3 - V3;
            SumV4 += astr->V4 - V4;
            Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3;
            V4 = astr->V4;
          }
          // My Code End;
          dtPreview->sband1->Items->Add(st);
        }

        dtPreview->qrwd->Caption="Адрес: "+AnsiString(desc.addr)+"  Владелец: "+
          AnsiString(desc.owner)+"\r\nТекущие показания по состоянию на "+
          DateTimeToStr(csdt.archCompDate);
        dtPreview->qrhl1->Caption="N: "+IntToStr(csdt.snum);
        dtPreview->hrsl->Caption="Наработка: "+IntToStr(csdt.hrs)+" ч.";

        dtPreview->qmh->Lines->Clear();
        dtPreview->qml->Lines->Clear();

        dtPreview->qmh->Lines->Add("Тепловая энергия (ГКал): "+FloatToStrF(csdt.Q,ffFixed,12,2));
        dtPreview->qmh->Lines->Add("Температура теплоносителя канала 1(oC): "+ ((csdt.ErrCd&0x01)?AnsiString("Не подключен."):FloatToStrF(csdt.t1,ffFixed,5,2)));
        dtPreview->qmh->Lines->Add("Температура теплоносителя канала 2(oC): "+ ((csdt.ErrCd&0x02)?AnsiString("Не подключен."):FloatToStrF(csdt.t2,ffFixed,5,2)));
        dtPreview->qmh->Lines->Add("Объем теплоносителя канала 1(m3): "+ FloatToStrF(csdt.V1,ffFixed,12,2));
        dtPreview->qmh->Lines->Add("Объем теплоносителя канала 2(m3): "+ FloatToStrF(csdt.V2,ffFixed,12,2));
        //dtPreview->qmh->Lines->Add("Объем теплоносителя канала 3(m3): "+ FloatToStrF(csdt.V3,ffFixed,12,2));
        //dtPreview->qmh->Lines->Add("Объем теплоносителя канала 4(m3): "+ FloatToStrF(csdt.V4,ffFixed,12,2));
        dtPreview->qml->Lines->Add("Масса теплоносителя канала 1(т): "+ FloatToStrF(csdt.m1,ffFixed,12,2));
        dtPreview->qml->Lines->Add("Масса теплоносителя канала 2(т): "+ FloatToStrF(csdt.m2,ffFixed,12,2));
        dtPreview->qml->Lines->Add("Вес импульса преобразователя канала 1(л/имп): "+ FloatToStrF(csdt.k1,ffFixed,12,2));
        dtPreview->qml->Lines->Add("Вес импульса преобразователя канала 2(л/имп): "+ FloatToStrF(csdt.k2,ffFixed,12,2));
        //dtPreview->qml->Lines->Add("Вес импульса преобразователя канала 3(л/имп): "+ FloatToStrF(csdt.k3,ffFixed,12,2));
        //dtPreview->qml->Lines->Add("Вес импульса преобразователя канала 4(л/имп): "+ FloatToStrF(csdt.k4,ffFixed,12,2));
        dtPreview->qml->Lines->Add("Батарея: "+FloatToStrF(csdt.bs,ffFixed,5,2)+ " В. t окр. "+IntToStr((int)csdt.ta)+" oC.");
        dtPreview->qrdtp->Caption="Архив суточных показаний за период с "+ DateToStr(prnIvl->prnIvlFrom->Date)+" по "+DateToStr(prnIvl->prnIvlTo->Date);

        // My Code Start
        dtPreview->Nakop = prnIvl->Nakop;
        if(!prnIvl->Nakop)
        {
          dtPreview->qSum->Caption=FloatToStrF(SumQ,ffFixed,12,2);
          dtPreview->v1Sum->Caption=FloatToStrF(SumV1,ffFixed,12,2);
          dtPreview->v2Sum->Caption=FloatToStrF(SumV2,ffFixed,12,2);
        }
        // My Code End;
        dtPreview->qr2->Preview();
      }
    } else
    {
      if(csdt.dioType==dio2T4V) // печать почасовых    2T4V
      {
        int rpPages=1;
        hrPreview->qrInf->Caption="Адрес: "+AnsiString(desc.addr)+ "  Владелец: "+AnsiString(desc.owner);
        hrPreview->sband1->Items->Clear();
        hrPreview->smd->Items->Clear();
        hrPreview->hrSNum->Caption="N: "+IntToStr(csdt.snum);
        // заполнение smd
        for(int i=0;i<prnIvl->clb->Items->Count;i++)
          if(prnIvl->clb->Checked[i])
            hrPreview->smd->Items->Add(prnIvl->clb->Items->Strings[i]);
        // заполнение sband1
        AnsiString cmpDate;
        for(int i=0;i<prnIvl->clb->Items->Count;i++)
          if(prnIvl->clb->Checked[i])
          {
            for(int j=0;j<HDLines->Count;j++)
            {
              astr=(PHData)HDLines->Items[j];
              // проверка системного формата даты
              cmpDate=prnIvl->clb->Items->Strings[i];
              if(DateToStr(astr->dt)==cmpDate)
              {
                astr=(PHData)HDLines->Items[j];
                st=";"+DateToStr(astr->dt)+";"+
                  IntToStr(astr->hr)+":00;"+
                  FloatToStrF(astr->Q,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->t1,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->t2,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->V1,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->V2,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->V3,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->V4,ffFixed,12,2)+" ;"+
                  IntToStr((int)astr->ta)+" ;"+
                  FloatToStrF(astr->Ubat,ffFixed,5,2)+" ;";
                hrPreview->sband1->Items->Add(st);
              }
            }
            rpPages++;
          }
        hrPreview->qr2->Preview();
      }
    }

    if(csdt.refComboIndex<3)
    {
      if(csdt.dioType==dio4T4V)
      {
        sIndex=findDate(prnIvl->prnIvlFrom->Date);
        eIndex=findDate(prnIvl->prnIvlTo->Date);
        if(eIndex>HDLines->Count) eIndex=HDLines->Count;
        if(sIndex<0) sIndex=0;
        dtPreview44->qrInf->Caption="Адрес: "+AnsiString(desc.addr)+"  Владелец: "+AnsiString(desc.owner);
        dtPreview44->smd->Items->Add("Архив суточных показаний за период с "+DateToStr(prnIvl->prnIvlFrom->Date)+" по "+DateToStr(prnIvl->prnIvlTo->Date));
        dtPreview44->sband1->Items->Clear();
        dtPreview44->hrSNum->Caption="N: "+IntToStr(csdt.snum);
        for(int i=sIndex;i<=eIndex;i++)
        {
          astr=(PHData)HDLines->Items[i];
          st=";"+astr->dt+";"+
            FloatToStrF(astr->Q,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->t1,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->t2,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->V1,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->V2,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->Q1,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->t3,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->t4,ffFixed,5,2)+" ;"+
            FloatToStrF(astr->V3,ffFixed,12,2)+" ;"+
            FloatToStrF(astr->V4,ffFixed,12,2)+" ;"+
            IntToStr((int)astr->ta)+" ;"+
            FloatToStrF(astr->Ubat,ffFixed,5,2)+" ;";
            dtPreview44->sband1->Items->Add(st);
        }
        dtPreview44->qr2->Preview();
      }
    } else
    {
      if(csdt.dioType==dio4T4V) // печать почасовых    4T4V
      {
        int rpPages=1;

        hrPreview44->sband1->Items->Clear();
        hrPreview44->smd->Items->Clear();
        hrPreview44->qrInf->Caption="Адрес: "+AnsiString(desc.addr)+"  Владелец: "+AnsiString(desc.owner);
        hrPreview44->hrSNum->Caption="N: "+IntToStr(csdt.snum);
        // заполнение smd
        for(int i=0;i<prnIvl->clb->Items->Count;i++)
          if(prnIvl->clb->Checked[i])
            hrPreview44->smd->Items->Add(prnIvl->clb->Items->Strings[i]);
        // заполнение sband1
        AnsiString cmpDate;

        for(int i=0;i<prnIvl->clb->Items->Count;i++)
        {
          if(prnIvl->clb->Checked[i])
          {
            for(int j=0;j<HDLines->Count;j++)
            {
              astr=(PHData)HDLines->Items[j];
              // проверка системного формата даты
              cmpDate=prnIvl->clb->Items->Strings[i];
              if(DateToStr(astr->dt)==cmpDate)
              {
                astr=(PHData)HDLines->Items[j];
                st=";"+DateToStr(astr->dt)+";"+
                  IntToStr(astr->hr)+":00;"+
                  FloatToStrF(astr->Q,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->t1,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->t2,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->V1,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->V2,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->Q1,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->t3,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->t4,ffFixed,5,2)+" ;"+
                  FloatToStrF(astr->V3,ffFixed,12,2)+" ;"+
                  FloatToStrF(astr->V4,ffFixed,12,2)+" ;"+
                  IntToStr((int)astr->ta)+" ;"+
                  FloatToStrF(astr->Ubat,ffFixed,5,2)+" ;";
                hrPreview44->sband1->Items->Add(st);
              }
            }
            rpPages++;
          }
        }
        hrPreview44->qr2->Preview();
      }
    }
  }
}
//---------------------------------------------------------------------------


void  TForm1::loadFile(AnsiString fn)
{
  int iFileHandle;
  int iFileLength,LinesCount;
  int iLength,iBytesRead;
  HDataSL as;

        iFileHandle = FileOpen(fn,fmOpenRead);
        iFileLength = FileSeek(iFileHandle,0,2);
        FileSeek(iFileHandle,0,0);
        FileRead(iFileHandle,&csdt,sizeof(TCSData));
          RefCombo->ItemIndex=csdt.refComboIndex;
        ClearHData();
        delete HDLines;
        HDLines = new TList;
        LinesCount = (iFileLength-sizeof(csdt))/sizeof(THData);
        DSel->Clear();

            for(int i=0;i<LinesCount;i++) {
             iBytesRead=FileRead(iFileHandle,&as,sizeof(as));
                 if(iBytesRead<sizeof(as))
                    break;
             astr=new THData;
             astr->Q=as.Q;
             astr->Q1=as.Q1;
             astr->t1=as.t1;             astr->t2=as.t2;
             astr->t3=as.t3;             astr->t4=as.t4;
             astr->V1=as.V1;             astr->V2=as.V2;
             astr->V3=as.V3;             astr->V4=as.V4;
             astr->Ubat=as.Ubat;         astr->ta=as.ta;
             astr->hr=as.hr;
             astr->dt=as.dt;
             HDLines->Add(astr);
             if(csdt.refComboIndex>=3)
             {
             int j;
             bool dtExists=false;
                 if(DSel->Items->Count!=0)
                  for(j=0;j<DSel->Items->Count;j++) {
                   if(StrToDate(astr->dt)==StrToDate(DSel->Items->Strings[j])) {
                        dtExists=true;
                        break;
                        }
                     }
                 if(!dtExists)
                  DSel->Items->Add(astr->dt);
             }
            }
        FileClose(iFileHandle);
        updateCoolBar();
        cdiPanel->Visible=true;
        if(csdt.refComboIndex>=3)
         {  DSel->Enabled=true;
            DSel->ItemIndex=0;
            bkBut->Enabled=true;
            fwBut->Enabled=true;

         } else {
          DSel->Enabled=false;
          bkBut->Enabled=false;
          fwBut->Enabled=false;
        }
}

void __fastcall TForm1::FileOpenButtonClick(TObject *Sender)
{
    if(od->Execute())
    {
    if(FileExists(od->FileName))
    {
        loadFile(od->FileName);
        UpdateHGrid();
     } else
      {
      Application->MessageBox("Ошибка при открытии файла","Ошибка.",MB_OK|MB_ICONEXCLAMATION);
      }
    }
}
//---------------------------------------------------------------------------


void __fastcall TForm1::N16Click(TObject *Sender)
{
FileOpenButtonClick(this);
}
//---------------------------------------------------------------------------


void  TForm1::SortListByDate(void)
{
if(HDLines!=NULL) {

int j;
int limit = HDLines->Count;
int st = -1;
PHData pdt,pdts;
TDateTime dt1,dt2;
	while (st < limit) {
        st++;
	    limit--;
	    bool swapped = false;
	    for (j = st; j < limit; j++) {
         pdts=(PHData)HDLines->Items[j];
         pdt=(PHData)HDLines->Items[j+1];
         dt1=StrToDateTime(pdts->dt+" "+IntToStr(pdts->hr)+":00");
         dt2=StrToDateTime(pdt->dt+" "+IntToStr(pdt->hr)+":00");
 		if (dt1>dt2) {
		    HDLines->Items[j]=HDLines->Items[j+1];
		    HDLines->Items[j+1]=pdts;
		    swapped = true;
		}
	    }
	    if (!swapped) {
		return;
	    }
	    else
		swapped = false;
	    for (j = limit; --j >= st;) {
         pdts=(PHData)HDLines->Items[j];
         pdt=(PHData)HDLines->Items[j+1];
         dt1=StrToDateTime(pdts->dt+" "+IntToStr(pdts->hr)+":00");
         dt2=StrToDateTime(pdt->dt+" "+IntToStr(pdt->hr)+":00");
 		if (dt1>dt2) {
		    HDLines->Items[j]=HDLines->Items[j+1];
		    HDLines->Items[j+1]=pdts;
		    swapped = true;
		}
	    }
	    if (!swapped) {
		return;
	    }
       sb1->SimpleText=IntToStr(st);
       sb1->Invalidate();
	}
   } // if
}

bool TForm1::getCSData(PCSData as)
{
bool recvOk,timeOut;
int Crc,Crc1;
unsigned char recvBuf[64];

 recvOk=false;

   DCon->Show();
   DCon->OpenConnection(com_char);
   DCon->ClearCntrs();
         while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa2);
        DCon->SendByteSeq(0);
        DCon->SendByteSeq(0);
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }

   for(int i=0;i<64;i++) dampForm->pa[i]=recvBuf[i];
   dampForm->Repaint();

  recvOk=false;

         while(!recvOk) {
        timeOut=DCon->SendByteSeq(0x1e);
     if(!timeOut) break;
        DCon->SendByteSeq(0xa0);
        DCon->SendByteSeq(0);
        DCon->SendByteSeq(0);
        Crc=0;
        for(int i=0;i<64;i++) {
        recvBuf[i]=DCon->RecvByte();
        Crc+=(byte)(64-i)^recvBuf[i];
        if(DCon->UserCancelled) break;
        }
       Crc1=DCon->RecvByte()*256+DCon->RecvByte();
      recvOk=(Crc==Crc1)?true:false;
      }
   for(int i=0;i<64;i++) dampForm->pa0[i]=recvBuf[i];
   dampForm->Repaint();

   DCon->SendByteSeq(0x21);
   if(DCon->RecvByte()==0x21)
    {
     DCon->SendByte(0x74);
     DCon->SendByte(0x01);
     as->ErrCd=DCon->RecvByte();
    }
   DCon->CloseConnection();
   DCon->Hide();
 if(recvOk==true) {
   as->dioType=recvBuf[0x3e];

   if((as->dioType != dio2T4V) || (as->dioType != dio4T4V) || (as->dioType != dio3T3V))
        as->dioType = dio2T4V;

   as->Q=Dec_2_Float(recvBuf[5],recvBuf[2],recvBuf[3],recvBuf[4]);

   as->V1=Dec_2_Float(recvBuf[19],recvBuf[16],recvBuf[17],recvBuf[18]);
   as->V2=Dec_2_Float(recvBuf[23],recvBuf[20],recvBuf[21],recvBuf[22]);
   as->V3=Dec_2_Float(recvBuf[27],recvBuf[24],recvBuf[25],recvBuf[26]);
   switch(as->dioType) {
    case(dio2T4V):
           as->V4=Dec_2_Float(recvBuf[31],recvBuf[28],recvBuf[29],recvBuf[30]);
           break;
    case(dio3T3V):
           as->Q1=Dec_2_Float(recvBuf[31],recvBuf[28],recvBuf[29],recvBuf[30]);
           break;
    case(dio4T4V):
           as->V4=Dec_2_Float(recvBuf[31],recvBuf[28],recvBuf[29],recvBuf[30]);
           break;
   }
   as->m1=Dec_2_Float(recvBuf[35],recvBuf[32],recvBuf[33],recvBuf[34]);
   as->m2=Dec_2_Float(recvBuf[39],recvBuf[36],recvBuf[37],recvBuf[38]);
   as->k1=Dec_2_Float(recvBuf[43],recvBuf[40],recvBuf[41],recvBuf[42]);
   as->k2=Dec_2_Float(recvBuf[47],recvBuf[44],recvBuf[45],recvBuf[46]);
   as->k3=Dec_2_Float(recvBuf[51],recvBuf[48],recvBuf[49],recvBuf[50]);
   as->k4=as->k3;
   as->t1=Dec_2_Float(recvBuf[9],recvBuf[6],recvBuf[7],recvBuf[8]);
   as->t2=Dec_2_Float(recvBuf[13],recvBuf[10],recvBuf[11],recvBuf[12]);
   as->bs=recvBuf[15]*0.0214647888;
   as->ta=recvBuf[14]-103;
   as->snum=recvBuf[0x3c]*256+recvBuf[0x3d];
   as->hrs=recvBuf[52]+recvBuf[53]*256;
   as->refComboIndex=RefCombo->ItemIndex;
  return true;
   }
  return false;
}

void TForm1::updateCoolBar()
{

   switch(csdt.dioType) {
     case dio2T4V:
                 dtl->Caption="DIO-99M 2T4V";
                 iGrid->ColCount=2;
                 iGrid->RowCount=18;
                 iGrid->ColWidths[1]=90;
                 iGrid->Cells[0][0]="No"; iGrid->Cells[1][0]=IntToStr(csdt.snum);
                 iGrid->Cells[0][1]="Наработка (ч.)"; iGrid->Cells[1][1]=IntToStr(csdt.hrs);
                 iGrid->Cells[0][2]="Q (Гкал)"; iGrid->Cells[1][2]=FloatToStrF(csdt.Q,ffFixed,12,3);
                 iGrid->Cells[0][3]="t1 (oC)"; iGrid->Cells[1][3]=((csdt.ErrCd&0x01)?(AnsiString("Не подключен.")):(FloatToStrF(csdt.t1,ffFixed,5,2)));
                 iGrid->Cells[0][4]="t2 (oC)"; iGrid->Cells[1][4]=((csdt.ErrCd&0x02)?(AnsiString("Не подключен.")):(FloatToStrF(csdt.t2,ffFixed,5,2)));
                 iGrid->Cells[0][5]="V1 (m3)"; iGrid->Cells[1][5]=FloatToStrF(csdt.V1,ffFixed,12,3);
                 iGrid->Cells[0][6]="V2 (m3)"; iGrid->Cells[1][6]=FloatToStrF(csdt.V2,ffFixed,12,3);
                 iGrid->Cells[0][7]="V3 (m3)"; iGrid->Cells[1][7]=FloatToStrF(csdt.V3,ffFixed,12,3);
                 iGrid->Cells[0][8]="V4 (m3)"; iGrid->Cells[1][8]=FloatToStrF(csdt.V4,ffFixed,12,3);
                 iGrid->Cells[0][9]="M1 (т)"; iGrid->Cells[1][9]=FloatToStrF(csdt.m1,ffFixed,12,3);
                 iGrid->Cells[0][10]="M2 (т)"; iGrid->Cells[1][10]=FloatToStrF(csdt.m2,ffFixed,12,3);
                 iGrid->Cells[0][11]="k1 (л/имп.)"; iGrid->Cells[1][11]=FloatToStrF(csdt.k1,ffFixed,12,2);
                 iGrid->Cells[0][12]="k2 (л/имп.)"; iGrid->Cells[1][12]=FloatToStrF(csdt.k2,ffFixed,12,2);
                 iGrid->Cells[0][13]="k3 (л/имп.)"; iGrid->Cells[1][13]=FloatToStrF(csdt.k3,ffFixed,12,2);
                 iGrid->Cells[0][14]="k4 (л/имп.)"; iGrid->Cells[1][14]=FloatToStrF(csdt.k4,ffFixed,12,2);
                 iGrid->Cells[0][15]="Батарея (В.)"; iGrid->Cells[1][15]=FloatToStrF(csdt.bs,ffFixed,12,2);
                 iGrid->Cells[0][16]="t окр (oC)"; iGrid->Cells[1][16]=FloatToStrF(csdt.ta,ffFixed,5,1);
                 iGrid->Cells[0][17]="Время связи"; iGrid->Cells[1][17]=DateTimeToStr(csdt.archCompDate);
      break;
     case dio3T3V:
                 dtl->Caption="DIO-99M 3T3V";
                 iGrid->ColCount=2;
                 iGrid->RowCount=18;
                 iGrid->ColWidths[1]=90;
                 iGrid->Cells[0][0]="No"; iGrid->Cells[1][0]=IntToStr(csdt.snum);
                 iGrid->Cells[0][1]="Наработка (ч.)"; iGrid->Cells[1][1]=IntToStr(csdt.hrs);
                 iGrid->Cells[0][2]="Q1 (Гкал)"; iGrid->Cells[1][2]=FloatToStrF(csdt.Q,ffFixed,12,3);
                 iGrid->Cells[0][3]="t1 (oC)"; iGrid->Cells[1][3]=((csdt.ErrCd&0x01)?(AnsiString("Не подключен.")):(FloatToStrF(csdt.t1,ffFixed,5,2)));
                 iGrid->Cells[0][4]="t2 (oC)"; iGrid->Cells[1][4]=((csdt.ErrCd&0x02)?(AnsiString("Не подключен.")):(FloatToStrF(csdt.t2,ffFixed,5,2)));
                 iGrid->Cells[0][5]="V1 (m3)"; iGrid->Cells[1][5]=FloatToStrF(csdt.V1,ffFixed,12,3);
                 iGrid->Cells[0][6]="V2 (m3)"; iGrid->Cells[1][6]=FloatToStrF(csdt.V2,ffFixed,12,3);
                 iGrid->Cells[0][7]="Q2 (Гкал)"; iGrid->Cells[1][7]=FloatToStrF(csdt.Q1,ffFixed,12,3);
                 iGrid->Cells[0][8]="V3 (m3)"; iGrid->Cells[1][8]=FloatToStrF(csdt.V3,ffFixed,12,3);
                 iGrid->Cells[0][9]="M1 (т)"; iGrid->Cells[1][9]=FloatToStrF(csdt.m1,ffFixed,12,3);
                 iGrid->Cells[0][10]="M2 (т)"; iGrid->Cells[1][10]=FloatToStrF(csdt.m2,ffFixed,12,3);
                 iGrid->Cells[0][11]="M3 (т)"; iGrid->Cells[1][11]=FloatToStrF(csdt.m3,ffFixed,12,3);
                 iGrid->Cells[0][12]="k1 (л/имп.)"; iGrid->Cells[1][12]=FloatToStrF(csdt.k1,ffFixed,12,2);
                 iGrid->Cells[0][13]="k2 (л/имп.)"; iGrid->Cells[1][13]=FloatToStrF(csdt.k2,ffFixed,12,2);
                 iGrid->Cells[0][14]="k3 (л/имп.)"; iGrid->Cells[1][14]=FloatToStrF(csdt.k3,ffFixed,12,2);
                 iGrid->Cells[0][15]="Батарея (В.)"; iGrid->Cells[1][15]=FloatToStrF(csdt.bs,ffFixed,12,2);
                 iGrid->Cells[0][16]="t окр (oC)"; iGrid->Cells[1][16]=FloatToStrF(csdt.ta,ffFixed,5,1);
                 iGrid->Cells[0][17]="Время связи"; iGrid->Cells[1][17]=DateTimeToStr(csdt.archCompDate);
      break;
     case dio4T4V:
                 dtl->Caption="DIO-99M 4T4V";
                 iGrid->ColCount=2;
                 iGrid->RowCount=1;
                 iGrid->Cells[0][0]="No"; iGrid->Cells[1][0]=IntToStr(csdt.snum);
                 iGrid->Cells[0][1]="Наработка (ч.)"; iGrid->Cells[1][1]=IntToStr(csdt.hrs);
      break;
   }

}
//---------------------------------------------------------------------------





void __fastcall TForm1::N17Click(TObject *Sender)
{
 bool   foundDio = false;
 int    i;
    for(i=1;i<=4;i++)    {
            strcpy(com_char,("COM"+IntToStr(i)).c_str());

            if(DCon->OpenConnection(com_char)) {
                DCon->delayMilliSeconds(300);
                    DCon->SendByteSeq(0x58);
                    if(DCon->RecvByte()==0x58) {
                         foundDio=true;
                         DCon->CloseConnection();
                         break;
                        }   // if
                }   // if
           DCon->CloseConnection();
        } // for
    Application->MessageBox(((foundDio)?("DIO-99M подключен к порту COM"+IntToStr(i)+".\nНомер порта установлен автоматически.").c_str():"В доступных портах  DIO-99M не обнаружен"),
                            "Поиск прибора.",MB_OK|MB_ICONEXCLAMATION);

   COM12->Checked=false;    COM11->Checked=false;
   COM22->Checked=false;    COM21->Checked=false;
   COM32->Checked=false;    COM31->Checked=false;
   COM42->Checked=false;    COM41->Checked=false;
    switch(i) {
        case(1):
            COM12->Checked=true;
            COM11->Checked=true;
            break;
        case(2):
            COM22->Checked=true;
            COM21->Checked=true;
            break;
        case(3):
            COM32->Checked=true;
            COM31->Checked=true;
            break;
        case(4):
            COM42->Checked=true;
            COM41->Checked=true;
            break;
    }
 }

void TForm1::addFileToTree(AnsiString fn)
{
 PfnRec     fnPtr;
 CSData     csd;
 int        iFileHandle;
 bool       foundInTree=false;
 int        i;
 AnsiString rSt;

 try {
   iFileHandle=FileOpen(fn,fmOpenRead);
   FileRead(iFileHandle,&csd,sizeof(csd));
    if(dtTree->Items->Count>0)
     foundInTree=false;

    if(dtTree->Items->Count>0)
        for(i=0;i<dtTree->Items->Count;i++) {
         if(dtTree->Items->Item[i]->Text==IntToStr(csd.snum)) {
            foundInTree=true;
            break; } // if
        } // for
      fnPtr = new TfnRec;

    rSt=(csd.refComboIndex>2)?"Ч ":"С ";
    if(!foundInTree) {
        fnPtr->fn=fn;
        dtTree->Items->AddObject(NULL,IntToStr(csd.snum),NULL);
        dtTree->Items->AddChildObject(dtTree->Items->Item[dtTree->Items->Count-1],rSt+DateTimeToStr(csd.archCompDate),fnPtr);
        }
     else {
        fnPtr->fn=fn;
        dtTree->Items->AddChildObject(dtTree->Items->Item[i],rSt+DateTimeToStr(csd.archCompDate),fnPtr);
        }
   FileClose(iFileHandle);
   } catch(...)
   {}
}

void TForm1::updateDtTree()
{
TSearchRec sr;
int iAttributes = 0;

   iAttributes=faAnyFile;

   dtTree->Items->Clear();
   if (FindFirst("*.d9m", iAttributes, sr) == 0) {
        addFileToTree(sr.Name);
   }
  while (FindNext(sr) == 0)  {
        addFileToTree(sr.Name);
  }

}
 //---------------------------------------------------------------------------
void __fastcall TForm1::dtTreeDblClick(TObject *Sender)
{
if(dtTree->Items->Count!=0)
 if(dtTree->Selected->Data!=NULL)
  {
  //Application->MessageBox((PfnRec(dtTree->Selected->Data))->fn.c_str(),"",0);
  loadFile((PfnRec(dtTree->Selected->Data))->fn);
  UpdateHGrid();

 AnsiString sFileName=dtTree->Selected->Parent->Text+".info";
 int f;
 if(FileExists(sFileName)) {
        f=FileOpen(sFileName,fmOpenRead);
        FileRead(f,&desc,sizeof(desc));
        FileClose(f); }//if

  }
}


//---------------------------------------------------------------------------


void __fastcall TForm1::bkButClick(TObject *Sender)
{
 if(DSel->ItemIndex>0)
 {
 DSel->ItemIndex--;
    UpdateHGrid();
    UpdateGraps();
 }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::fwButClick(TObject *Sender)
{
 if(DSel->ItemIndex<(DSel->Items->Count-1))
 {
 DSel->ItemIndex++;
    UpdateHGrid();
    UpdateGraps();
 }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ToolButton13Click(TObject *Sender)
{
  N15Click(this);        
}
//---------------------------------------------------------------------------



void __fastcall TForm1::ToolButton4Click(TObject *Sender)
{
 RefCombo->ItemIndex=7;
   DSel->Enabled=true;
   bkBut->Enabled=true;
   fwBut->Enabled=true;
 ToolButton2Click(this);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabelUrlClick(TObject *Sender)
{
  String St = "http://"+LabelUrl->Caption;
  ShellExecute(Handle,"open",St.c_str(),0,0,SW_SHOW);

}
//---------------------------------------------------------------------------


void __fastcall TForm1::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  if(!allSaved) {
   if(Application->MessageBox("Выйти не сохранив данные?","Данные не сохранены.",MB_OKCANCEL|MB_ICONEXCLAMATION)==IDOK)
    CanClose=true; else CanClose=false;
   } //if
   else {
    CanClose=true;
   }
 if(CanClose)
    saveConfig();

}
//---------------------------------------------------------------------------

void __fastcall TForm1::N12Click(TObject *Sender)
{
  AnsiString sFileName;
  sFileName=PfnRec(dtTree->Selected->Data)->fn;
    if(Application->MessageBox("Действительно желаете удалить\nвыбранную запись","Удалить?",MB_OKCANCEL|MB_ICONEXCLAMATION)==IDOK) {
          if(!DeleteFile(sFileName)) {
                Application->MessageBox("Невозможно удалить запись!","Ошибка!",MB_OK|MB_ICONEXCLAMATION);
                } else
                {
                 updateDtTree();
                }
    }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::qaPopupPopup(TObject *Sender)
{
 N12->Enabled=!((dtTree->Selected==NULL)|(dtTree->Selected->Data==NULL));
 A1->Enabled=!((dtTree->Selected==NULL)|(dtTree->Selected->Data==NULL));
 showDescript->Enabled=!((dtTree->Selected==NULL)|(dtTree->Selected->Data==NULL));
}
//---------------------------------------------------------------------------


void __fastcall TForm1::A1Click(TObject *Sender)
{
 AnsiString sFileName=PfnRec(dtTree->Selected->Data)->fn;
 if(CopyFile(sFileName.c_str(),("A:\\"+sFileName).c_str(),false))
      Application->MessageBox("Запись скопирована на диск A:","Удачно!",MB_OK|MB_ICONEXCLAMATION);
  else
      Application->MessageBox("Невозможно скопировать запись!","Ошибка!",MB_OK|MB_ICONEXCLAMATION);
}
//---------------------------------------------------------------------------



void __fastcall TForm1::SpeedButton1Click(TObject *Sender)
{
 cfVals->q1=csdt.Q;
 cfVals->q2=csdt.Q1;
 cfVals->t1=csdt.t1;
 cfVals->t2=csdt.t2;
 cfVals->v1=csdt.V1;
 cfVals->v2=csdt.V2;
 cfVals->v3=csdt.V3;
 cfVals->v4=csdt.V4;
 cfVals->m1=csdt.m1;
 cfVals->m2=csdt.m2;
 cfVals->k1=csdt.k1;
 cfVals->k2=csdt.k2;
 cfVals->k3=csdt.k3;
 cfVals->k4=csdt.k4;
 cfVals->snum=csdt.snum;
 cfVals->ta=csdt.ta;
 cfVals->hrs=csdt.hrs;
 cfVals->bs=csdt.bs;
 cfVals->ErrCd=csdt.ErrCd;
 cfVals->dioType=csdt.dioType;
 cfVals->ShowModal();
}
//---------------------------------------------------------------------------

TForm1::saveConfig()
{
dtopConfig cf;

   for(int i=0;i<cbar->Bands->Count;i++) {
        cf.bandsBreak[i]=cbar->Bands->Items[i]->Break;
   }
   cf.gh=DF->Splitter1->Top;
   if(FileExists("config.99m")) {
        DeleteFile("config.99m");
        }
   int fh=FileCreate("config.99m");
   int bw=FileWrite(fh,&cf,sizeof(cf));
   FileClose(fh);
}

TForm1::loadConfig()
{
if(FileExists("config.99m")) {
   int fh=FileOpen("config.99m",fmOpenRead);
   int bw=FileRead(fh,&cf,sizeof(cf));
   FileClose(fh);

   for(int i=0;i<cbar->Bands->Count;i++) {
        cbar->Bands->Items[i]->Break=cf.bandsBreak[i];
   }
 }
}

void __fastcall TForm1::N13Click(TObject *Sender)
{
 config->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::showDescriptClick(TObject *Sender)
{
 // читать описание из файла
 devDescr->Caption="Описание прибора №"+dtTree->Selected->Parent->Text;
 AnsiString sFileName=dtTree->Selected->Parent->Text+".info";

 int f;
 devDescr->addrEdit->Text="";
 devDescr->ownerEdit->Text="";

 if(FileExists(sFileName)) {
        f=FileOpen(sFileName,fmOpenRead);
        FileRead(f,&desc,sizeof(desc));
        FileClose(f);
        devDescr->addrEdit->Text=AnsiString(desc.addr);
        devDescr->ownerEdit->Text=AnsiString(desc.owner);
 }
 if(devDescr->ShowModal()==mrOk) {
 // сохранить описание
        strcpy(desc.addr,devDescr->addrEdit->Text.c_str());
        strcpy(desc.owner,devDescr->ownerEdit->Text.c_str());

 if(!FileExists(sFileName))
         f=FileCreate(sFileName);
                else
         f=FileOpen(sFileName,fmOpenWrite);

        FileWrite(f,&desc,sizeof(desc));
        FileClose(f);
 }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::mnMSWordExprtClick(TObject *Sender)
{
  AnsiString DataString;    // Строка данных
  int StartIndex,EndIndex;  // Индексы

  float Q, V1, V2, V3, V4;
  float SumQ, SumV1, SumV2, SumV3, SumV4, SumT1, SumT2;

  int CurRow = 1;
  int CurCol = 1;


  // Если данных нет - завершение работы
  if(HDLines->Count < 1) return;

  // Установка начальной и конечной даты
  if(csdt.refComboIndex<3)
  {
    MasterExportForm->DateFrom = StrToDate(((PHData)(HDLines->Items[0]))->dt);
    MasterExportForm->DateTo = StrToDate(((PHData)(HDLines->Items[HDLines->Count-1]))->dt);
  }

  if(csdt.refComboIndex<3)
  {

    if(csdt.dioType==dio2T4V)
    {
      // Установка типа отчета и прибора
      MasterExportForm->RepInfo->RepType.RepType = rpDay;
      MasterExportForm->RepInfo->DioType.DioType = dio2T4V;

      if(MasterExportForm->ShowModal() == mrOk)
      {
        StartIndex = findDate(MasterExportForm->dtpStartDate->Date);
        if(StartIndex < 0) StartIndex = 0;
        EndIndex = findDate(MasterExportForm->dtpEndDate->Date);
        if(EndIndex > HDLines->Count) EndIndex = HDLines->Count;

        TWordApp WordApp(true);
        WordApp.AddDocument(MasterExportForm->ReportFileName);
        // Заполнение статичной информации
        WordApp.FindAndReplace("$DOCNAME$",MasterExportForm->RepInfo->DocName);
        WordApp.FindAndReplace("$DOCINFO$",MasterExportForm->RepInfo->DocInfo + DateTimeToStr(csdt.archCompDate));
        WordApp.FindAndReplace("$ADDRESS$",AnsiString(desc.addr));  // Адрес
        WordApp.FindAndReplace("$OWNER$",AnsiString(desc.owner));   // Вдаделец
        WordApp.AddStaticInfo(csdt);
        // Формирование таблицы
        // Заголовок (название таблицы)
        WordApp.FindAndReplace("$TABLECAPTION$",MasterExportForm->RepInfo->TableCaption + DateToStr(MasterExportForm->dtpStartDate->Date) + " по " + DateToStr(MasterExportForm->dtpEndDate->Date));
        // Поиск места таблицы
        if(WordApp.Find("$TABLESTART$"))
        {
          // Создание таблицы
          Variant Table = WordApp.AddTable(WordApp.SelectionRange,
          MasterExportForm->RepInfo->Columns.EnabledCount, EndIndex - StartIndex + 4);

          WordApp.SetTableBorder(Table);
          // Формирование строки заголовка
          CurCol = 1;
          for(int c = 0; c < MasterExportForm->RepInfo->Columns.Count; c++)
            if(MasterExportForm->RepInfo->Columns.Item[c].Enabled)
            {
              Table.OleFunction("Cell",1,CurCol).OlePropertyGet("Range").OlePropertySet("Text",
              MasterExportForm->RepInfo->Columns.Names[c].c_str());
              // Горизонтальное выравнивание по центру
              Table.OleFunction("Cell",1,CurCol).OlePropertyGet("Range").OlePropertyGet("ParagraphFormat").OlePropertySet("Alignment",1);
              Table.OleFunction("Cell",1,CurCol).OlePropertyGet("Range").OlePropertyGet("Font").OlePropertySet("Bold",1);
              CurCol++;
            }
          Table.OlePropertyGet("Range").OlePropertyGet("ParagraphFormat").OlePropertySet("Alignment",1);

          if(!MasterExportForm->cbNakop->Checked)
          {
            Q = 0; V1 = 0; V2 = 0; V3 = 0; V4 = 0;
            SumQ = 0; SumV1 = 0; SumV2 = 0; SumV3 = 0; SumV4 = 0; SumT1 = 0; SumT2 = 0;
            if(StartIndex > 0)
            {
              astr=(PHData)HDLines->Items[StartIndex - 1];
              Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3; V4 = astr->V4;
            } else
              MasterExportForm->cbNakop->Checked = true;
          }

          CurRow = 2;
          int ColIndex = 0;
          AnsiString TmpStr = "";
          for(int i= StartIndex; i <= EndIndex; i++)
          {
            CurCol = 1;
            astr=(PHData)HDLines->Items[i];
            for(int j = 0; j < MasterExportForm->RepInfo->Columns.Count; j++)
            {
              if(MasterExportForm->RepInfo->Columns.Item[j].Enabled)
              {

                ColIndex = TRepColInfo::IndexOf(MasterExportForm->RepInfo->Columns.Names[j]);
                switch (ColIndex) {
                  case 0:   TmpStr = astr->dt; break;
                  case 1:   TmpStr = FloatToStrF(astr->Q - Q,ffFixed,12,2); break;
                  case 2:   break;
                  case 3:   TmpStr = FloatToStrF(astr->t1,ffFixed,5,2);  break;
                  case 4:   TmpStr = FloatToStrF(astr->t2,ffFixed,5,2);  break;
                  case 5:   TmpStr = FloatToStrF(astr->t1 - astr->t2,ffFixed,5,2); break;
                  case 6:   TmpStr = FloatToStrF(astr->V1 - V1,ffFixed,12,2);  break;
                  case 7:   TmpStr = FloatToStrF(astr->V2 - V2,ffFixed,12,2);  break;
                  case 8:   TmpStr = FloatToStrF(astr->V3 - V3,ffFixed,12,2);   break;
                  case 9:   TmpStr = FloatToStrF(astr->V4 - V4,ffFixed,12,2);   break;
                  case 10:  TmpStr = FloatToStrF((astr->V1 - V1) - (astr->V2 - V2),ffFixed,12,2);  break;
                  case 11:  TmpStr = FloatToStrF((astr->V3 - V3) - (astr->V4 - V4),ffFixed,12,2);  break;
                  case 12:   break;
                  case 13:   break;
                  case 14:   break;
                  case 15:   break;
                  case 16:   break;
                  case 17:   break;
                  case 18:  TmpStr = IntToStr((int)astr->ta); break;
                  case 19:  TmpStr = FloatToStrF(astr->Ubat,ffFixed,5,2); break;
                }
                Table.OleFunction("Cell",CurRow,CurCol).OlePropertyGet("Range").OlePropertySet("Text",TmpStr.c_str());
                CurCol++;
              }
            }
            if(!MasterExportForm->cbNakop->Checked)
            {
              SumQ += astr->Q - Q; SumV1 += astr->V1 - V1;
              SumV2 += astr->V2 - V2; SumV3 += astr->V3 - V3;
              SumV4 += astr->V4 - V4;
              SumT1 += astr->t1; SumT2 += astr->t2;
              Q = astr->Q; V1 = astr->V1; V2 = astr->V2; V3 = astr->V3;
              V4 = astr->V4;
            }
            CurRow++;
          }

          // Статистика
          int StatIndex = Table.OlePropertyGet("Rows").OlePropertyGet("Count") - 1;
          Variant StartCell = Table.OleFunction("Cell",StatIndex,1);
          Variant EndCell =   Table.OleFunction("Cell",StatIndex,CurCol - 1);
          StartCell.OleProcedure("Merge",EndCell);
          Table.OleFunction("Cell",StatIndex,1).OlePropertyGet("Range").OlePropertySet("Text","Итоговые значения за отчетный период:");
          Table.OleFunction("Cell",StatIndex,1).OlePropertyGet("Range").OlePropertyGet("ParagraphFormat").OlePropertySet("Alignment",0);
          Table.OleFunction("Cell",StatIndex,1).OlePropertyGet("Range").OlePropertyGet("Font").OlePropertySet("Bold",1);
          StatIndex++;
          CurCol = 1;
          CurRow = Table.OlePropertyGet("Rows").OlePropertyGet("Count");
          for(int j = 0; j < MasterExportForm->RepInfo->Columns.Count; j++)
          {
            if(MasterExportForm->RepInfo->Columns.Item[j].Enabled)
            {
              TmpStr = "";
              ColIndex = TRepColInfo::IndexOf(MasterExportForm->RepInfo->Columns.Names[j]);
              switch (ColIndex) {
                  case 0:   break;
                  case 1:   TmpStr = FloatToStrF(SumQ,ffFixed,12,2); break;
                  case 2:   break;
                  case 3:   TmpStr = FloatToStrF(SumT1/(EndIndex - StartIndex + 1),ffFixed,5,2);  break;
                  case 4:   TmpStr = FloatToStrF(SumT2/(EndIndex - StartIndex + 1),ffFixed,5,2);  break;
                  case 5:   break;
                  case 6:   TmpStr = FloatToStrF(SumV1,ffFixed,12,2);   break;
                  case 7:   TmpStr = FloatToStrF(SumV2,ffFixed,12,2);   break;
                  case 8:   TmpStr = FloatToStrF(SumV3,ffFixed,12,2);   break;
                  case 9:   TmpStr = FloatToStrF(SumV4,ffFixed,12,2);   break;
                  case 10:  break;
                  case 11:  break;
                  case 12:   break;
                  case 13:   break;
                  case 14:   break;
                  case 15:   break;
                  case 16:   break;
                  case 17:   break;
                  case 18:  break;
                  case 19:  break;
              }
              Table.OleFunction("Cell",CurRow,CurCol).OlePropertyGet("Range").OlePropertySet("Text",TmpStr.c_str());
              CurCol++;
            }

          }
        }
      

        // Сохранение документа
        ExportProgresForm->Info = "Сохранение документа";
        ExportProgresForm->AddProgress(1);Application->ProcessMessages();
        //if(MasterExportForm->cbSaveAs->Checked)
          WordApp.SaveDocument(MasterExportForm->edDocFileName->Text.c_str(),
            Trim(MasterExportForm->edPswrdOpen->Text).c_str(),
            Trim(MasterExportForm->edPswrdWrite->Text).c_str());

        ExportProgresForm->Hide();
        WordApp.TerminateAppOnFree = !MasterExportForm->cbOpenMSWord->Checked;
        WordApp.Visible = MasterExportForm->cbOpenMSWord->Checked;

      };
    }

  }

}
//---------------------------------------------------------------------------

