/* 
 * Library for interfacing PIC microcontrollers with HD44780 or compatible LCD
 * drivers using 4 bit communication.
 * 
 * Version: 1.0 
 *
 * Copyright (C) 2023 Dávid Fehér 
*
 *
 * Don't forget to adjust settings in 'Communication port definitions' and
 * 'LCD display resolution' sections to suit your needs.
 * 
 * WARNING
 * -------
 * 
 * By default this library is effectively using the 'busy flag', therefore:
 * 
 *  1.  R/W signal must be connected to uC.
 *  2.  Non-used data lines of the display driver (D0-D3) must not be connected
 *      to GND!!! They have to be grounded using a high value resistor to avoid
 *      overloading LCD driver outputs when setting it to read mode.
 * 
 * If busy flag check is not needed, then you can comment out the 'LCD_USE_BF'
 * macro. This will result in using a simple NOP in the 'LCD_wrdata' function
 * instead of the real busy flag check which also makes the definition of LCD_RW
 * useless so it can be commented out too. If using it this way then the waiting
 * time must be adjusted to work well with your display.
 * 
 * Notes
 * -----
 * 
 * This library doesn't contain all the functions of the LCD driver.
 * 8-bit communication and reading data from LCD is not implemented.
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

#ifndef LCD_HD44780_H
#define	LCD_HD44780_H

#include <stdint.h>
#include <stdbool.h>

/*
 * Communication port definitions.
 */
#define LCD_USE_BF
#define LCD_RS          PORTAbits.RA4
#define LCD_E           PORTAbits.RA6
#define LCD_RW          PORTAbits.RA7
#define LCD_DATA_PORT   PORTA
#define LCD_DATA_TRIS   TRISA

/*
 * LCD display resolution.
 */
#define LCD_COLS        16
#define LCD_ROWS        2

/*
 * HD44780 instruction bit patterns (RS = 0).
 */
#define LCD_RS0_CMD_CLEAR_DISPLAY   0b00000001      // Clear display
#define LCD_RS0_CMD_RETURN_HOME     0b00000010      // Cursor return home
#define LCD_RS0_CMD_ENTRY_MODE_SET  0b00000100      // Entry mode set
#define LCD_RS0_CMD_DISPLAY_CTRL    0b00001000      // Display control
#define LCD_RS0_CMD_CUR_DISP_SHIFT  0b00010000      // Cursor or display shift
#define LCD_RS0_CMD_FUNCTION_SET    0b00100000      // Function set
#define LCD_RS0_CMD_SET_CGRAM_ADDR  0b01000000      // Set CGRAM address
#define LCD_RS0_CMD_SET_DDRAM_ADDR  0b10000000      // Set DDRAM address

/*
 * 'Entry mode set' command bit patterns.
 *
 * These constants can be used on LCD.EntryMode struct member.
 */
#define LCD_ENTRY_MODE_INCR     0b00000010      // Increment
#define LCD_ENTRY_MODE_DECR     0b11111101      // Decrement
#define LCD_ENTRY_MODE_SHIFT    0b00000001      // Display shift
#define LCD_ENTRY_MODE_NO_SHIFT 0b11111110      // Cursor shift

/*
 * 'Function set' command bit patterns.
 * 
 * Placeholders are only given for completeness. Since their values are 0 it is
 * not advised to use them for calculating Function set command parameter.
 */ 
#define LCD_FUNCTION_SET_DL_8_BIT   0b00010000  // Data bus width: 8 bits
#define LCD_FUNCTION_SET_DL_4_BIT   0b00000000  // Data bus width: 4 bits (placeholder)
#define LCD_FUNCTION_SET_N_2_LINES  0b00001000  // Display: 2 lines
#define LCD_FUNCTION_SET_N_1_LINE   0b00000000  // Display: 1 line (placeholder)
#define LCD_FUNCTION_SET_F_5X10     0b00000100  // Character resolution: 5x10 pixels
#define LCD_FUNCTION_SET_F_5X8      0b00000000  // Character resolution: 5x8 pixels (placeholder)

/*
 * 'Display control' command bit patterns.
 * 
 * These constants can be used on LCD.DisplayControl struct member.
 * All 'ON' constants must be OR-ed with LCD.DisplayControl value and all 'OFF'
 * constants must be AND-ed with LCD.DisplayControl.
 */
#define LCD_DISPLAY_CTRL_D_ON   0b00000100      // Display ON
#define LCD_DISPLAY_CTRL_D_OFF  0b11111011      // Display OFF
#define LCD_DISPLAY_CTRL_C_ON   0b00000010      // Cursor ON
#define LCD_DISPLAY_CTRL_C_OFF  0b11111101      // Cursor OFF
#define LCD_DISPLAY_CTRL_B_ON   0b00000001      // Cursor blink ON
#define LCD_DISPLAY_CTRL_B_OFF  0b11111110      // Cursor blink OFF

/*
 * LCD command macros.
 */
#define LCDPutRS0Cmd(cmd)           LCD_RS = 0; LCD_wrdata((uint8_t) cmd);
#define LCDClearDisplay()           LCDPutRS0Cmd(LCD_RS0_CMD_CLEAR_DISPLAY); \
                                    __delay_ms(50);
#define LCDReturnHome()             LCDPutRS0Cmd(LCD_RS0_CMD_RETURN_HOME)
#define LCDEntryModeSet()           LCDPutRS0Cmd(LCD.EntryMode)
#define LCDDisplayControl()         LCDPutRS0Cmd(LCD.DisplayControl)
#define LCDFunctionSet(param)       LCDPutRS0Cmd(LCD_RS0_CMD_FUNCTION_SET | \
                                                (uint8_t) param)
#define LCDSetDDRAMAddress(addr)    LCDPutRS0Cmd(LCD_RS0_CMD_SET_DDRAM_ADDR | \
                                                (uint8_t) addr)

/**
 * Struct for storing actual Entry Mode and Display Control register values.
 */
struct {
    uint8_t EntryMode;
    uint8_t DisplayControl;
} LCD;

/**
 * Sends one byte of data to LCD.
 */
void LCD_wrdata(uint8_t data);

/**
 * Blocks while busy flag (BF) is active.
 */
#ifdef LCD_USE_BF
inline void LCD_waitbf(void);
#endif

/**
 * Sets CGRAM address.
 *
 * @param addr Address in Character Generator RAM.
 */
inline void LCD_set_cgram_addr(uint8_t addr);

/**
 * Sets cursor position.
 *
 * @param x Column.
 * @param y Row.
 */
void LCD_gotoxy(uint8_t x, uint8_t y);

/**
 * Sends a string to the LCD to be display starting from the current
 * cursor postion.
 *
 * @param str Pointer to the string (must end with \\0 !!!).
 */
void LCD_puts(const char* str);

/**
 * Writes one character at the current cursor location.
 * 
 * @param chr
 */
void LCD_putc(char chr);

/**
 * Sends pattern data of a custom character to be stored in CGRAM.
 * 
 * @param code Code of the character (0..7).
 * @param dataarr Pattern data (array of 8 bytes).
 */
void LCD_wr_custom_char(uint8_t, const char*);

/**
 * LCD initialisation (software reset).
 */
inline void LCD_init(void);

#endif	/* _LCD_HD44780_H */