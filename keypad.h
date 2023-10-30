/* 
 * Keypad evaluation related functions and constants.
 */

#ifndef KEYPAD_H
#define	KEYPAD_H

/** 
 * Set of characters present on the keypad
 * (stored in EEPROM to preserve code space)
 */
eeprom char eeprom_keys[] = "123A456B789C*0#D";

/**
 * 'Runtime' storage of keypad characters.
 * Data must be copied here from EEPROM during init because keypad evaluation
 * is done in ISR and there we cannot use EEPROM data.
 */
char keys[16];

/**
 * Get character code of key being pressed.
 * 
 * @param row Currently selected row (decade) by logic.
 * @param col Currently selected column by user.
 * @return char ASCII character of the key depressed.
 */
char kbd_eval(uint8_t row, uint8_t col);

#endif	/* KEYBRD_H */

