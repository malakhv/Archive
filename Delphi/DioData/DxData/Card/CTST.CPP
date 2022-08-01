#include <dos.h>
#include <stdio.h>
#include <conio.h>
#include <bios.h>

const
	PORTOUT = 0x378,
	PORTIN = 0x379;

void s_delay(void)
{
 for(int i=0; i<200; i++) {};
}

void PortOut(unsigned int port,unsigned char value)
{
    asm {
	mov     dx,port
	mov     al,value
	out     dx,al
	}
s_delay();
}

unsigned char PortIn(unsigned int port)
{
  unsigned char value;
    asm {
	mov     dx,port
	in      al,dx
	mov     value,al
	}
  s_delay();
  return value;
}

void TX(unsigned char b)
{
 PortOut(PORTOUT,0x00); // goes clock low
 for(int i=0;i<8;i++)
 {
  if((b & 0x80)!=0)
  {
   PortOut(PORTOUT,0x02);
   PortOut(PORTOUT,0x03); //toggle clock
   PortOut(PORTOUT,0x02);
  }
   else
 {
   PortOut(PORTOUT,0x00);
   PortOut(PORTOUT,0x02); //toggle clock
   PortOut(PORTOUT,0x00);
  }
 b = b << 1;
 }
   PortOut(PORTOUT,0x02); //goes clock high
}

unsigned char RX(void)
{
unsigned char n, eeprom = 0;
PortOut(PORTOUT,0x0);	// goes clock low
 for(int i=0;i<8;i++)
 {
  eeprom = eeprom << 1;
  PortOut(PORTOUT,0x02); // goes clock high
  PortOut(PORTOUT,0x00);
  n = PortIn(PORTIN);
  if((n & 0x40)!=0) {
   eeprom++;
    }
  PortOut(PORTOUT,0x02);
 }
return eeprom;
PortOut(PORTOUT,0x03);
}

void main(void)
{
 unsigned char n,slave_addr;

 PortOut(PORTOUT,0x03);                 // Power on
  while(!kbhit())
  {
    TX(0x38); // data reading
   printf("%0x",RX());
   printf("%0x",RX());
  }
 PortOut(PORTOUT,0x00);                 // Power off
}
