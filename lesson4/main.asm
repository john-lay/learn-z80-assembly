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

; Lesson 4
init:
    call initSave   ; initialise hl to store pointer to RAM
    ld a, [charA]   ; load 'a' into a (a=97d, a=0x61)
    call printChar
    push af
        ld a, [charBar] ; load '|' into a (a=124d, a=0x7c)
        call printChar
        push af
            ld a, [charX]   ; load 'x' into a (a=120d, a=0x78)
            call printChar
        pop af
        ; ld a, [charBar] ; load '|' into a (a=124d, a=0x7c)
        call printChar
    pop af
    ; ld a, [charA]   ; load 'a' into a (a=97d, a=0x61)
    call printChar

    ret

charA: db $61       ; define byte (db) with value 'a' (charA=97d, charA=0x61)
charX: db $78       ; define byte (db) with value 'x' (charX=120d, charX=0x78)
charBar: db $7c     ; define byte (db) with value '|' (charBar=124d, charBar=0x7c)

initSave:
    ld hl, _RAM     ; initialise hl with memory location of _RAM (0xc000)

    ret

printChar:
    ld [hl], a      ; save result to RAM
    inc hl          ; set hl to next available memory location (ready for next save)

    ret
