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
positionTilemeap:
    xor a           ; equivalent to ld a, 0
    ld hl, $ff42
    ldi [hl], a     ; 0xff42: SCY - Tile Scroll Y
    ld [hl], a      ; 0xff43: SCX - Tile Scroll X

    ld [NextCharX], a   ; Set cursor to pos 0,0
    ld [NextCharY], a

stopLcdWait:            ; Turn off the screen so we can define our patterns
    ld a, [$ff44]       ; Loop until we are in VBlank
    cp 145              ; Is display on scan line 145 yet?
    jr nz, stopLcdWait  ; no? keep waiting!

    ld hl, $ff40        ; LCDC - LCD Control (R/W)
    res 7,[hl]  ; Turn off the screen

defineBitmapFont:
    ld de, bitmapFont               ; Source bitmaps
    ld hl, $8000                    ; Dest in Vram
    ld bc, bitmapFontEnd-bitmapFont ; Bytes of font

copy2Bitloop:
    ld a, [de]      ; Read in a byte and INC HL
    inc de
    ldi [hl],a      ; Fill Bitplane 1
    ldi	[hl],a      ; Fill Bitplane 2
    dec bc
    ld a, b
    or c
    jr nz, copy2Bitloop

definePalette:
    ld a, %11100100     ; Black text on white bg. DDCCBBAA .... A=Background 0=Black, 3=White
    ; ld a, %00011011     ; White text on black bg. DDCCBBAA .... A=Background 0=Black, 3=White
    ld hl, $ff47
    ldi [hl], a         ; FF47  BGP BG & Window Palette Data    (R/W) = &FC
    ldi [hl], a         ; FF48  OBP0    Object Palette 0 Data   (R/W) = &FF
    cpl                 ; Set sprite Palette 2 to the opposite
    ldi [hl], a         ; FF49  OBP1    Object Palette 1 Data   (R/W) = &FF

turnOnScreen:
    ld hl, $ff40        ; LCDC - LCD Control (R/W)	EWwBbOoC 
    set 7, [hl]         ; Turn on the screen

main:
    ld hl, message      ; Address of string
    call printString    ; Show String to screen    
    di
    halt

printString:
    ld a, [hl]          ; Print a '255' terminated string 
    cp 255
    ret z
    inc hl
    call printChar
    jr printString

message: db "Hello, World!", 255

printChar:
    push hl
    push bc
        push af
            ld a, [NextCharY]
            ld b, a         ; YYYYYYYY --------
            ld hl, NextCharX
            ld a, [hl]
            ld c, a         ; -------- ---XXXXX
            inc [hl]
            cp 20-1
            call z, newLine
            xor a
            rr b            ; -YYYYYYY Y-------
            rra
            rr b            ; --YYYYYY YY------
            rra
            rr b            ; ---YYYYY YYY-----
            rra
            or c            ; ---YYYYY YYYXXXXX
            ld c, a
            ld	hl, $9800   ; Tilemap base
            add hl, bc
        pop af
        push af
            sub 32          ; no char <32!
            call lcdWait    ; Wait for VDP Sync
            ld [hl],a
        pop af
    pop bc
    pop hl

    ret

newLine:
    push hl
        ld hl, NextCharY    ; Inc Ypos
        inc [hl]
        ld hl, NextCharX
        ld [hl], 0          ; Reset Xpos
    pop hl

    ret

lcdWait:
    push af
    di

lcdWaitAgain:
        ld a, [$ff41]       ; STAT - LCD Status (R/W)
            ; -LOVHCMM
        and %00000010       ; MM=video mode (0/1 =Vram available)  		
        jr nz, lcdWaitAgain 
    pop af	
    
    ret

bitmapFont:
    incbin "Font96.FNT"	; Font bitmap,
bitmapFontEnd:          ; this is common to all systems
