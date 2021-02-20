; ###############################
; Draws an 8x8 sprite aligned to a grid
;
; Inputs:
;	$82	= address of sprite
;	$86 = x coord
;	$87	= y coord
; Destroys:
;	a, x, y
;	$80, $81, $84
draw_sprite:
	jsr get_coords	; Get starting VRAM coordinates into $80
	ldy #0
draw_sprite_row:
	lda ($82), y	; load (address + y) from ($82) into a, $82 holds sprite address
	eor ($80), y
	sta ($80), y
	iny
	cpy #8
	bne draw_sprite_row
	rts

; ###############################
; Puts the starting address in VRAM into $80
;
; Inputs: --
; Outputs:
;	$80 = Sprite coordinates (Y * 40 + X * 8 + 	$2000)
; Destroys:
;	a, x
;	$81, $84
get_coords:
	lda #0
	sta $84			; temp variable
	sta $81			;
; x
	lda $86			; x * 8
	asl				; srl a, don't put carry into bit 0
	rol	$81			; ROtateLeft, carry goes into bit 1
	asl				; x4
	rol $81
	asl				; x8
	rol $81
	sta $80			; $80 = x_pos * 8, $80 $81 act like a 16-bit register
; y: 25*8 rows = 200 rows of 320 pixels
	lda $87			; y * 8, won't overflow so no need for 16-bit variable
	asl
	asl
	asl
; now need y*40
	asl
	rol $84			; y * 2
	asl
	rol $84			; y * 4
	asl
	rol $84			; y * 8
	tax
		adc $80		; add y * 8 now, later we'll add y * 32 to get y * 40
		sta $80		; add to the x value
		lda $84
		adc $81
		sta $81
	txa
	asl				; y * 16
	rol $84
	asl				; y * 32
	rol $84

	adc $80			; add y * 32
	sta $80
	lda $84
	adc $81
	adc #$20
	sta $81			; MSB
	rts

; ###############################
; Clears "x" bytes at address stored in $80
; Inputs:
;	a	= byte to store at address
;	x	= number of bytes * 256 to clear
;	$80	= address to clear
clear:
	ldy #0
clear_loop:
	sta ($80), y
	dey
	bne clear_loop
	inc $81
	dex
	bne clear_loop
	rts
