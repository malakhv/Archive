//---------------------------------------------------------------------------
#include <vcl.h>
#include <stdio.h>
#pragma hdrstop

#include "FDCon.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cgauges"
#pragma resource "*.dfm"
TDCon *DCon;
//---------------------------------------------------------------------------
__fastcall TDCon::TDCon(TComponent* Owner)
    : TForm(Owner)
{

}

void    TDCon::loadCtrlBlock()
{
}

void    TDCon::GetHDataAddr(unsigned char *hAddr,unsigned char *lAddr)
{

}

void    TDCon::ClearCntrs()
{
 sbytes=0; rbytes=0;
 Invalidate();
 Repaint();
}



void TDCon::delayMilliSeconds(DWORD mSec)
{
	DWORD	dwStartTime ;

	dwStartTime = GetCurrentTime() ;
	if(!mSec)
		return ;
	do {
	} while( (GetCurrentTime() - dwStartTime) < mSec) ;

}

bool TDCon::OpenConnection(LPSTR com_char)
{
     DCB 	fdcb;
     LPSTR 	pconf="baud=2400 parity=N data=8 stop=1";

     if(!BuildCommDCB(pconf,&fdcb))
     {
       MessageBox(this,"Аппаратная ошибка!\nBuildCommDCB","!!!",0);
     } else
     {
     fhandle=CreateFile(com_char,GENERIC_READ|GENERIC_WRITE,
     					FILE_SHARE_READ|FILE_SHARE_WRITE,NULL,OPEN_EXISTING,
                  FILE_ATTRIBUTE_NORMAL,NULL);

  		GetCommState(fhandle,&fdcb);
		fdcb.BaudRate=CBR_2400;
      fdcb.Parity=0;
      fdcb.ByteSize=8;
      fdcb.StopBits=0;
     if(!SetCommState(fhandle,&fdcb))
     {
		GetCommState(fhandle,&fdcb);
      sprintf(buf,"Аппаратная ошибка!\nSetCommState\nBaud:%i",fdcb.BaudRate);
       MessageBox(this,buf,"!!!",0);

     } else
     {
                  // установка таймаут-а порта
                  ctm.ReadIntervalTimeout=100;
                  ctm.ReadTotalTimeoutMultiplier=50;
                  ctm.ReadTotalTimeoutConstant=100;

                  SetCommTimeouts(fhandle,&ctm);

			EscapeCommFunction(fhandle,SETRTS);
      	EscapeCommFunction(fhandle,SETDTR);
        return true;
     }

    }

			EscapeCommFunction(fhandle,CLRRTS);
      	EscapeCommFunction(fhandle,CLRDTR);
      CloseHandle(fhandle);
  return false;
}

void TDCon::SendByte(char far n)
{
	WriteFile(fhandle,&n,1,&nBytes,NULL);
    sbytes++;
}

unsigned char TDCon::RecvByte()
{
	char	far n;

  ReadFile(fhandle,&n,1,&nBytes,NULL);
  rbytes++;

 return n;
}

void TDCon::CloseConnection()
{
			EscapeCommFunction(fhandle,CLRRTS);
      	EscapeCommFunction(fhandle,CLRDTR);
      CloseHandle(fhandle);
}

bool TDCon::SendByteSeq(unsigned char b)
{
unsigned char n1;
bool retval;
int i;

 for(i=0;i<30;i++)
  {
   SendByte(b);
   n1=RecvByte();

    if(n1!=b) {
       	delayMilliSeconds(20);
     SendByte(rep_byte);
     retval=false;
    } else
    {
      	delayMilliSeconds(20);
     SendByte(ok_byte);
		retval=true;
      break;
    }
  }
    qv=100-i*10;
  Update();
  return retval;
}

//---------------------------------------------------------------------------

void __fastcall TDCon::BitBtn1Click(TObject *Sender)
{
 UserCancelled=true;
}
//---------------------------------------------------------------------------


void __fastcall TDCon::FormPaint(TObject *Sender)
{
    sended->Caption="Отправлено: "+IntToStr(sbytes)+" байт.";
    received->Caption="Принято: "+IntToStr(rbytes)+" байт";
    pbq->Position=qv;
}
//---------------------------------------------------------------------------

void __fastcall TDCon::FormCreate(TObject *Sender)
{
qv=0;
ConPB->Position=0;
UserCancelled=false;
}
//---------------------------------------------------------------------------




