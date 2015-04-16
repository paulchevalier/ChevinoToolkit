/*
 * This is the helper.h file of a basic programming environnement for chevinos
 * Copyright 2014-2015 Paul Chevalier
 * Some code have been copied from the arduino Arduino.h file with copyright to Arduino Team 2005-2013 
 * which was distributed under LGPL v2.1
 * For more information see the source at http://www.arduino.cc
 * 
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 2 of the License, or any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef HELPER_H
#define HELPER_H

#include <stdint.h>
#include <stdbool.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdio.h>
#include <stdarg.h>
//#include <compat/deprecated.h> //for function sbi cbi (to be changed soon)

#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif

#define clockCyclesPerMicrosecond() ( F_CPU / 1000000L )
#define clockCyclesToMicroseconds(a) ( (a) / clockCyclesPerMicrosecond() )
#define microsecondsToClockCycles(a) ( (a) * clockCyclesPerMicrosecond() )


#ifdef __cplusplus
  extern "C" {
#endif

void init(void);
uint32_t millis(void);
uint32_t micros(void);
void delayMicroseconds(uint16_t us);
void delay(uint32_t ms);

#ifdef __cplusplus
  } //extern "C"
#endif

#endif //HELPER_H
