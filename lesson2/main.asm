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

; Lesson 2
Init:
    ld a, $ff       ; load 255 into a
    ld bc, $A000-1  ; initialise bc with representation of last memory address of VRAM
    ld hl, $8000    ; initialise hl with representation of first memory address of VRAM
    ld [$8000], a   ; load a into first value of VRAM
    
FillAgain:
    inc hl          ; increment hl
    ld [hl], a      ; load a into memory location represented by hl

    ; perform a compare (cp) on 2 16-bit values http://z80-heaven.wikidot.com/optimization
    ; or a                ; clear carry flag
    ; sbc bc, hl          ; subtract hl from bc i.e. hl - bc
    ; add bc, hl          ; add hl to bc i.e. hl + bc
    ; jr nc, FillAgain    ; relative jump no-carry
    ret
