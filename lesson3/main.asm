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

init:
    ; ld a, _ADD      ; load _ADD label into a (this is the command we want to execute)
    ld a, _SUB      ; load _SUB label into a (this is the command we want to execute)
    ld bc, $0307    ; load 3 into b and 7 into c

    cp 0            ; compare a to zero
    jr z, MathAdd   ; relative jump
    cp 1            ; compare a to one
    jr z, MathSub 

    ld a, 0

SaveResult:
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
