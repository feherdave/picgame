
# 1 "main.c"


# 31
#pragma config FOSC = INTOSCIO
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config MCLRE = OFF
#pragma config BOREN = ON
#pragma config LVP = OFF
#pragma config CPD = OFF
#pragma config CP = OFF

# 18 "C:/Users/feher/.mchp_packs/Microchip/PIC16Fxxx_DFP/1.4.149/xc8\pic\include\xc.h"
extern const char __xc8_OPTIM_SPEED;

extern double __fpnormalize(double);


# 13 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\xc8debug.h"
#pragma intrinsic(__builtin_software_breakpoint)
extern void __builtin_software_breakpoint(void);

# 13 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\stdint.h"
typedef signed char int8_t;

# 20
typedef signed int int16_t;

# 28
typedef __int24 int24_t;

# 36
typedef signed long int int32_t;

# 52
typedef unsigned char uint8_t;

# 58
typedef unsigned int uint16_t;

# 65
typedef __uint24 uint24_t;

# 72
typedef unsigned long int uint32_t;

# 88
typedef signed char int_least8_t;

# 96
typedef signed int int_least16_t;

# 109
typedef __int24 int_least24_t;

# 118
typedef signed long int int_least32_t;

# 136
typedef unsigned char uint_least8_t;

# 143
typedef unsigned int uint_least16_t;

# 154
typedef __uint24 uint_least24_t;

# 162
typedef unsigned long int uint_least32_t;

# 181
typedef signed char int_fast8_t;

# 188
typedef signed int int_fast16_t;

# 200
typedef __int24 int_fast24_t;

# 208
typedef signed long int int_fast32_t;

# 224
typedef unsigned char uint_fast8_t;

# 230
typedef unsigned int uint_fast16_t;

# 240
typedef __uint24 uint_fast24_t;

# 247
typedef unsigned long int uint_fast32_t;

# 268
typedef int32_t intmax_t;

# 282
typedef uint32_t uintmax_t;

# 289
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;


# 7 "C:/Users/feher/.mchp_packs/Microchip/PIC16Fxxx_DFP/1.4.149/xc8\pic\include\builtins.h"
#pragma intrinsic(__nop)
extern void __nop(void);


#pragma intrinsic(_delay)
extern __nonreentrant void _delay(uint32_t);
#pragma intrinsic(_delaywdt)
extern __nonreentrant void _delaywdt(uint32_t);

# 52 "C:/Users/feher/.mchp_packs/Microchip/PIC16Fxxx_DFP/1.4.149/xc8\pic\include\proc\pic16f627.h"
extern volatile unsigned char INDF __at(0x000);

asm("INDF equ 00h");




extern volatile unsigned char TMR0 __at(0x001);

asm("TMR0 equ 01h");




extern volatile unsigned char PCL __at(0x002);

asm("PCL equ 02h");




extern volatile unsigned char STATUS __at(0x003);

asm("STATUS equ 03h");


typedef union {
struct {
unsigned C :1;
unsigned DC :1;
unsigned Z :1;
unsigned nPD :1;
unsigned nTO :1;
unsigned RP :2;
unsigned IRP :1;
};
struct {
unsigned :5;
unsigned RP0 :1;
unsigned RP1 :1;
};
struct {
unsigned CARRY :1;
unsigned :1;
unsigned ZERO :1;
};
} STATUSbits_t;
extern volatile STATUSbits_t STATUSbits __at(0x003);

# 159
extern volatile unsigned char FSR __at(0x004);

asm("FSR equ 04h");




extern volatile unsigned char PORTA __at(0x005);

asm("PORTA equ 05h");


typedef union {
struct {
unsigned RA0 :1;
unsigned RA1 :1;
unsigned RA2 :1;
unsigned RA3 :1;
unsigned RA4 :1;
unsigned RA5 :1;
unsigned RA6 :1;
unsigned RA7 :1;
};
} PORTAbits_t;
extern volatile PORTAbits_t PORTAbits __at(0x005);

# 228
extern volatile unsigned char PORTB __at(0x006);

asm("PORTB equ 06h");


typedef union {
struct {
unsigned RB0 :1;
unsigned RB1 :1;
unsigned RB2 :1;
unsigned RB3 :1;
unsigned RB4 :1;
unsigned RB5 :1;
unsigned RB6 :1;
unsigned RB7 :1;
};
} PORTBbits_t;
extern volatile PORTBbits_t PORTBbits __at(0x006);

# 290
extern volatile unsigned char PCLATH __at(0x00A);

asm("PCLATH equ 0Ah");


typedef union {
struct {
unsigned PCLATH :5;
};
} PCLATHbits_t;
extern volatile PCLATHbits_t PCLATHbits __at(0x00A);

# 310
extern volatile unsigned char INTCON __at(0x00B);

asm("INTCON equ 0Bh");


typedef union {
struct {
unsigned RBIF :1;
unsigned INTF :1;
unsigned T0IF :1;
unsigned RBIE :1;
unsigned INTE :1;
unsigned T0IE :1;
unsigned PEIE :1;
unsigned GIE :1;
};
struct {
unsigned :2;
unsigned TMR0IF :1;
unsigned :2;
unsigned TMR0IE :1;
};
} INTCONbits_t;
extern volatile INTCONbits_t INTCONbits __at(0x00B);

# 388
extern volatile unsigned char PIR1 __at(0x00C);

asm("PIR1 equ 0Ch");


typedef union {
struct {
unsigned TMR1IF :1;
unsigned TMR2IF :1;
unsigned CCP1IF :1;
unsigned :1;
unsigned TXIF :1;
unsigned RCIF :1;
unsigned CMIF :1;
unsigned EEIF :1;
};
} PIR1bits_t;
extern volatile PIR1bits_t PIR1bits __at(0x00C);

# 445
extern volatile unsigned short TMR1 __at(0x00E);

asm("TMR1 equ 0Eh");




extern volatile unsigned char TMR1L __at(0x00E);

asm("TMR1L equ 0Eh");




extern volatile unsigned char TMR1H __at(0x00F);

asm("TMR1H equ 0Fh");




extern volatile unsigned char T1CON __at(0x010);

asm("T1CON equ 010h");


typedef union {
struct {
unsigned TMR1ON :1;
unsigned TMR1CS :1;
unsigned nT1SYNC :1;
unsigned T1OSCEN :1;
unsigned T1CKPS :2;
};
struct {
unsigned :4;
unsigned T1CKPS0 :1;
unsigned T1CKPS1 :1;
};
} T1CONbits_t;
extern volatile T1CONbits_t T1CONbits __at(0x010);

# 525
extern volatile unsigned char TMR2 __at(0x011);

asm("TMR2 equ 011h");




extern volatile unsigned char T2CON __at(0x012);

asm("T2CON equ 012h");


typedef union {
struct {
unsigned T2CKPS :2;
unsigned TMR2ON :1;
unsigned TOUTPS :4;
};
struct {
unsigned T2CKPS0 :1;
unsigned T2CKPS1 :1;
unsigned :1;
unsigned TOUTPS0 :1;
unsigned TOUTPS1 :1;
unsigned TOUTPS2 :1;
unsigned TOUTPS3 :1;
};
} T2CONbits_t;
extern volatile T2CONbits_t T2CONbits __at(0x012);

# 603
extern volatile unsigned short CCPR1 __at(0x015);

asm("CCPR1 equ 015h");




extern volatile unsigned char CCPR1L __at(0x015);

asm("CCPR1L equ 015h");




extern volatile unsigned char CCPR1H __at(0x016);

asm("CCPR1H equ 016h");




extern volatile unsigned char CCP1CON __at(0x017);

asm("CCP1CON equ 017h");


typedef union {
struct {
unsigned CCP1M :4;
unsigned CCP1Y :1;
unsigned CCP1X :1;
};
struct {
unsigned CCP1M0 :1;
unsigned CCP1M1 :1;
unsigned CCP1M2 :1;
unsigned CCP1M3 :1;
};
} CCP1CONbits_t;
extern volatile CCP1CONbits_t CCP1CONbits __at(0x017);

# 682
extern volatile unsigned char RCSTA __at(0x018);

asm("RCSTA equ 018h");


typedef union {
struct {
unsigned RX9D :1;
unsigned OERR :1;
unsigned FERR :1;
unsigned ADEN :1;
unsigned CREN :1;
unsigned SREN :1;
unsigned RX9 :1;
unsigned SPEN :1;
};
struct {
unsigned :3;
unsigned ADDEN :1;
};
} RCSTAbits_t;
extern volatile RCSTAbits_t RCSTAbits __at(0x018);

# 753
extern volatile unsigned char TXREG __at(0x019);

asm("TXREG equ 019h");




extern volatile unsigned char RCREG __at(0x01A);

asm("RCREG equ 01Ah");




extern volatile unsigned char CMCON __at(0x01F);

asm("CMCON equ 01Fh");


typedef union {
struct {
unsigned CM :3;
unsigned CIS :1;
unsigned C1INV :1;
unsigned C2INV :1;
unsigned C1OUT :1;
unsigned C2OUT :1;
};
struct {
unsigned CM0 :1;
unsigned CM1 :1;
unsigned CM2 :1;
};
} CMCONbits_t;
extern volatile CMCONbits_t CMCONbits __at(0x01F);

# 837
extern volatile unsigned char OPTION_REG __at(0x081);

asm("OPTION_REG equ 081h");


typedef union {
struct {
unsigned PS :3;
unsigned PSA :1;
unsigned T0SE :1;
unsigned T0CS :1;
unsigned INTEDG :1;
unsigned nRBPU :1;
};
struct {
unsigned PS0 :1;
unsigned PS1 :1;
unsigned PS2 :1;
};
} OPTION_REGbits_t;
extern volatile OPTION_REGbits_t OPTION_REGbits __at(0x081);

# 907
extern volatile unsigned char TRISA __at(0x085);

asm("TRISA equ 085h");


typedef union {
struct {
unsigned TRISA0 :1;
unsigned TRISA1 :1;
unsigned TRISA2 :1;
unsigned TRISA3 :1;
unsigned TRISA4 :1;
unsigned TRISA5 :1;
unsigned TRISA6 :1;
unsigned TRISA7 :1;
};
} TRISAbits_t;
extern volatile TRISAbits_t TRISAbits __at(0x085);

# 969
extern volatile unsigned char TRISB __at(0x086);

asm("TRISB equ 086h");


typedef union {
struct {
unsigned TRISB0 :1;
unsigned TRISB1 :1;
unsigned TRISB2 :1;
unsigned TRISB3 :1;
unsigned TRISB4 :1;
unsigned TRISB5 :1;
unsigned TRISB6 :1;
unsigned TRISB7 :1;
};
} TRISBbits_t;
extern volatile TRISBbits_t TRISBbits __at(0x086);

# 1031
extern volatile unsigned char PIE1 __at(0x08C);

asm("PIE1 equ 08Ch");


typedef union {
struct {
unsigned TMR1IE :1;
unsigned TMR2IE :1;
unsigned CCP1IE :1;
unsigned :1;
unsigned TXIE :1;
unsigned RCIE :1;
unsigned CMIE :1;
unsigned EEIE :1;
};
} PIE1bits_t;
extern volatile PIE1bits_t PIE1bits __at(0x08C);

# 1088
extern volatile unsigned char PCON __at(0x08E);

asm("PCON equ 08Eh");


typedef union {
struct {
unsigned nBOR :1;
unsigned nPOR :1;
unsigned :1;
unsigned OSCF :1;
};
struct {
unsigned nBO :1;
};
struct {
unsigned nBOD :1;
};
} PCONbits_t;
extern volatile PCONbits_t PCONbits __at(0x08E);

# 1137
extern volatile unsigned char PR2 __at(0x092);

asm("PR2 equ 092h");




extern volatile unsigned char TXSTA __at(0x098);

asm("TXSTA equ 098h");


typedef union {
struct {
unsigned TX9D :1;
unsigned TRMT :1;
unsigned BRGH :1;
unsigned :1;
unsigned SYNC :1;
unsigned TXEN :1;
unsigned TX9 :1;
unsigned CSRC :1;
};
} TXSTAbits_t;
extern volatile TXSTAbits_t TXSTAbits __at(0x098);

# 1201
extern volatile unsigned char SPBRG __at(0x099);

asm("SPBRG equ 099h");




extern volatile unsigned char EEDATA __at(0x09A);

asm("EEDATA equ 09Ah");




extern volatile unsigned char EEADR __at(0x09B);

asm("EEADR equ 09Bh");




extern volatile unsigned char EECON1 __at(0x09C);

asm("EECON1 equ 09Ch");


typedef union {
struct {
unsigned RD :1;
unsigned WR :1;
unsigned WREN :1;
unsigned WRERR :1;
};
} EECON1bits_t;
extern volatile EECON1bits_t EECON1bits __at(0x09C);

# 1260
extern volatile unsigned char EECON2 __at(0x09D);

asm("EECON2 equ 09Dh");




extern volatile unsigned char VRCON __at(0x09F);

asm("VRCON equ 09Fh");


typedef union {
struct {
unsigned VR :4;
unsigned :1;
unsigned VRR :1;
unsigned VROE :1;
unsigned VREN :1;
};
struct {
unsigned VR0 :1;
unsigned VR1 :1;
unsigned VR2 :1;
unsigned VR3 :1;
};
} VRCONbits_t;
extern volatile VRCONbits_t VRCONbits __at(0x09F);

# 1342
extern volatile __bit ADDEN __at(0xC3);


extern volatile __bit ADEN __at(0xC3);


extern volatile __bit BRGH __at(0x4C2);


extern volatile __bit C1INV __at(0xFC);


extern volatile __bit C1OUT __at(0xFE);


extern volatile __bit C2INV __at(0xFD);


extern volatile __bit C2OUT __at(0xFF);


extern volatile __bit CARRY __at(0x18);


extern volatile __bit CCP1IE __at(0x462);


extern volatile __bit CCP1IF __at(0x62);


extern volatile __bit CCP1M0 __at(0xB8);


extern volatile __bit CCP1M1 __at(0xB9);


extern volatile __bit CCP1M2 __at(0xBA);


extern volatile __bit CCP1M3 __at(0xBB);


extern volatile __bit CCP1X __at(0xBD);


extern volatile __bit CCP1Y __at(0xBC);


extern volatile __bit CIS __at(0xFB);


extern volatile __bit CM0 __at(0xF8);


extern volatile __bit CM1 __at(0xF9);


extern volatile __bit CM2 __at(0xFA);


extern volatile __bit CMIE __at(0x466);


extern volatile __bit CMIF __at(0x66);


extern volatile __bit CREN __at(0xC4);


extern volatile __bit CSRC __at(0x4C7);


extern volatile __bit DC __at(0x19);


extern volatile __bit EEIE __at(0x467);


extern volatile __bit EEIF __at(0x67);


extern volatile __bit FERR __at(0xC2);


extern volatile __bit GIE __at(0x5F);


extern volatile __bit INTE __at(0x5C);


extern volatile __bit INTEDG __at(0x40E);


extern volatile __bit INTF __at(0x59);


extern volatile __bit IRP __at(0x1F);


extern volatile __bit OERR __at(0xC1);


extern volatile __bit OSCF __at(0x473);


extern volatile __bit PEIE __at(0x5E);


extern volatile __bit PS0 __at(0x408);


extern volatile __bit PS1 __at(0x409);


extern volatile __bit PS2 __at(0x40A);


extern volatile __bit PSA __at(0x40B);


extern volatile __bit RA0 __at(0x28);


extern volatile __bit RA1 __at(0x29);


extern volatile __bit RA2 __at(0x2A);


extern volatile __bit RA3 __at(0x2B);


extern volatile __bit RA4 __at(0x2C);


extern volatile __bit RA5 __at(0x2D);


extern volatile __bit RA6 __at(0x2E);


extern volatile __bit RA7 __at(0x2F);


extern volatile __bit RB0 __at(0x30);


extern volatile __bit RB1 __at(0x31);


extern volatile __bit RB2 __at(0x32);


extern volatile __bit RB3 __at(0x33);


extern volatile __bit RB4 __at(0x34);


extern volatile __bit RB5 __at(0x35);


extern volatile __bit RB6 __at(0x36);


extern volatile __bit RB7 __at(0x37);


extern volatile __bit RBIE __at(0x5B);


extern volatile __bit RBIF __at(0x58);


extern volatile __bit RCIE __at(0x465);


extern volatile __bit RCIF __at(0x65);


extern volatile __bit RD __at(0x4E0);


extern volatile __bit RP0 __at(0x1D);


extern volatile __bit RP1 __at(0x1E);


extern volatile __bit RX9 __at(0xC6);


extern volatile __bit RX9D __at(0xC0);


extern volatile __bit SPEN __at(0xC7);


extern volatile __bit SREN __at(0xC5);


extern volatile __bit SYNC __at(0x4C4);


extern volatile __bit T0CS __at(0x40D);


extern volatile __bit T0IE __at(0x5D);


extern volatile __bit T0IF __at(0x5A);


extern volatile __bit T0SE __at(0x40C);


extern volatile __bit T1CKPS0 __at(0x84);


extern volatile __bit T1CKPS1 __at(0x85);


extern volatile __bit T1OSCEN __at(0x83);


extern volatile __bit T2CKPS0 __at(0x90);


extern volatile __bit T2CKPS1 __at(0x91);


extern volatile __bit TMR0IE __at(0x5D);


extern volatile __bit TMR0IF __at(0x5A);


extern volatile __bit TMR1CS __at(0x81);


extern volatile __bit TMR1IE __at(0x460);


extern volatile __bit TMR1IF __at(0x60);


extern volatile __bit TMR1ON __at(0x80);


extern volatile __bit TMR2IE __at(0x461);


extern volatile __bit TMR2IF __at(0x61);


extern volatile __bit TMR2ON __at(0x92);


extern volatile __bit TOUTPS0 __at(0x93);


extern volatile __bit TOUTPS1 __at(0x94);


extern volatile __bit TOUTPS2 __at(0x95);


extern volatile __bit TOUTPS3 __at(0x96);


extern volatile __bit TRISA0 __at(0x428);


extern volatile __bit TRISA1 __at(0x429);


extern volatile __bit TRISA2 __at(0x42A);


extern volatile __bit TRISA3 __at(0x42B);


extern volatile __bit TRISA4 __at(0x42C);


extern volatile __bit TRISA5 __at(0x42D);


extern volatile __bit TRISA6 __at(0x42E);


extern volatile __bit TRISA7 __at(0x42F);


extern volatile __bit TRISB0 __at(0x430);


extern volatile __bit TRISB1 __at(0x431);


extern volatile __bit TRISB2 __at(0x432);


extern volatile __bit TRISB3 __at(0x433);


extern volatile __bit TRISB4 __at(0x434);


extern volatile __bit TRISB5 __at(0x435);


extern volatile __bit TRISB6 __at(0x436);


extern volatile __bit TRISB7 __at(0x437);


extern volatile __bit TRMT __at(0x4C1);


extern volatile __bit TX9 __at(0x4C6);


extern volatile __bit TX9D __at(0x4C0);


extern volatile __bit TXEN __at(0x4C5);


extern volatile __bit TXIE __at(0x464);


extern volatile __bit TXIF __at(0x64);


extern volatile __bit VR0 __at(0x4F8);


extern volatile __bit VR1 __at(0x4F9);


extern volatile __bit VR2 __at(0x4FA);


extern volatile __bit VR3 __at(0x4FB);


extern volatile __bit VREN __at(0x4FF);


extern volatile __bit VROE __at(0x4FE);


extern volatile __bit VRR __at(0x4FD);


extern volatile __bit WR __at(0x4E1);


extern volatile __bit WREN __at(0x4E2);


extern volatile __bit WRERR __at(0x4E3);


extern volatile __bit ZERO __at(0x1A);


extern volatile __bit nBO __at(0x470);


extern volatile __bit nBOD __at(0x470);


extern volatile __bit nBOR __at(0x470);


extern volatile __bit nPD __at(0x1B);


extern volatile __bit nPOR __at(0x471);


extern volatile __bit nRBPU __at(0x40F);


extern volatile __bit nT1SYNC __at(0x82);


extern volatile __bit nTO __at(0x1C);

# 76 "C:/Users/feher/.mchp_packs/Microchip/PIC16Fxxx_DFP/1.4.149/xc8\pic\include\pic.h"
__attribute__((__unsupported__("The " "FLASH_READ" " macro function is no longer supported. Please use the MPLAB X MCC."))) unsigned char __flash_read(unsigned short addr);

__attribute__((__unsupported__("The " "FLASH_WRITE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_write(unsigned short addr, unsigned short data);

__attribute__((__unsupported__("The " "FLASH_ERASE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_erase(unsigned short addr);

# 114 "C:\Program Files\Microchip\xc8\v2.41\pic\include\eeprom_routines.h"
extern void eeprom_write(unsigned char addr, unsigned char value);
extern unsigned char eeprom_read(unsigned char addr);

# 118 "C:/Users/feher/.mchp_packs/Microchip/PIC16Fxxx_DFP/1.4.149/xc8\pic\include\pic.h"
extern __bank0 unsigned char __resetbits;
extern __bank0 __bit __powerdown;
extern __bank0 __bit __timeout;

# 15 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\stdbool.h"
typedef unsigned char bool;

# 4 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\__size_t.h"
typedef unsigned size_t;

# 7 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\stdlib.h"
typedef unsigned short wchar_t;

# 15
typedef struct {
int rem;
int quot;
} div_t;
typedef struct {
unsigned rem;
unsigned quot;
} udiv_t;
typedef struct {
long quot;
long rem;
} ldiv_t;
typedef struct {
unsigned long quot;
unsigned long rem;
} uldiv_t;

# 65
extern double atof(const char *);
extern double strtod(const char *, const char **);
extern int atoi(const char *);
extern unsigned xtoi(const char *);
extern long atol(const char *);

# 73
extern long strtol(const char *, char **, int);

extern int rand(void);
extern void srand(unsigned int);
extern void * calloc(size_t, size_t);
extern div_t div(int numer, int denom);
extern udiv_t udiv(unsigned numer, unsigned denom);
extern ldiv_t ldiv(long numer, long denom);
extern uldiv_t uldiv(unsigned long numer,unsigned long denom);

# 85
extern unsigned long _lrotl(unsigned long value, unsigned int shift);
extern unsigned long _lrotr(unsigned long value, unsigned int shift);
extern unsigned int _rotl(unsigned int value, unsigned int shift);
extern unsigned int _rotr(unsigned int value, unsigned int shift);




extern void * malloc(size_t);
extern void free(void *);
extern void * realloc(void *, size_t);

# 104
extern int atexit(void (*)(void));
extern char * getenv(const char *);
extern char ** environ;
extern int system(char *);
extern void qsort(void *, size_t, size_t, int (*)(const void *, const void *));
extern void * bsearch(const void *, void *, size_t, size_t, int(*)(const void *, const void *));
extern int abs(int);
extern long labs(long);

extern char * itoa(char * buf, int val, int base);
extern char * utoa(char * buf, unsigned val, int base);




extern char * ltoa(char * buf, long val, int base);
extern char * ultoa(char * buf, unsigned long val, int base);

extern char * ftoa(float f, int * status);

# 15 "C:\Program Files\Microchip\xc8\v2.41\pic\include\c90\stdbool.h"
typedef unsigned char bool;

# 140 "lcd_hd44780.h"
struct {
uint8_t EntryMode;
uint8_t DisplayControl;
} LCD;

# 148
void LCD_wrdata(uint8_t data);

# 154
inline void LCD_waitbf(void);

# 162
inline void LCD_set_cgram_addr(uint8_t addr);

# 170
void LCD_gotoxy(uint8_t x, uint8_t y);

# 178
void LCD_puts(const char* str);

# 185
void LCD_putc(char chr);

# 193
void LCD_wr_custom_char(uint8_t, const char*);

# 198
inline void LCD_init(void);

# 12 "keypad.h"
eeprom char eeprom_keys[] = "123A456B789C*0#D";

# 19
char keys[16];

# 28
char kbd_eval(uint8_t row, uint8_t col);

# 70 "main.c"
eeprom char eeprom_cgram_data[6][8] = {
{ 0x07, 0x05, 0x0D, 0x09, 0x1B, 0x1F, 0x1D, 0x02 },
{ 0x1F, 0x15, 0x0A, 0x15, 0x0A, 0x1F, 0x17, 0x08 },
{ 0x1C, 0x0A, 0x19, 0x0D, 0x1F, 0x1F, 0x1B, 0x04 },
{ 0x00, 0x0E, 0x1B, 0x1F, 0x15, 0x15, 0x15, 0x1F },
{ 0x00, 0x04, 0x0A, 0x04, 0x1F, 0x04, 0x0A, 0x11 },
{ 0x0A, 0x15, 0x0A, 0x15, 0x0A, 0x04, 0x04, 0x04 }
};

eeprom char tile_set[] = { ' ', 3, 4, 3, 5, 3, 4, 5 };

char key = '\0';
uint8_t beep_delay;


char gameA_line_buf[16 + 1];
uint8_t gameB_spd;
uint8_t gameB_spd_cnt;
uint8_t gameB_truckpos;
uint8_t gameB_obstacle_delay;
uint8_t gameB_track[2][16 + 1];
uint8_t gameB_difficulty;
bool flash_lcd;
bool gameB_cnt_ena;

void _beep(uint8_t, uint8_t);
inline void init(void);
char rand_tile(void);
void clearstr(unsigned char*);

# 103
void main(void) {


init();

uint8_t i = 16 - 1;
do {
keys[i] = eeprom_keys[i];
gameA_line_buf[i] = ' ';
} while (i--);
gameA_line_buf[16] = 0;


LCD_init();


LCD_wr_custom_char(0, eeprom_cgram_data[0]);
LCD_wr_custom_char(1, eeprom_cgram_data[1]);
LCD_wr_custom_char(2, eeprom_cgram_data[2]);
LCD_wr_custom_char(3, eeprom_cgram_data[3]);
LCD_wr_custom_char(4, eeprom_cgram_data[4]);
LCD_wr_custom_char(5, eeprom_cgram_data[5]);

LCD.DisplayControl |= 0b00000100;
PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) LCD.DisplayControl);;


INTCON = 0b10100000;


while(1) {


LCD_gotoxy(0, 0);
LCD_puts("Select game!\0");
LCD_gotoxy(0, 1);
LCD_puts("A / B\0");

readkey:

key = '\0'; while (!key) { };
switch (key) {
case 'A':



PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) 0b00000001);; _delay((unsigned long)((50)*(4000000/4000.0)));;
LCD.DisplayControl |= 0b00000001;
PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) LCD.DisplayControl);;

uint8_t xpos = 0, ypos = 0;

while(1) {
key = '\0'; while (!key) { };
switch (key) {
case '*':

goto back_to_main;
case '#':

xpos = 0;
if (!ypos) {
LCD_gotoxy(0, ++ypos);
} else {
PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) 0b00000001);; _delay((unsigned long)((50)*(4000000/4000.0)));;

LCD_gotoxy(0, 0);
LCD_puts(gameA_line_buf);
LCD_gotoxy(0, 1);

clearstr(gameA_line_buf);
}
break;
default:
if (xpos < (16 - 1)) {
LCD_putc(key);

if (ypos) {
gameA_line_buf[xpos] = key;
}

xpos++;
}
}
}
break;


case 'B':

key = '\0';

i = 16 - 1;
do {
gameB_track[0][i] = ' ';
gameB_track[1][i] = ' ';
} while (i--);

gameB_track[0][16] = '\0';
gameB_track[1][16] = '\0';

gameB_spd = 40;
gameB_difficulty = 14;

union {
struct {
unsigned trashbin: 1;
unsigned obstacle: 1;
};
uint8_t bval;
} hits;

gameB_cnt_ena = 1;

while (1) {


redraw:


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
hits.obstacle = 1;
}

gameB_track[gameB_truckpos][i] = ' ';
} while (i--);

if (hits.obstacle) {


_beep(240, 120);
flash_lcd = 1;
gameB_cnt_ena = 0;
_delay((unsigned long)((800)*(4000000/4000.0)));
gameB_cnt_ena = 1;
flash_lcd = 0;
PORTBbits.RB2 = 1;
if (gameB_spd < 40) gameB_spd++;
} else if (hits.trashbin) {
_beep(60, 30);
gameB_difficulty -= 2;
if (gameB_difficulty == 6) {
gameB_difficulty = 14;
if (gameB_spd > 20) gameB_spd--;
}
}


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


for (i = 0; i < 15; i++) {
gameB_track[0][i] = gameB_track[0][i + 1];
gameB_track[1][i] = gameB_track[1][i + 1];
}


gameB_track[0][15] = rand_tile();
gameB_track[1][15] = rand_tile();
}

break;


default:
goto readkey;
}

back_to_main:

LCD.DisplayControl &= 0b11111101 & 0b11111110;
PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) LCD.DisplayControl);;

PORTAbits.RA4 = 0; LCD_wrdata((uint8_t) 0b00000001);; _delay((unsigned long)((50)*(4000000/4000.0)));;
}
}

# 322
void __interrupt() isr() {

static char prev_key = '\0';
static uint8_t key_col_select;
static uint8_t kbd_skip_t0_cyc = 0;

# 333
if (T0IF) {
T0IF = 0;


uint8_t _row = PORTB;



if (kbd_skip_t0_cyc) {
kbd_skip_t0_cyc--;
}

if (_row & 0xf0 && !key) {
uint8_t _col = key_col_select & 0x03;
uint8_t _key;

_key = kbd_eval(_row, _col);


if (_key != prev_key || !kbd_skip_t0_cyc) {
kbd_skip_t0_cyc = 12;
key = _key;
prev_key = _key;
_beep(120, 60);
}
}


key_col_select++;
PORTB = (PORTB & 0xFC) | (key_col_select & 0x03);


if (CCPR1L) {

if (beep_delay) {
beep_delay--;
} else {

CCPR1L = 0;
}
}


if (gameB_spd_cnt && gameB_cnt_ena) {
gameB_spd_cnt--;
}

if (flash_lcd) {
PORTBbits.RB2 = TMR2 & 0x01;
}
}
}

# 392
void _beep(uint8_t PR2_val, uint8_t CCPR1L_val) {


if (CCPR1L) return;


beep_delay = 6;
PR2 = PR2_val;
CCPR1L = CCPR1L_val;
}

# 409
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

# 433
void clearstr(unsigned char *str) {
while (*str) {
*str = ' ';
str++;
}
}

# 443
inline void init(void) {


PCONbits.OSCF = 1;


CMCON = 7;


TRISA = 0x0c;



TRISB = 0xf0;



OPTION_REG = 0x85;




CCPR1L = 0;
CCP1CON = 0x0C;
T2CON = 0x07;


PORTBbits.RB2 = 1;
}
