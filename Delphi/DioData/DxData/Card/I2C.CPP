//
// функции для эмуляции i2c протокола через LPT порт
//
#include "i2c.hpp"

unsigned char eeprom;
unsigned int d_acc;

void s_delay(void)
{
   asm  mov     cx,0x02ff;
__1:
   asm  loop    __1;
     
}

void CalculateDelay()
{
struct time s_tm;
struct time n_tm;
unsigned int pfm = 0;		// calculated perfomance

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

void BStart(void)       // send start bit to e2prom
{
  PortOut(PORTOUT,0x0f);        // set clock high
  PortOut(PORTOUT,0x0e);        // set data low for start bit
 delay(1);
  PortOut(PORTOUT,0x0c);        // start clock train
 delay(1);
}

void BStop(void)        // send stop bit to e2prom
{
delay(1);
  PortOut(PORTOUT,0x0c);        // make sure that data is low
                                // and clock is low
  PortOut(PORTOUT,0x0e);        // set clock high
  PortOut(PORTOUT,0x0f);        // set data high for stop bit
 delay(1);
  PortOut(PORTOUT,0x0d);        // set clock low
 delay(1);
}

void BitOut(void)
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

void BitIn(void)
{
  unsigned char n;

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
 for(int i=0;i<8;i++)
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
//PortOut(PORTOUT,0x0f);        
 for(int i=0;i<8;i++)
 {
  eeprom = eeprom << 1;
   BitIn();
 }
return eeprom;
}
