/*
 * This is the main.c file of a basic programming environnement for chevinos
 * Copyright 2014-2015 Paul Chevalier

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

#include <stdlib.h>
#include <string.h>
#include <avr/pgmspace.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "helper.h"

void setup(void) {
  DDRB = DDRB | 0x10; //pin5 port b en sortie;
}

void loop(void) {
  PORTB = PORTB | 0x10;
  delay(1000);
  PORTB = PORTB & ~0x10;
  delay(1000);
}

int main(void)
{
	init();
	
	setup();
    
	for (;;) {
		loop();
	}
        
	return 0;
}

