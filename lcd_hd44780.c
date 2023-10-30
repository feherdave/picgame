/*
 * Library for interfacing PIC microcontrollers with HD44780 or compatible LCD
 * drivers using 4 bit communication.
 * 
 * Version: 1.0 
 *
 * Copyright (C) 2023 Dávid Fehér 
 * 
 * ===========================================================================
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 * 
 */

#include <xc.h>
#include <stdbool.h>
#include <stdint.h>

#include "global_macros.h"

#include "lcd_hd44780.h"

void LCD_wrdata(uint8_t data) {
    LCD_DATA_TRIS &= 0xF0;                  // Lower 4 bits output

    // Send high nibble first
    LCD_E = 1;
    NOP();
    LCD_DATA_PORT = (LCD_DATA_PORT & 0xF0) | data >> 4;
    NOP();
    LCD_E = 0;

    NOP();

    // Send low nibble second
    LCD_E = 1;
    NOP();
    LCD_DATA_PORT = (LCD_DATA_PORT & 0xF0) | (data & 0x0f);
    NOP();
    LCD_E = 0;

    // Check BF
#ifdef LCD_USE_BF    
    LCD_waitbf();
#else
    NOP();
#endif
}

#ifdef LCD_USE_BF
inline void LCD_waitbf() {

    bool busy;

    LCD_RS = 0;
    LCD_RW = 1;
    
    LCD_DATA_TRIS |= 0x0f;      // Lower 4 bits input
   
    do {
        LCD_E = 1;
        NOP();

        busy = LCD_DATA_PORT & 0x08;
        
        LCD_E = 0;
        NOP();

        LCD_E = 1;
        NOP();
        LCD_E = 0;
        NOP();
    } while (busy);
    
    LCD_RW = 0;
}
#endif

inline void LCD_set_cgram_addr(uint8_t addr) {
    LCDPutRS0Cmd(LCD_RS0_CMD_SET_CGRAM_ADDR | addr);
}

void LCD_gotoxy(uint8_t x, uint8_t y) {
    LCDSetDDRAMAddress(y * 0x40 + x);
}

void LCD_puts(const char* str) {
    while (*str) {
        LCD_putc(*str++);
    }
}

void LCD_putc(char chr) {
    LCD_RS = 1;
    LCD_wrdata(chr);
}

void LCD_wr_custom_char(uint8_t code, const char* dataarr) {
    LCD_set_cgram_addr(code << 3);

    uint8_t cnt = 7;
    do {
        LCD_putc(*dataarr++);
    } while (cnt--);
}

inline void LCD_init() {

    LCD.DisplayControl = LCD_RS0_CMD_DISPLAY_CTRL;

    LCD_DATA_TRIS &= 0xF0;
    LCD_RS = 0;

    uint8_t i = 3;
    do {
        __delay_ms(50);

        LCD_E = 1;
        LCD_DATA_PORT = (LCD_DATA_PORT & 0xf0) | 0x03;
        NOP();
        NOP();
        LCD_E = 0;
    } while (i--);

    NOP();
    NOP();

    // Set 4-bit comms -> send an 'empty' function set
    LCD_E = 1;
    LCD_DATA_PORT = (LCD_DATA_PORT & 0xf0) | 0x02;
    NOP();
    NOP();
    LCD_E = 0;

#ifdef LCD_USE_BF
    LCD_waitbf();
#endif

#if LCD_ROWS == 2
    LCDFunctionSet(LCD_FUNCTION_SET_N_2_LINES | LCD_FUNCTION_SET_F_5X8);
#else
    LCDFunctionSet(LCD_FUNCTION_SET_F_5X8);
#endif
    LCDDisplayControl();    // Empty display control byte -> display off
    LCDClearDisplay();

    LCD.EntryMode = LCD_RS0_CMD_ENTRY_MODE_SET | LCD_ENTRY_MODE_INCR;
    LCDEntryModeSet();
}