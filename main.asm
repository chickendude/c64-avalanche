	include "c64.inc"
reg1		equ $80
reg2		equ $81
reg3		equ $82
reg4		equ $83
reg5		equ $84
reg6		equ $85

x_pos		equ $90
y_pos		equ $91
keys		equ $92
key_timer	equ $93

icicles			equ $10 ; 3 bytes each: x, y, frame
icicle_frame	equ $10 ; 3 bytes each: x, y, frame
icicle_x		equ $11 ; 3 bytes each: x, y, frame
icicle_y		equ $12 ; 3 bytes each: x, y, frame


; Init/header
	org $0801

	db $0E, $08, $0A, $00, $9E, $20, $28, $32, $30, $36, $34, $29, $00, $00, $00

Start:
; Program start at $0810
	sei				; if we don't disable, interrupts can override our variables
	lda #%00111011	; turn on graphics mode
	sta VCTRL1

	lda #%11001000	; 2-color mode
	sta VCTRL2

	lda #%00011000	; set screen base to $2000 (color at $400)
	sta VBASE

; Prepare SID to use as random number generator, read from $D41B to get random number
	lda #$6F
	ldy #$81
	ldx #$FF
	sta $D413
	sty $D412
	stx $D40E			; Voice 3 frequency LSB
	stx $D40F			; Voice 3 frequency MSB
	stx $D414

; clear screen
	lda #>$2000			; MSB
	sta $81
	lda #<$2000			; LSB
	sta $80
	ldx #32
	jsr clear			; [sprites.asm] a = 0 from the LSB
	jsr clear_icicles	; [icicles.asm] Clear the icicles array

; clear color RAM
	lda #<$400
	sta $80
	lda #>$400
	sta $81
	ldx #4				; 4 * 256
	lda #$76
	jsr clear

	lda #30
	sta x_pos
	lda #24
	sta y_pos
	jsr draw_player

	jsr splash			; [splash.asm] Draw splash text
	jsr wait_key		; Wait for a key
	jsr splash			; [splash.asm] Clear splash text
main:
; Destination screen address
	jsr draw_icicles
	jsr delay
	lda joystick		; Joystick 1
	ora #%11100000
	cmp #$FF
	 beq main
	sta keys
	jsr draw_player		; [player.asm] Erase sprite
	jsr read_keys
	jsr draw_player
	jmp main

delay:
	ldx #20
	ldy #0
delay_loop:
	dey
	bne delay_loop
	dex
	bne delay_loop
	rts

; routines
	include "sprites.asm"
	include "icicles.asm"
	include "keys.asm"
	include "player.asm"
	include "splash.asm"
; data
	include "sprites.inc"
title_txt:
	db a_,v_,a_,l_,a_,n_,c_,h_,e_,0
