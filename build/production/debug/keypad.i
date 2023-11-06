
# 1 "keypad.c"

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

# 12 "keypad.h"
eeprom char eeprom_keys[] = "123A456B789C*0#D";

# 19
char keys[16];

# 28
char kbd_eval(uint8_t row, uint8_t col);

# 11 "keypad.c"
char kbd_eval(uint8_t row, uint8_t col) {

uint8_t key_ptr = 0x00;


if (row & 0x20) {
key_ptr = 4;
} else if (row & 0x40) {
key_ptr = 8;
} else if (row & 0x80) {
key_ptr = 12;
}



key_ptr |= col;

return keys[key_ptr];
}
