#ifndef __I2C_H
#define __I2C_H

#include <dos.h>
#include <stdio.h>
#include <bios.h>
#include <time.h>

const
        PORTOUT = 0x278,
        PORTIN = 0x279;

#ifdef __cpluslus
 estern "C" {
#endif

void CalculateDelay();
void PortOut(unsigned int port,unsigned char value);
void BStart();
void BStop();
void BitOut();
void BitIn();
void TX(unsigned char n);
unsigned char RX();

#endif
