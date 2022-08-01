#include <dos.h>
#include <stdio.h>
#include <bios.h>
#include "i2c.hpp"

extern unsigned char eeprom;

void main(void)
{
 unsigned char n;

 printf("DIO-99 economic card reader\n\n");
while(_bios_keybrd(_KEYBRD_READY)==0)
{
 PortOut(PORTOUT,0x0f);                 // Power on
delay(500);

                 BStart();
                 TX(0xa2);
                 TX(0x00);
                 TX(0x01);
                 TX(0xa5);
                 BStop();

 PortOut(PORTOUT,0x07);                 // blink led
                 delay(50);
 PortOut(PORTOUT,0x0f);                 // blink led
                 BStart();
                 TX(0xa2);
                 TX(0x00);
                 TX(0x00);
                 BStart();
                 TX(0xa3);
                for(unsigned int i=0;i<10;i++)
                 {
                 n=RX();
                 printf("%x ",n);
                 eeprom=0x00;
                 BitOut();
                 //if(n!=0 && n!=0xff)
                 } 
                 BStop();
                 printf("\n");
 PortOut(PORTOUT,0x00);                 // Power off
delay(50);
}
}
