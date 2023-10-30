/* 
 * File:   keybrd.c
 * Author: feherdave
 *
 * Definition of keypad evaluation related functions.
 */

#include <stdint.h>
#include "keypad.h"

char kbd_eval(uint8_t row, uint8_t col) {
    // Code line inputs: decade -> BIN into key_ptr<3:2>
    uint8_t key_ptr = 0x00;

    // High nibble is used for row selection input
    if (row & 0x20) {
        key_ptr = 4; 
    } else if (row & 0x40) {
        key_ptr = 8; 
    } else if (row & 0x80) {
        key_ptr = 12; 
    }

    // Copy current column selection to key_ptr<1:0>
    // Active HIGH!
    key_ptr |= col;

    return keys[key_ptr];
}