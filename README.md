# Learn Z80 Assembly
Working through generic Z80 tutorial, but applying it to the Gameboy.

[Learn Multi platform Z80 Assembly Programming](https://www.youtube.com/playlist?list=PLp_QNRIYljFq-9nFiAUiAkRzAXfcZTBR_)

# Lesson 1 - Load, increment, add and return

Write to specific location in memory and play with values in registries `a` and `b`.

# Build

## Prerequisites

Gameboy build pipeline, [RGBDS](https://github.com/rednex/rgbds/releases).

## Building the rom
Clone the repo and open a terminal in the source directory and run the following commands:
* `rgbasm -o main.o main.asm`
* `rgblink -o lesson1.gb main.o`
* `rgbfix -v -p 0 lesson1.gb`
