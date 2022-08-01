//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "wcrd.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CGAUGES"
#pragma resource "*.dfm"
TcardMan *cardMan;
//---------------------------------------------------------------------------
#include "windrvr.h"
UCHAR eeprom;
int PORTOUT;
int PORTIN;
const int parRes[3]={0x278,0x378,0x3bc};

// put your IO range here
// in this example the range is 0x378-0x37a
enum {MY_IO_BASE = 0x378};
enum {MY_IO_SIZE = 0x3};

// global WinDriver handle
HANDLE hWD;
// global card handle
WD_CARD_REGISTER cardReg;

void delay(int i)
{
  for(int k=0;k<i;k++) {}
}

BYTE __fastcall PortIn(DWORD dwIOAddr)
{
    WD_TRANSFER trns;
    BZERO(trns);
    trns.cmdTrans = RP_BYTE; // R-Read P-Port BYTE
    trns.dwPort = dwIOAddr;
    WD_Transfer( hWD, &trns); // Perform read
    return trns.Data.Byte;
}

void __fastcall PortOut(DWORD dwIOAddr, BYTE bData)
{
    WD_TRANSFER trns;
    BZERO(trns);
    trns.cmdTrans = WP_BYTE; // R-Write P-Port BYTE
    trns.dwPort = dwIOAddr;
    trns.Data.Byte = bData;
    WD_Transfer( hWD, &trns); // Perform write
}

void __fastcall BStart(void)       // send start bit to e2prom
{
  PortOut(PORTOUT,0x0f);        // set clock high
  PortOut(PORTOUT,0x0e);        // set data low for start bit
 delay(1000);
  PortOut(PORTOUT,0x0c);        // start clock train
 delay(1000);
}

void __fastcall BStop(void)        // send stop bit to e2prom
{
delay(1000);
  PortOut(PORTOUT,0x0c);        // make sure that data is low
                                // and clock is low
  PortOut(PORTOUT,0x0e);        // set clock high
  PortOut(PORTOUT,0x0f);        // set data high for stop bit
 delay(1000);
  PortOut(PORTOUT,0x0d);        // set clock low
  PortOut(PORTOUT,0x0d);        // set clock low
 delay(1000);
}

void __fastcall BitOut(void)
{
    if((eeprom & 0x80)!=0)
     {  // - 1
      PortOut(PORTOUT,0x0d);
      PortOut(PORTOUT,0x0f);
      PortOut(PORTOUT,0x0d);
     } else
     {  // - 0
      PortOut(PORTOUT,0x0c);        // set data low and clock low
      PortOut(PORTOUT,0x0e);        // toggle clock
      PortOut(PORTOUT,0x0c);
     }
}

void __fastcall BitIn(void)
{
  byte n;

  PortOut(PORTOUT,0x0d);
  PortOut(PORTOUT,0x0f);
  n = PortIn(PORTIN);
  if((n & 0x40)!=0) {
   eeprom++;
    }
  PortOut(PORTOUT,0x0d);
}

void TX(unsigned char n)
{
eeprom=n;
 for(byte i=0;i<8;i++)
 {
  BitOut();
  eeprom = eeprom << 1;
 }
 eeprom=0;
  BitIn();               // check for eeprom ACK
}

unsigned char RX(void)
{
 eeprom=0;
 for(byte i=0;i<8;i++)
 {
  eeprom = eeprom << 1;
   BitIn();
 }
return eeprom;
}

BOOL IO_init()
{
    WD_VERSION verBuf;

	hWD = INVALID_HANDLE_VALUE;
    hWD = WD_Open();
    if (hWD==INVALID_HANDLE_VALUE)
    {
//        Application->MessageBox("error opening WINDRVR","",0);
        return FALSE;
    }

    BZERO(verBuf);
    WD_Version (hWD, &verBuf);
    if (verBuf.dwVer<WD_VER)
    {
		WD_Close(hWD);
        return FALSE;
    }

    BZERO(cardReg);
    cardReg.Card.dwItems = 1;
    cardReg.Card.Item[0].item = ITEM_IO;
    cardReg.Card.Item[0].fNotSharable = TRUE;
    cardReg.Card.Item[0].I.IO.dwAddr = MY_IO_BASE;
    cardReg.Card.Item[0].I.IO.dwBytes = MY_IO_SIZE;
    cardReg.fCheckLockOnly = FALSE;
    WD_CardRegister (hWD, &cardReg);
    if (cardReg.hCard==0)
    {
//        Application->MessageBox("Failed locking device","",0);
        return FALSE;
    }

    return TRUE;
}

void IO_end()
{
    WD_CardUnregister(hWD,&cardReg);
    WD_Close(hWD);
}

__fastcall TcardMan::TcardMan(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void TcardMan::getCardInfo()
{
  unsigned char slave_addr;
  static unsigned char bufA[64];

  for(byte k=0;k<3;k++)
  {
    PORTOUT=parRes[k];
    PORTIN=PORTOUT+1;
    cardInfo.icCount=0;
    devList->Items->Clear();
    PortOut(PORTOUT,0x0f);                 // Power on
    delay(200);

    for(byte j=2;j<8;j++)
    {
      slave_addr=0xa0+(j << 1);
      BStart(); TX(slave_addr); TX(0x00); TX(0x00); BStart(); TX(slave_addr+1);
      for(byte i=0;i<63;i++)
      {
        bufA[i]=RX();
        eeprom=0;
        BitOut();
      }
      eeprom=0x80;    // No Ack bit;
	    BitOut();
      BStop();
      if((bufA[0]!=0xff)&(bufA[0]!=0xaa)&(bufA[0x3c]!=0)&(bufA[0x3d]!=0))
      {
        switch(bufA[0x3e])
        {
          case 0xff:
            devList->Items->Add(IntToStr(bufA[0x3c]*256+bufA[0x3d])+" (Версия: 2T4V)");
            break;
          case 0xaa:
            devList->Items->Add(IntToStr(bufA[0x3c]*256+bufA[0x3d])+" (Версия: 3T3V)");
            break;
          case 0xa8:
            devList->Items->Add(IntToStr(bufA[0x3c]*256+bufA[0x3d])+" (Версия: 4T4V)");
            break;
        } // switch
        cardInfo.icCount++;
      }      //if

      if(bufA[0]==0xaa)
      {
        devList->Items->Add("Пусто.");
        cardInfo.icCount++;
      } //if
 //     devList->Items->Add(IntToStr(j)+" "+IntToHex(bufA[0],2));
    }

    if(cardInfo.icCount!=0)
    {
      Label1->Caption="Обнаружена карта NT "+IntToStr(cardInfo.icCount)+
                   "-"+IntToStr(cardInfo.icCount*32);
      break;
    } else
      Label1->Caption="Карты не обнаружено.";
  }
  pName->Caption="Порт 0x"+IntToHex(PORTOUT,3);
}

void __fastcall TcardMan::FormActivate(TObject *Sender)
{
   eDataValid=false;
   for(int i=0; i<32768;i++) eData[i]=0;
   if (IO_init())
    {
        Update();
        getCardInfo();
    IO_end();
    } else
    { Application->MessageBox("Невозможно активировать\nдрайвер устройства","",0);
     }
}
//---------------------------------------------------------------------------


void __fastcall TcardMan::getDataBtnClick(TObject *Sender)
{
byte    slave_addr,b;
if(devList->ItemIndex!=-1)
   if (IO_init())
    {
    PortOut(PORTOUT,0x0f);                 // Power on
        delay(100);
      slave_addr=0xa0+(((byte)(devList->ItemIndex)+2)<<1);
      Label1->Caption="Addr="+IntToHex(slave_addr,2);
        BStart();
        TX(slave_addr);
        TX(0x00);
        TX(0x00);
        BStart();
        TX(slave_addr+1);
       pb1->Progress=0;
       pb1->Visible=true;
         for(int i=0;i<32768;i++)
          {
               b=RX();
               eData[i]=b;
               eeprom=0;
               BitOut();
              pb1->Progress=i;
          }
        eeprom=0x80;    // No Ack bit;
	BitOut();
        BStop();
    IO_end();
    pb1->Progress=0;
    pb1->Visible=false;
   eDataValid=true;
   Close();
    } else
    { Application->MessageBox("Невозможно активировать\nдрайвер устройства","",0);
     } else
     devList->DroppedDown=true;
}
//---------------------------------------------------------------------------

void __fastcall TcardMan::Button1Click(TObject *Sender)
{
Close();
}
//---------------------------------------------------------------------------
void __fastcall TcardMan::FormPaint(TObject *Sender)
{
const
        fHeight=20,
        gSteps=255;
TRect r;
int lColor;
 r.left=0; r.top=0; r.right=Width; r.bottom=Height;
 Canvas->Brush->Color=clBlack;
 Canvas->FrameRect(r);

 for(int i=1;i<Width-1;i++) {
  lColor=((float)gSteps/Width)*i;
   Canvas->Pen->Color=RGB(lColor,lColor,lColor);
   Canvas->MoveTo(i,1);
   Canvas->LineTo(i,fHeight);
 } //for

 Canvas->Pen->Color=clBlack;
 for(int i=1;i<fHeight;i+=2) {
   Canvas->MoveTo(1,i);
   Canvas->LineTo(Width-1,i);
 } //for

Canvas->Brush->Style=bsClear;
Canvas->Font->Style=TFontStyles()<<fsBold;
Canvas->Font->Size=8;
Canvas->Font->Color=clWhite;
Canvas->TextOut(Width/2-Canvas->TextWidth(Caption)/2,fHeight/2-Canvas->TextHeight(Caption)/2,Caption);
}
//---------------------------------------------------------------------------

void __fastcall TcardMan::Button2Click(TObject *Sender)
{
byte    slave_addr;
if(devList->ItemIndex!=-1)
   if (IO_init())
    {
    PortOut(PORTOUT,0x0f);                 // Power on
     delay(100);
      slave_addr=0xa0+(((byte)(devList->ItemIndex)+2)<<1);
        BStart();
        TX(slave_addr);
        TX(0);
        TX(0);
        TX(0xaa);
        BStop();
        getCardInfo();
      IO_end();
    }//if

}
//---------------------------------------------------------------------------

void __fastcall TcardMan::Button3Click(TObject *Sender)
{
byte    slave_addr;
   if (IO_init())
    {
  if(Application->MessageBox("Вы действительно хотите удалить\nданные из всех ячеек карты?","Удаление данных!",MB_OKCANCEL|MB_ICONEXCLAMATION)==IDOK)
 for(byte j=2;j<(byte)(devList->Items->Count)+2;j++) {
    PortOut(PORTOUT,0x0f);                 // Power on
     delay(100);
      slave_addr=0xa0+(j<<1);
        BStart();
        TX(slave_addr);
        TX(0);
        TX(0);
        TX(0xaa);
        BStop();
    } //for
      getCardInfo();
      IO_end();
  } //if
}
//---------------------------------------------------------------------------

void __fastcall TcardMan::devListChange(TObject *Sender)
{
 if(devList->Items->Strings[devList->ItemIndex]==AnsiString("Пусто.")) {
     Button2->Enabled=false;
 } else
 {
     Button2->Enabled=true;
 }
}
//---------------------------------------------------------------------------

