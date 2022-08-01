#include <dos.h>
#include <stdio.h>
#include <dir.h>
#include <math.h>
#include "i2c.hpp"

extern unsigned char eeprom;

 const char dname[8]="CARDOUT"; 

unsigned char aexp,aargb0,aargb1,aargb2;

float far Dec_2_Float(unsigned char ex,unsigned char a1,unsigned char a2,
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
         t+=pow(2,double(i));
       }
      k1<<=1;
     }
     z=pow(2.,double(e))*t;
    return z;
  }
}

void main(void)
{
 unsigned char n,slave_addr;

 printf("\nDIO-99 чтение содержимого карты\n\n");

 int stat = mkdir(dname);
 if(stat)
 {
  stat=chdir(dname);
   if(stat)
    {
    printf("Ошибка записи на диск!\n");
    return;
    }
 }
  stat=chdir(dname);

 FILE *f;
 char *fname;
 unsigned char dbuf[64];

 float t1,t2,t3,t4,f1,f2,f3,f4,q1,q2;

CalculateDelay();
for(unsigned char j=1;j<8;j++)
{
 sprintf(fname,"ic%i.bdt",j);
 f=fopen(fname,"w+t");
 slave_addr=0xa0+(j << 1);
printf("IC No. %i ",j);

delay(100);
PortOut(PORTOUT,0x0f);                 // Power on
delay(300);
                 BStart();
                 TX(slave_addr);
                 TX(0x00);
                 TX(0x00);
                 BStart();
                 TX(slave_addr+1);
                 n=RX();
                 eeprom=0x80;    // No Ack bit;
		 BitOut();
                 BStop();
      switch(n)
       {
        case 0xaa:
                  printf("-> пустая ячейка карты.\n");
                  break;
        case 0xff:
                  printf("?\n");
		  break;
        default: {
          printf("Чтение... No: ");

                 BStart();
		 TX(slave_addr);
                 TX(0x7f);
                 TX(0xc0);
                 BStart();
                 TX(slave_addr+1);
                 for(int j=0;j<8;j++)
		{
		  n=RX();
                      fprintf(f,"%c",n);
                      printf("%c",n);
                  eeprom=0x00;
		  BitOut();
                }
                BStop();
                printf(" .");
                fprintf(f,"\n");
fprintf(f,"Дата\tВремя\tКод\tt1,oC\tt2,oC\tM1,m3\tM2,m3\tQ1,ГКал\tt3,oC\tt4,oC\tM3,m3\tM4,m3\tQ2,ГКал");
                 BStart();
		 TX(slave_addr);
                 TX(0x00);
                 TX(0x00);
                 BStart();
                 TX(slave_addr+1);
                for(int i=0;i<1022;i++)
                {
 		 for(int i=0;i<32;i++)
		{
		  n=RX();
			dbuf[i]=n;
		  eeprom=0x00;
		  BitOut();
                }
f1=0; f2=0; f3=0; f4=0;
t1=(float)(dbuf[4]*256+dbuf[5])/100;
t2=(float)(dbuf[6]*256+dbuf[7])/100;
t3=(float)(dbuf[8]*256+dbuf[9])/100;
t4=(float)(dbuf[10]*256+dbuf[11])/100;
//
f1=Dec_2_Float(dbuf[14],dbuf[12],dbuf[13],0)/1000;
f2=Dec_2_Float(dbuf[17],dbuf[15],dbuf[16],0)/1000;
f3=Dec_2_Float(dbuf[20],dbuf[18],dbuf[19],0)/1000;
f4=Dec_2_Float(dbuf[23],dbuf[21],dbuf[22],0)/1000;
//
/*f1=Dec_2_Float(dbuf[14],dbuf[12],dbuf[13],0);
f2=Dec_2_Float(dbuf[17],dbuf[15],dbuf[16],0);
f3=Dec_2_Float(dbuf[20],dbuf[18],dbuf[19],0);
f4=Dec_2_Float(dbuf[23],dbuf[21],dbuf[22],0);*/
//
q1=Dec_2_Float(dbuf[27],dbuf[24],dbuf[25],dbuf[26]);
q2=Dec_2_Float(dbuf[31],dbuf[28],dbuf[29],dbuf[30]);


float dt;

if((dbuf[0]<=31)&(dbuf[1]<=12))
{
if ( (t1!=0) & (t2!=0) )
 dt = float(int(t1*100)-int(t2*100))/100;
else
 dt=0;
if (dbuf[3] & 0x01) t1=0;
if (dbuf[3] & 0x02) t2=0;
if (dbuf[3] & 0x04) t3=0;
if (dbuf[3] & 0x08) t4=0;

if(dbuf[0]!=0xff) {
 fprintf(f,"\n%02i/%02i\t%02i:00\t\%i\t%5.2f\t%5.2f\t%7.4f\t%7.4f\t%7.4f\t%5.2f\t%5.2f\t%7.4f\t%7.4f\t%7.4f",
        dbuf[0],dbuf[1],dbuf[2],dbuf[3],
        t1,t2,f1,f2,q1,t3,t4,f3,f4,q2);
                }
   }
}
   BStop();
  PortOut(PORTOUT,0x00);                 // Power off
   printf("Ok. \n");
  }
 }
     fclose(f);
stat=chdir("/..");
 PortOut(PORTOUT,0x00);                 // Power off
}
}

