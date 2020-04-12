INCLUDE "../hardware.inc"

NextCharX equ $c000
NextCharY equ $c001

SECTION "header", ROM0[$100] ; gameboy starts running at memory location 100
    nop
    jp entryPoint

REPT $150 - $104
    db 0
ENDR

entryPoint:
    nop 
    di              ; disable interrupts
    ld sp, $ffff    ; set the stack pointer to highest mem location + 1

; Lesson h9
init:
    xor a           ; equivalent to ld a, 0
    ld hl, $ff42
    ldi [hl], a     ; 0xff42: SCY - Tile Scroll Y
    ld [hl], a      ; 0xff43: SCX - Tile Scroll X

    ld [NextCharX], a   ; Set cursor to pos 0,0
    ld [NextCharY], a
    
    ret
