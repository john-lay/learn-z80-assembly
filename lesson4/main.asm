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
    ld a, $61       ; load 'a' into a (a=97d, a=0x61)
    call printChar
    ld [temp], a    ; load a into temp (temp='0x61')
    ld a, $7c       ; load '|' into a (a=124d, a=0x7c)
    call printChar
    ld [temp2], a   ; load a into temp2 (temp2='0x7c')
    ld a, $78       ; load 'x' into a (a=120d, a=0x78)
    call printChar
    ld a, [temp2]   ; load temp2 into a (a='0x7c')
    call printChar
    ld a, [temp]    ; load temp into a (a='0x61')
    call printChar

    ret

temp: db 0
temp2: db 0

initSave:
    ld hl, _RAM     ; initialise hl with memory location of _RAM (0xc000)

    ret

printChar:
    ld [hl], a      ; save result to RAM
    inc hl          ; set hl to next available memory location (ready for next save)

    ret
