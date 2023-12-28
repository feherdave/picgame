/*
 * PICgame for PIC16F627
 * =====================
 * 
 * Copyright (C) 2023 Dávid Fehér
 * 
 * A small handheld game with 2 games using a 1602LCD and a 4x4 membrane
 * keypad.
 * 
 * Game A: Type'n'beep - a small typewriter
 * Game B: Trash truck ride - collect trash bins but watch out for obstacles!
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

// CONFIG
#pragma config FOSC = INTOSCIO  // Oscillator Selection bits (INTRC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RA5/MCLR pin function select (RA5/MCLR pin function is digital input, MCLR internally tied to VDD)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOD Reset enabled)
#pragma config LVP = OFF        // Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data Code Protection bit (Data memory code protection off)
#pragma config CP = OFF         // Code Protection bits (Program memory code protection off)

#include <xc.h>
#include <pic16f627.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#include "global_macros.h"

#include "lcd_macros.h"
#include "lcd_hd44780.h"

#include "keypad.h"

// Keypad macros
#define KP_COLSEL_OUT_PORT      PORTB
#define KP_ROWSEL_IN_PORT       PORTB
#define LCD_BACKLIGHT           PORTBbits.RB2

// Function macros
#define GetKey()        key = '\0'; while (!key) { }
#define BeepLow()       _beep(240, 120)
#define BeepHigh()      _beep(60, 30)
#define BeepMid()       _beep(120, 60)

// Game B macros
#define GameBMinSpeed           40
#define GameBMaxSpeed           20
#define GameBDefaultDifficulty  14

// Custom character set for truck game
eeprom char eeprom_cgram_data[6][8] = {
    { 0x07, 0x05, 0x0D, 0x09, 0x1B, 0x1F, 0x1D, 0x02 },     // 0: Trash truck back
    { 0x1F, 0x15, 0x0A, 0x15, 0x0A, 0x1F, 0x17, 0x08 },     // 1: Trash truck middle
    { 0x1C, 0x0A, 0x19, 0x0D, 0x1F, 0x1F, 0x1B, 0x04 },     // 2: Trash truck front
    { 0x00, 0x0E, 0x1B, 0x1F, 0x15, 0x15, 0x15, 0x1F },     // 3: Trash bin
    { 0x00, 0x04, 0x0A, 0x04, 0x1F, 0x04, 0x0A, 0x11 },     // 4: Human
    { 0x0A, 0x15, 0x0A, 0x15, 0x0A, 0x04, 0x04, 0x04 }      // 5: Tree
};

eeprom char tile_set[] = { ' ', 3, 4, 3, 5, 3, 4, 5 };      // Tile set for game B randomizer

char key = '\0';                // Actually pressed key
uint8_t beep_delay;             // Software timer for the beep function
                                // (decreased on every T0 interrupt)

char gameA_line_buf[LCD_COLS + 1];  // Line buffer for game A
uint8_t gameB_spd;              // Truck speed (rate of slowness) for game B
uint8_t gameB_spd_cnt;          // Truck game speed counter
uint8_t gameB_truckpos;         // y pos of truck (0 or 1)
uint8_t gameB_obstacle_delay;   // Used when obstacle was randomized
uint8_t gameB_track[LCD_ROWS][LCD_COLS + 1];
uint8_t gameB_difficulty;
bool flash_lcd;                 // LCD backlight flashing on
bool gameB_cnt_ena;             // Enable truck game speed counter

void _beep(uint8_t, uint8_t);
inline void init(void);
char rand_tile(void);
void clearstr(unsigned char*);

/**
 *  M A I N
 */
void main(void) {
    
    // Initialize device
    init();
    
    uint8_t i = LCD_COLS - 1;
    do {
        keys[i] = eeprom_keys[i];
        gameA_line_buf[i] = ' ';
    } while (i--);
    gameA_line_buf[LCD_COLS] = 0;
    
    // Initialize LCD
    LCD_init();
    
    // Send custom character data to LCD
    LCD_wr_custom_char(0, eeprom_cgram_data[0]);
    LCD_wr_custom_char(1, eeprom_cgram_data[1]);
    LCD_wr_custom_char(2, eeprom_cgram_data[2]);
    LCD_wr_custom_char(3, eeprom_cgram_data[3]);
    LCD_wr_custom_char(4, eeprom_cgram_data[4]);
    LCD_wr_custom_char(5, eeprom_cgram_data[5]);
    
    LCD.DisplayControl |= LCD_DISPLAY_CTRL_D_ON;
    LCDDisplayControl();
    
    // Enable interrupts (GIE & T0IE)
    INTCON = 0b10100000;
    
    // Main loop
    while(true) {

        // Display the game menu
        LCD_gotoxy(0, 0);
        LCD_puts("Select game!\0");
        LCD_gotoxy(0, 1);
        LCD_puts("A / B\0");

        readkey:

        GetKey();
        switch (key) {
            case 'A':
                // Game A
                // Put characters on the display.
                
                LCDClearDisplay();
                LCD.DisplayControl |= LCD_DISPLAY_CTRL_B_ON;
                LCDDisplayControl();

                uint8_t xpos = 0, ypos = 0;
               
                while(true) {
                    GetKey();
                    switch (key) {
                        case '*':
                            // Acts as 'back'
                            clearstr(gameA_line_buf);
                            
                            goto back_to_main;
                        case '#':
                            // Acts as 'enter'
                            xpos = 0;
                            if (!ypos) {
                                LCD_gotoxy(0, ++ypos);
                            } else {
                                LCDClearDisplay();

                                LCD_gotoxy(0, 0);
                                LCD_puts(gameA_line_buf);
                                LCD_gotoxy(0, 1);

                                clearstr(gameA_line_buf);
                            }
                            break;
                        default:
                            if (xpos < (LCD_COLS - 1)) {
                                LCD_putc(key);

                                if (ypos) {
                                    gameA_line_buf[xpos] = key;
                                }

                                xpos++;
                            }
                    }
                }
                break;
                // Game A

            case 'B':
                // Game B - Trash truck drive
                key = '\0';
                
                i = LCD_COLS - 1;
                do {
                    gameB_track[0][i] = ' ';
                    gameB_track[1][i] = ' ';
                } while (i--);

                gameB_track[0][LCD_COLS] = '\0';
                gameB_track[1][LCD_COLS] = '\0';

                gameB_spd = GameBMinSpeed;
                gameB_difficulty = GameBDefaultDifficulty;

                union {
                    struct {
                        unsigned trashbin: 1;
                        unsigned obstacle: 1;
                    };
                    uint8_t bval;
                } hits;

                gameB_cnt_ena = true;
                
                while (true) {

                    // Redraw the track
                    redraw:

                    // Check hits
                    hits.bval = 0;
                    i = 2;
                    do {
                        switch (gameB_track[gameB_truckpos][i]) {
                            case ' ':
                                break;
                            case 3:
                                hits.trashbin = 1;
                                break;
                            default:
                                hits.obstacle = true;
                        }
                        
                        gameB_track[gameB_truckpos][i] = ' ';
                    } while (i--);

                    if (hits.obstacle) {
                        // If obstacle was hit: pause scrolling for a while and
                        // flash LCD backlight
                        BeepLow();
                        flash_lcd = true;
                        gameB_cnt_ena = false;  // Avoid counting during pause
                        __delay_ms(800);
                        gameB_cnt_ena = true;
                        flash_lcd = false;
                        LCD_BACKLIGHT = true;                                
                        if (gameB_spd < GameBMinSpeed) gameB_spd++;
                    } else if (hits.trashbin) {
                        BeepHigh();
                        gameB_difficulty -= 2;
                        if (gameB_difficulty == 6) {
                            gameB_difficulty = GameBDefaultDifficulty;
                            if (gameB_spd > GameBMaxSpeed) gameB_spd--;
                        }
                    }
                    
                    // Draw the track
                    LCD_gotoxy(0, 0);
                    LCD_puts(gameB_track[0]);
                    LCD_gotoxy(0, 1);
                    LCD_puts(gameB_track[1]);

                    LCD_gotoxy(0, gameB_truckpos);
                    LCD_putc(0);
                    LCD_putc(1);
                    LCD_putc(2);
                    
                    do {
                        if (key) {
                            uint8_t _key = key;
                            key = '\0';

                            switch(_key) {
                                case '*':
                                    goto back_to_main;

                                case 'A':
                                    gameB_truckpos = 0;
                                    goto redraw;

                                case 'B':
                                    gameB_truckpos = 1;
                                    goto redraw;
                            }
                        }
                    } while (gameB_spd_cnt);

                    gameB_spd_cnt = gameB_spd;
                    
                    // Scroll track to the left
                    for (i = 0; i < 15; i++) {
                        gameB_track[0][i] = gameB_track[0][i + 1];
                        gameB_track[1][i] = gameB_track[1][i + 1];
                    }

                    // Put new random tile to end of the track
                    gameB_track[0][15] = rand_tile();
                    gameB_track[1][15] = rand_tile();
                }
                
                break;
                // Game B
                
            default:
                goto readkey;
        }
        
        back_to_main:
        
        LCD.DisplayControl &= LCD_DISPLAY_CTRL_C_OFF & LCD_DISPLAY_CTRL_B_OFF;
        LCDDisplayControl();

        LCDClearDisplay();
    }
}

/**
 * Interrupt service routine.
 */
void __interrupt() isr() {
    
    static char prev_key = '\0';           // Previously pressed key
    static uint8_t key_col_select;         // Keyboard column selector
    static uint8_t kbd_skip_t0_cyc = 0;    // TO cycle skip counter after keypress
   
    // Timer0 interrupt:
    //  - keyboard evaluation & column scan stepping
    //  - beep timing
    //  - truck game speed counter
    //  - LCD backlight flashing
    if (T0IF) {
        T0IF = 0;
        
        // Read the keyboard
        uint8_t _row = KP_ROWSEL_IN_PORT;

        // Evaluate the keyboard if active row reading value is not zero and
        // key buffer is empty
        if (kbd_skip_t0_cyc) {
            kbd_skip_t0_cyc--;
        }
        
        if (_row & 0xf0 && !key) {
            uint8_t _col = key_col_select & 0x03;
            uint8_t _key;
        
            _key = kbd_eval(_row, _col);
                    
            // Disallow the first key repetition
            if (_key != prev_key || !kbd_skip_t0_cyc) {
                kbd_skip_t0_cyc = 12;
                key = _key;
                prev_key = _key;
                BeepMid();
            }
        }        
        
        // Select the next column on the keyboard
        key_col_select++;
        KP_COLSEL_OUT_PORT = (KP_COLSEL_OUT_PORT & 0xFC) | (key_col_select & 0x03);
        
        // In case of beeping...
        if (CCPR1L) {
            // Decrease beep timer (a.k.a wait)
            if (beep_delay) {
                beep_delay--;
            } else {
                // Stop beeping
                CCPR1L = 0;
            }
        }
        
        // Game B speed counter
        if (gameB_spd_cnt && gameB_cnt_ena) {
            gameB_spd_cnt--;
        }
        
        if (flash_lcd) {
            LCD_BACKLIGHT = TMR2 & 0x01;
        }
    }
}

/**
 * Starts a beep with the given PWM parameters.
 * 
 * @param PR2_val Value of PR2 register.
 * @param CCPR1L_val Value of CCPR1L register.
 */
void _beep(uint8_t PR2_val, uint8_t CCPR1L_val) {

    // If beeping then quit
    if (CCPR1L) return;
    
    // Start beeping (for 6 T0 cycles)
    beep_delay = 6;
    PR2 = PR2_val;
    CCPR1L = CCPR1L_val;
}

/**
 * Returns a pseudo randomized tile using TMR0 & TMR2 taking into account the
 * actual difficulty.
 * 
 * @return char Randomized tile.
 */
char rand_tile() {
    
    static uint8_t psrand_seed;
	uint8_t res = (TMR0 ^ TMR2 + psrand_seed) & 0x07;

	psrand_seed = res;

    if (gameB_obstacle_delay) {
        gameB_obstacle_delay--;
        return ' ';
    }
    
    if (res > 1) {
        gameB_obstacle_delay = gameB_difficulty;
    }
    
	return tile_set[res];
}

/**
 * Clears a string (puts space) until \\0 is reached.
 * 
 * @param str String to be cleared.
 */
void clearstr(unsigned char *str) {
    while (*str) {
        *str = ' ';
        str++;
    }
}

/**
 * Power on init.
 */
inline void init(void) {
    
    // Select oscillator freq. (4 MHz)
    PCONbits.OSCF = 1;
    
    // Disable comparators
    CMCON = 7;
    
    // Initialize PORTA
    TRISA = 0x0c;
    
    // Initialize PORTB
    // RB<7:4> input, RB<3:0> output
    TRISB = 0xf0;
    
    // Disable pull-ups on PORTB
    // Use T0 for the keyboard scan column select shift (1:64 pre-scaler => 16,32 ms / overflow)
    OPTION_REG = 0x85;
    
    // Setup PWM:
    // ~520Hz, duty cycle 50% --> CCPR1L MSB<10:2> will be 240 >> 2 = 60 when beep needed
    // T2
    CCPR1L = 0;
    CCP1CON = 0x0C;     // CCP1 -> PWM mode
    T2CON = 0x07;       // TMR2 on, pre-scale = 1:16
    
    // Switch on LCD backlight
    LCD_BACKLIGHT = true;
}