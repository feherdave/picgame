# Welcome to feherdave's PICgame project!

![picgame_truck](https://github.com/feherdave/picgame/assets/82935051/b30e8df0-eb9c-4b6e-8ed0-8804f1eeb4ba)

## About

This is a small handheld game project using a PIC16F627, a 1602 LCD, and a 4x4 membrane keypad. It's a creative blend of my electronics and programming hobbies, inspired by my two little boys. The project features two games that can be selected from a menu:

- **Game A - Type'n'beep:** Though not exactly a conventional game, it becomes one if you view it from a 2-year-old's perspective. You can type using the keypad, and it beeps with every keypress. A linefeed function is also implemented.

- **Game B - Trash Truck Drive:** In this game, you drive a trash truck, emptying trash bins along the street. Be cautious of obstacles!

## How to Build?

### Software

The project is developed using MPLAB X IDE v6.05 and Microchip XC8 v2.41 C compiler (free version), both of which can be downloaded for free. If you already have them, just clone the repository and open it in MPLAB X IDE. The MPLAB X project includes two configurations:

- **Simulation:** Use this for debugging in the simulator.
- **Production:** Employ this for compiling and downloading to the real device. PICkit 3 is selected as the hardware tool in this configuration (since I used that one for programming), but you can modify it according to your requirements.

### Hardware

Schematics can be found here: [Project Schematics](https://oshwlab.com/feherdave/picgame). Currently, I haven't designed a PCB for the project due to its simplicity. It can easily be built on an experimental PCB.

## How does it work?

For in-depth insights into how each hardware and software component works, please refer to the [wiki pages](https://github.com/feherdave/picgame/wiki)!
