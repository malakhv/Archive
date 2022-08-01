#include <dos.h>
#include <stdio.h>
#include <bios.h>
#include "i2c.hpp"

extern unsigned char eeprom;

void main(void)
{
 unsigned char n,sa;

 printf("DIO-99 economic\nОчистка ячеек карты:\nПорт: %xh\n\n",PORTOUT);
 
PortOut(PORTOUT,0x0f);                 // Power on
for(unsigned i=1;i<8;i++)
 {
 delay(200);
          sa=0xa0+(i<<1);
                 BStart();
                 TX(sa);
                 TX(0x00);
                 TX(0x00);
                 TX(0xaa);
                 BStop();
    delay(50);
                 BStart();
                 TX(sa);
                 TX(0x00);
                 TX(0x00);
                 BStart();
                 TX(sa+1);
                 n=RX();
                 eeprom=0x80;
                 BitOut();
                 BStop();
                 if (n==0xaa)
                  printf("Ячейка %i [%x] очищена\n",i,sa); else
                  printf("Ячейка %i [%x] ошибка записи\n",i,sa);
    delay(50);
}
 PortOut(PORTOUT,0x00);                 // Power off
delay(50);
 PortOut(PORTOUT,0x00);                 // Power off
}
