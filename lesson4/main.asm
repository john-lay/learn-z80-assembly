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

    ld de, thoughtMsg
    call printString
    ld de, awesomeMsg
    call printString
    
    ret

charA: db $61       ; define byte (db) with value 'a' (charA=97d, charA=0x61)
charX: db $78       ; define byte (db) with value 'x' (charX=120d, charX=0x78)
charBar: db $7c     ; define byte (db) with value '|' (charBar=124d, charBar=0x7c)
thoughtMsg: db "Thought of the day...", 255     ; string ends with 255
awesomeMsg: db "Z80 is Awesome!", 255           ; use 255 as terminating string

initSave:
    ld hl, _RAM     ; initialise hl with memory location of _RAM (0xc000)

    ret

printChar:
    ld [hl], a      ; save result to RAM
    inc hl          ; set hl to next available memory location (ready for next save)

    ret

printString:
    ld a, [de]
    ld [hli], a ; Place it at the destination, incrementing hl
    inc de      ; move to the next character to print by incrementing de
    cp 255      ; check if we're at the end of the string
    ret z
    jp printString
