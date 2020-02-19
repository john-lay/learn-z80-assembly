INCLUDE "../hardware.inc"

SECTION "header", ROM0[$100] ; gameboy starts running at memory location 100
    nop
    jp entryPoint

REPT $150 - $104
    db 0
ENDR

entryPoint:
    nop 
    di              ; disable interrupts
    ld sp, $ffff

; Lesson 1
init:
    ld a, 4         ; load 4 into a (a=4d, a=0x4)
    inc a           ; increment a by 1 (a=5d, a=0x5)
    inc a           ; increment a by 1 again (a=6d, a=0x6)
    ld b, 10        ; load 10 into b (b=10d, b=0xA)
    add b           ; this adds b to a. Could be written as `add a, b` where a is the implicit destination (a=16d, a=0x10)
    ld [$C000], a   ; load a into destination memory location C000 (in hex) which is working RAM
    
    ret
