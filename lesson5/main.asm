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

; Lesson 5
Init:
    ld a, $ff       ; load 255 into a
    ld bc, $9ff0    ; initialise bc with representation of last memory address of VRAM
    ld hl, $8000    ; initialise hl with representation of first memory address of VRAM
    ld [$8000], a   ; load a into first value of VRAM
    
FillAgain:
    ld a, $ff           ; reset a (as we load the values of h and l later for checking if we've finished filling)

    ;xor %10101010       ; exclusive OR operation on a
    ;and %11110000       ; and operation on a
    ;or %11110000        ; or operation on a
    ;set 0, a            ; set specific bit to 1. (and leave the rest as 0) Equivalent to (or %00000001)
    ; res 7, a            ; set specific bit to 0. (and leave the rest as 1) Equivalent to (and %01111111)
    ; bit 7, a            ; cp %10000000

    inc hl              ; increment hl
    ld [hl], a          ; load a into memory location represented by hl    
    ld a, h             ; load h into a
    cp $9f              ; compare a to last memory address of VRAM (0x9ff0) - first 8 bits 0x9f
    jp nz, FillAgain    ; if we're not at the end of our fill area, then fill again
    ld a, l             ; load l into a
    cp $f0              ; compare a to last memory address of VRAM (0x9ff0) - last 8 bits 0xf0
    jp nz, FillAgain    ; if we're not at the end of our fill area, then fill again
    
    call PlayWithVRAM

PlayWithVRAM:
    ld a, [hl]
    ; ------------------- Makes the emulator beep and slowly flicks through 3 colors: White, black and one grey.
    ; rr a                ; rotates bits in a right with carry (RRA is actually faster).
    ; ------------------- Makes the screen flick through 3 colors: White, black and one grey.
    ; rrc a               ; rotates bits in a with wrap (RRCA is actually faster).
    ; ------------------- Makes the emulator produce a scratching sound at regular intervals. Flicks to white, then stays black.
    ; sra a               ; shifts the bits in a right. top bit = previous top bit
    ; ------------------- Screen switches from black (from FillAgain) then to white.
    srl a               ; shifts the bits in a right, top bit 0
    ld [hl], a
    inc l
    jp nz, PlayWithVRAM
    inc h
    jp nz, PlayWithVRAM

    ret
