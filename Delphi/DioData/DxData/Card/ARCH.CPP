#include <owl\applicat.h>
#include <owl\dialog.h>
#include <owl\framewin.h>
#include <owl\edit.h>
#include <owl\radiobut.h>
#include <owl\checkbox.h>
#include <owl\listbox.h>
#include <owl\gauge.h>
#include <stdio.h>
#include <math.h>


const
 cm_send 	= 107,
 cm_recv 	= 106,
 cm_clear	= 113,
 cm_sysr		= 118,
 cm_hdata	= 119,
 cm_hrecv	= 102;

const int
 IDC_ES		= 	105,
 IDC_EE		= 	106,
 IDC_E1		= 	101,
 IDC_C1		= 	111,
 IDC_C2		= 	112,
 IDC_PR1		= 	113,
 cm_GetRam	=	0x1c,
 cm_GetEeprom =	0x2c,
 cm_PutRam	=	0x1d,
 cb1			=	101,
 cb2			=	102,
 cb3			=	103,
 cb4			=	104,
 cb5			=	105,
 cb6			=	108;

const char
	cMsg[] =	"Ошибка приема/передачи.\nУбедитесь в надежности соединения!",
   t_name[] = "DIO-99 economic";

bool	clb1,clb2,clb3,clb4,clb5,clb6;

   unsigned int	aargb0;
   unsigned int   aargb1;
   unsigned int   aargb2;
   unsigned int   aexp;

   COMMTIMEOUTS	ctm;
	HANDLE			fhandle;			// указатель порта
   DWORD				nBytes;
   LPSTR				com_char = "COM2";


double far Dec_2_Float(unsigned char ex,unsigned char a1,unsigned char a2,
										unsigned char a3)
{
  double						t,e,z;
  unsigned long			k1,k2;

if (ex==0)
 {
  return 0;
 } else {
		k1=(a1+0x80)*65536+a2*256+a3;
      t=0;
      e=ex-0x27;
     for(int i = 0;i!=-24;i--)
     {
       k2=k1;
       k2&=0x800000;
      if (k2!=0)
       {
         t=t+pow(2,i);
       }
      k1 <<= 1;
     }
    z=pow(2,long(e))*t;
    return z;
  }
}

void  Float_2_Dec(float iee)
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

void SendByte(char far n)
{
	WriteFile(fhandle,&n,1,&nBytes,NULL);
}

char RecvByte()
{
	char	far n;
   //n=0;
  ReadFile(fhandle,&n,1,&nBytes,NULL);

  return n;
}

void OpenConnection()
{
     DCB 	fdcb;
     LPSTR 	pconf="96,N,8,1";

     if(!BuildCommDCB(pconf,&fdcb))
     {
       //MessageBox(NULL,"Аппаратная ошибка!","");
     } else
     {
     fhandle=CreateFile(com_char,GENERIC_READ|GENERIC_WRITE,
     					FILE_SHARE_READ|FILE_SHARE_WRITE,NULL,OPEN_EXISTING,
                  FILE_ATTRIBUTE_NORMAL,NULL);

     if(!SetCommState(fhandle,&fdcb))
     {
     	//MessageBox(cMsg,t_name,MB_ICONEXCLAMATION);
     } else
     {
                  // установка таймаут-а порта
                  ctm.ReadIntervalTimeout=1000;
                  ctm.ReadTotalTimeoutMultiplier=1000;
                  ctm.ReadTotalTimeoutConstant=200;

                  SetCommTimeouts(fhandle,&ctm);

			EscapeCommFunction(fhandle,CLRRTS);
      	EscapeCommFunction(fhandle,SETDTR);
     }

    }
}


void delayMilliSeconds(DWORD mSec)
{
	DWORD	dwStartTime ;

	dwStartTime = GetCurrentTime() ;
	if(!mSec)
		return ;
	do {
	} while( (GetCurrentTime() - dwStartTime) < mSec) ;

}

void CloseConnection()
{
      CloseHandle(fhandle);
}

class THdataDlg: public TDialog {
public:
   float q1;
   float t1;
   float t2;
   float t3;
   float m1;
   float m2;
   float m3;
   float m4;
   unsigned char  n;
   unsigned char	b[65];
   unsigned char far	sBuf[200];
	TListBox*	e1;
	TListBox*	e2;
   TEdit*		es;
   TEdit*		ee;
   TGauge*		pbar;

 THdataDlg();
protected:
 long j,i;
 int sthr,numhr;
 void	 SetupWindow();
 void	 Cm_Hrecv();
 void  EvTimer();
 DECLARE_RESPONSE_TABLE(THdataDlg);
 };
DEFINE_RESPONSE_TABLE1(THdataDlg,TDialog)
	EV_COMMAND(cm_hrecv,Cm_Hrecv),
END_RESPONSE_TABLE;

THdataDlg::THdataDlg():TDialog(NULL,3)
{
 	e1=new TListBox(this,IDC_E1);
 	e2=new TListBox(this,104);
   es=new TEdit(this,IDC_ES);
   ee=new TEdit(this,IDC_EE);
   pbar = new TGauge(this, IDC_PR1, 20,275,300,16);
}

 int tabs[12]={15,30,45,60,85,105,125,160,195,230,265,300};

void THdataDlg::EvTimer()
{
  MessageBox("sdfsdfs");
}

void THdataDlg::SetupWindow()
{
TWindow::SetupWindow();
 sprintf(sBuf,"Чс.\tМес\tЧас\tОш.\t tп\t tо\t tх\t Mп\t Mо\t Мгвс\t Мпп\t W,Гкал");
 e2->ClearList();
 e2->AddString(sBuf);
 e2->SetTabStops(12,tabs);
 es->Insert("1");
 ee->Insert("10");
}


void THdataDlg::Cm_Hrecv()
{

 OpenConnection();

 es->GetLine(sBuf,4,1);
 sthr=atoi(sBuf);
 ee->GetLine(sBuf,4,1);
 numhr=atoi(sBuf);

if (sthr>=numhr)
 {
   MessageBox("Неверно задан диапазон!");
	CloseConnection();
     return;
 }

   pbar->SetRange(sthr,numhr);
   pbar->SetStep(5);
	pbar->SetLed(4, 80);

 e1->ClearList();
 e1->SetTabStops(12,tabs);


for (j=sthr;j<=numhr;j++)
 {

 	delayMilliSeconds(50);
 	SendByte(0xaa);
   SendByte(cm_GetEeprom);
   n=RecvByte();
   if (n!=0xaa)
   {
     	MessageBox(cMsg,t_name,MB_ICONEXCLAMATION);
		   CloseConnection();
      return;
   } else
   {
   SendByte(UCHAR(j*32));			// адрес
   SendByte(UCHAR(j*32/256));			// адрес
   SendByte(64);			// кол-во

 for(i=1;i<=64;i++)
   {
     b[i]=RecvByte();
  }
  pbar->SetValue(j);
    q1 = Dec_2_Float(b[32],b[29],b[30],b[31]);
    t1 = Dec_2_Float(b[7],b[5],b[6],0);
    t2 = Dec_2_Float(b[10],b[8],b[9],0);
    t3 = Dec_2_Float(b[12],b[11],0,0);					// холодная вода - целым числом.

      m1 = Dec_2_Float(b[16],b[13],b[14],b[15]);
      m2 = Dec_2_Float(b[20],b[17],b[18],b[19]);
      m3 = Dec_2_Float(b[24],b[21],b[22],b[23]);
      m4 = Dec_2_Float(b[28],b[25],b[26],b[27]);
    sprintf(sBuf,"%2u\t%2u\t%2u\t%003i\t%5.2f\t%5.2f\t%5.2f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%u",b[1],b[2],b[3],b[4],t1,t2,t3,m1,m2,m3,m4,q1,j);
    e1->AddString(sBuf);
		j++;
    q1 = Dec_2_Float(b[64],b[61],b[62],b[63]);
    t1 = Dec_2_Float(b[39],b[37],b[38],0);
    t2 = Dec_2_Float(b[42],b[40],b[41],0);
    t3 = Dec_2_Float(b[44],b[43],0,0);					// холодная вода - целым числом.

      m1 = Dec_2_Float(b[48],b[45],b[46],b[47]);
      m2 = Dec_2_Float(b[52],b[49],b[50],b[51]);
      m3 = Dec_2_Float(b[56],b[53],b[54],b[55]);
      m4 = Dec_2_Float(b[60],b[57],b[58],b[59]);
    sprintf(sBuf,"%2u\t%2u\t%2u\t%003i\t%5.2f\t%5.2f\t%5.2f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%u",b[33],b[34],b[35],b[36],t1,t2,t3,m1,m2,m3,m4,q1,j);
    e1->AddString(sBuf);
    }
  }
  CloseConnection();
  pbar->SetValue(0);
}

class TSysDlg: public TDialog {
public:
 TSysDlg();
protected:
};

class TChangeApp: public TApplication
{ public:
	  virtual void InitMainWindow();
};

void TChangeApp::InitMainWindow()
{
 MainWindow = new TFrameWindow(NULL,"Программа связи DIO-99 economic",new THdataDlg,TRUE);
}

int OwlMain(int,char**)
{
 return TChangeApp().Run();
}