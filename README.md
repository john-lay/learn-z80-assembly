# Learn Z80 Assembly
Working through generic Z80 tutorial, but applying it to the Gameboy.

[Learn Multi platform Z80 Assembly Programming](https://www.youtube.com/playlist?list=PLp_QNRIYljFq-9nFiAUiAkRzAXfcZTBR_)

Screenshots taken of the lessons running in [BGB](http://bgb.bircd.org/)

## Lesson Summary
* __Lesson 1__ Simple minimal example. Read and write to (working) memory
* __Lesson 2__ Keep track of pointer in memory and flood VRAM (video memory)
* __Lesson 3__ Addition, Subtraction, Multiplication and Division
* __Lesson 4__ Strings and Characters
* __Lesson 5__ Bit level operations
* __Lesson h9__ Hello World

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

The Load, Increment, Repeat (LDIR) instruction is missing from the Gameboy instruction set.
Play with  labels and a loop to fill VRAM.

![screenshot of lesson2](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson2/lesson2-screenshot.png)

## Lesson 3 - Case Statement, 8-bit arithmetic

Basic artithmetic calculations (addition and subtraction).
Uses labels, label values (EQU), relative jump (jr), compare (cp), compare to zero (z), no-carry (nc), addition (add) and subtraction (sub)
The DJNZ (Decrement, Jump if Not Zero) (only works in the `b` register) instruction is missing from the Gameboy instruction set.

![screenshot of lesson3](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson3/lesson3-screenshot.png)

## Lesson 4 - Stack, Strings, Call

* Writing ASCII characters to memory and invoke sub-routines with (call). 
* Create character and string constants with define byte (db).
* Manipulate the stack with (push) and (pop). 
* If def (IFDEF, ELSE and ENDIF) are compiler features that threw a `Macro 'someMacro' not defined` error with RGBDS.
* The indirect registers (IX, and IY) are  missing from the Gameboy.

![screenshot of lesson4](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson4/lesson4-screenshot.png)

## Lesson 5 - Bit level operations

Expand on the code used in lesson 2 to fill the video RAM and play with the following bit level instructions:

* Use bitwise operators: and (and), or (or) and exclusive OR (xor).
* Use set (set) and reset (res) commands to set single bit in a byte.
* Use bit (bit) operator to compare a single bit to 1.
* Bitwise operators only work on register a, whereas set, reset and bit work on all registers.
* Rotate bits with carry left (rl) and right (rr).
* Rotate bits with wrap left (rlc) and right (rrc).
* Shift bits right while maintaining top bit (sra) and left (sla).
* Shifts bits right while losing the top bit (srl) and left (swap). (sll) instruction is missing from the Gameboy instruction set.

![screenshot of lesson5](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson5/lesson5-screenshot.png)

## Lesson H9 - Hello, World!

Hello, World! example using external font, palettes and managed LCD lifecycle.

![screenshot of lessonh9](https://github.com/john-lay/learn-z80-assembly/raw/master/lessonh9/lessonh9-screenshot.png)
