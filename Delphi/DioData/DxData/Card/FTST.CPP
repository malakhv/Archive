#include <dos.h>
#include <stdio.h>
#include <dir.h>
#include <math.h>

float far Dec_2_Float(unsigned char ex,unsigned char a1,unsigned char a2,
                        unsigned char a3)
{
  double                        t,e;
  unsigned long			k1,k2;
  float                         z;
if(a1>127)
 return 0;
if( (ex==255)|(a1==255))
 return 0;
if(ex>200)
 return 0;
if (ex==0)
 {
  return 0;
 } else {
      k1=((a1 + 0x81))*65536 + a2*256 + a3;
      t=0;
      e = ex - 0x27;
     for(int i = 0;i!=-24;i--)
     {
       k2 = k1;
      if (k2 & 0x800000)
       {
         t+=pow(2.,double(i));
       }
      k1<<=1;
     }
     z=pow(2.,double(e))*t;
    return z;
  }
}

void main(void)
{
 float a=Dec_2_Float(0x2d,0x43,0x00,0x00);
 printf("%5.4f",a);
}
