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

; Lesson 3
_ADD EQU 0
_SUB EQU 1
_MUL EQU 2

init:
    ; ld a, _ADD      ; load _ADD label into a (this is the command we want to execute)
    ; ld a, _SUB      ; load _SUB label into a (this is the command we want to execute)
    ld a, _MUL      ; load _MUL label into a (this is the command we want to execute)
    ld bc, $0307    ; load 3 into b and 7 into c

    cp 0            ; compare a to zero
    jr z, MathAdd   ; relative jump
    cp 1            ; compare a to one
    jr z, MathSub    
    cp 2            ; compare a to two
    jr z, MathMul

    ld a, 0

SaveResult:
    ld [_RAM], a    ; Save the result to working ram C000 (in hex)
    
    ret

LoadAndSaveResult:
    ld a, c         ; read result from c
    ld [_RAM], a    ; Save the result to working ram C000 (in hex)
    
    ret

MathSub:
    ld a, c         ; load c into a
    sub b           ; subtract b from a
    jr SaveResult   ; save the result

MathAdd:
    ld a, c         ; load c into a
    add b           ; add b to a
    jr SaveResult   ; save the result

MathMul:            ; Example b=3, c=4
    ld a, c         ; load c into a (a=4, b=3, c=4, d=0)
    add b           ; add b and a   (a=7, b=3, c=4, d=0)
    ld c, a         ; load a into c (a=7, b=3, c=7, d=0)
    ld a, b         ; load b into a (a=3, b=3, c=7, d=0)
    dec a           ; decrement a   (a=2, b=3, c=7, d=0)
    cp 0            ; compare a to 0
    jr z, LoadAndSaveResult    ; save result if a=0
    jr nz, MathMulAgain

MathMulAgain:
    ld d, a         ; load a into d (a=2, b=3, c=7, d=2)
    ld a, c         ; load c into a (a=7, b=3, c=7, d=2)
    add b           ; add b and a   (a=10, b=3, c=7, d=2)

    ld c, a         ; load a into c (a=10, b=3, c=10, d=2)
    ld a, d         ; load d into a (a=2, b=3, c=10, d=2)
    dec a           ; decrement a   (a=1, b=3, c=10, d=2)
    cp 0            ; compare a to 0
    jr z, LoadAndSaveResult
    jr nz, MathMulAgain
