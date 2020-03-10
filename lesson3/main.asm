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
_DIV EQU 3

init:
    ; ld a, _ADD      ; load _ADD label into a (this is the command we want to execute)
    ; ld a, _SUB      ; load _SUB label into a (this is the command we want to execute)
    ; ld a, _MUL      ; load _MUL label into a (this is the command we want to execute)
    ld a, _DIV      ; load _DIV label into a (this is the command we want to execute)
    ld bc, $030c    ; load 3 into b and 12 into c

    cp 0            ; compare a to zero
    jr z, MathAdd   ; relative jump
    cp 1            ; compare a to one
    jr z, MathSub    
    cp 2            ; compare a to two
    jr z, MathMul
    cp 3            ; compare a to three
    jr z, MathDiv

    ld a, 0

SaveResult:
    ld [_RAM], a    ; Save the result to working ram C000 (in hex)
    
    ret

LoadAndSaveResult:
    ld a, d        ; read result from d
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

MathMul:            ; Example b=3, c=7
    ld a, c         ; load c into a (a=7, b=3, c=7, d=0)

    add c           ; add c and a   (a=14, b=3, c=7, d=0)
    ld d, a         ; load a into d (a=14, b=3, c=7, d=14)
    ld a, b         ; load b into a (a=14, b=3, c=7, d=14)
    dec a           ; decrement a   (a=2, b=3, c=7, d=14)
    cp 1            ; compare a to 1
    jr z, LoadAndSaveResult    ; save result if a=1
    jr nz, MathMulAgain

MathMulAgain:
    ld b, a         ; load a into b (a=2, b=2, c=7, d=14)
    ld a, d         ; load d into a (a=14, b=2, c=7, d=14)

    add c           ; add c and a   (a=21, b=2, c=7, d=14)
    ld d, a         ; load a into d (a=21, b=2, c=7, d=21)
    ld a, b         ; load b into a (a=2, b=2, c=7, d=21)
    dec a           ; decrement a   (a=1, b=2, c=7, d=21)
    cp 1            ; compare a to 1
    jr z, LoadAndSaveResult
    jr nz, MathMulAgain

MathDiv:            ; Example b=3, c=12
    ld a, c         ; (a=12, b=3, c=12, d=0)
    cp 0
    jr z, SaveResult
    ld d, 0
MathDivAgain:
    sub b           ; (a=9, b=3, c=12, d=0)
    inc d           ; (a=9, b=3, c=12, d=1)
    jr nc, MathDivAgain
    dec d
    ld a, d
    jr SaveResult
