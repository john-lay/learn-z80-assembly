# Learn Z80 Assembly
Working through generic Z80 tutorial, but applying it to the Gameboy.

[Learn Multi platform Z80 Assembly Programming](https://www.youtube.com/playlist?list=PLp_QNRIYljFq-9nFiAUiAkRzAXfcZTBR_)

Screenshots taken of the lessons running in [BGB](http://bgb.bircd.org/)

## Lesson 1 - Load (ld), Increment (inc), Add (add) and Return (ret)

Write to Working RAM and play with values in registries `a` and `b`.

![screenshot of lesson1](https://github.com/john-lay/learn-z80-assembly/raw/master/lesson1/lesson1-screenshot.png)

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory for a given lesson and run the following commands (replacing lesson1 with the specific lesson):
* `rgbasm -o main.o main.asm`
* `rgblink -o lesson1.gb main.o`
* `rgbfix -v -p 0 lesson1.gb`
