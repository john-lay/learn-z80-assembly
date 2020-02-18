INCLUDE "../hardware.inc"

SECTION "Header", ROM0[$100] ; gameboy starts running at memory location 100

EntryPoint:
    nop
    jp begin

REPT $150 - $104
    db 0
ENDR

begin:
    nop 
    di              ; disable interrupts
    ld sp, $ffff

init:

SECTION "Game code", ROM0

; Lesson 1
;org &8000       ; compile code to memory location 8000 (in hex)
ld a, 4         ; load 4 into a
inc a           ; increment a by 1
inc a           ; a is now 6
ld b, 10        ; load 10 into b
add b           ; this adds b to a. Could be written as `add a, b` where a is the implicit destingation
ld [rBGP], a   ; load a into destination memory location E000 (in hex)
ret
