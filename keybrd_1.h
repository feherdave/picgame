/* 
 * File:   keybrd.h
 * Author: feher
 *
 * Created on 2023. május 14., 7:25
 */

#ifndef KEYBRD_H
#define	KEYBRD_H

const char keys[] = {
    '1', '2', '3', 'A',
    '4', '5', '6', 'B',
    '7', '8', '9', 'C',
    '*', '0', '#', 'D'
};

#ifdef	__cplusplus
extern "C" {
#endif

    /**
     * Billentyűzet kiértékelése
     */
    char kbd_eval();


#ifdef	__cplusplus
}
#endif

#endif	/* KEYBRD_H */

