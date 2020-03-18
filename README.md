# Learn Z80 Assembly
Working through generic Z80 tutorial, but applying it to the Gameboy.

[Learn Multi platform Z80 Assembly Programming](https://www.youtube.com/playlist?list=PLp_QNRIYljFq-9nFiAUiAkRzAXfcZTBR_)

Screenshots taken of the lessons running in [BGB](http://bgb.bircd.org/)

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory for a given lesson and run the following commands (replacing lesson1 with the specific lesson):
* `rgbasm -o main.o main.asm`
* `rgblink -o lesson1.gb main.o`
* `rgbfix -v -p 0 lesson1.gb`

---

## Lesson 1 - Load (ld), Increment (inc), Add (add) and Return (ret)

Write to Working RAM and play with values in registries `a` and `b`.

![screenshot of lesson1](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson1/lesson1-screenshot.png)

## Lesson 2 - LDIR, Labels, Definitions, Conditions and Loops

The LDIR (Load, Increment, Repeat) instruction is missing from the Gameboy instruction set.
Play with  labels and a loop to fill VRAM.

![screenshot of lesson2](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson2/lesson2-screenshot.png)

## Lesson 3 - Case Statement, 8-bit arithmetic

Basic artithmetic calculations (addition and subtraction).
Uses labels, label values (EQU), relative jump (jr), compare (cp), compare to zero (z), no-carry (nc), addition (add) and subtraction (sub)
The DJNZ (Decrement, Jump if Not Zero) (only works in the `b` register) instruction is missing from the Gameboy instruction set.

![screenshot of lesson3](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson3/lesson3-screenshot.png)

## Lesson 4 - Stack, Strings, IFDEF, IX, IY, Call

Writing ASCII characters to memory and invoke sub-routines with call. Create constants with define byte (db)

![screenshot of lesson4](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson4/lesson4-screenshot.png)
