#
# This is the Makefile of a basic programming environnement for chevinos
# Copyright 2014-2015 Paul Chevalier
#
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 2 of the License, or any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
#

 
MICROC = atmega328
F_CPU = 20000000
FORMAT = ihex


SRC = main.c helper.c
#pas de sources cpp mais pourquoi pas !
CXXSRC =
TARGET = main


CFLAGS = -DF_CPU=$(F_CPU) -Os  -Wall -Wstrict-prototypes -std=gnu99 -fdata-sections -ffunction-sections 
CXXFLAGS = -DF_CPU=$(F_CPU) -Os  -Wall -Wstrict-prototypes
LDFLAGS = 


# Programmation avec avrdude
AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
AVRDUDE_FLAGS = -F -p $(MICROC) -P /dev/ttyUSB0 -c arduino \
  -b 115200

# Programmes
CC = avr-gcc
CXX = avr-g++
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE = avr-size
AVRDUDE = avrdude
REMOVE = rm -f

# Define all object files.
OBJ = $(SRC:.c=.o) $(CXXSRC:.cpp=.o)

# Trucs par défaut
ALL_CFLAGS = -mmcu=$(MICROC) -I. $(CFLAGS)
ALL_CXXFLAGS = -mmcu=$(MICROC) -I. $(CXXFLAGS)


# Cible par défaut.
all: build
build: elf hex eep
elf: $(TARGET).elf
hex: $(TARGET).hex
eep: $(TARGET).eep

# flash le programme  
upload: $(TARGET).hex $(TARGET).eep
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

.SUFFIXES: .elf .hex .eep

#séparation du programme et de l'eeprom

.elf.hex:
	$(OBJCOPY) -O $(FORMAT) -R .eeprom $< $@

.elf.eep:
	-$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom="alloc,load" \
	--change-section-lma .eeprom=0 -O $(FORMAT) $< $@



# Link des fichiers objets en un elf
$(TARGET).elf: $(OBJ)
	$(CC) $(ALL_CFLAGS) -Wl,--gc-sections $(OBJ) --output $@ $(LDFLAGS)

# Compilation des objets cpp
.cpp.o:
	$(CXX) -c $(ALL_CXXFLAGS) $< -o $@ 

# et des objets c
.c.o:
	$(CC) -c $(ALL_CFLAGS) $< -o $@ 

#nettoyage
clean:
	$(REMOVE) $(TARGET).hex $(TARGET).eep $(TARGET).elf \
	$(TARGET).map $(TARGET).sym $(TARGET).lss \
	$(OBJ) $(LST) $(SRC:.c) $(SRC:.c) $(CXXSRC:.cpp) $(CXXSRC:.cpp)

showsize:
	$(SIZE) -C --mcu=$(MICROC) $(TARGET).elf

.PHONY:	all build elf hex eep clean upload
