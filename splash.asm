; ###############################
; Show the splash screen and main menu
;
; Inputs: --
; Outputs: --
; Destroys:
;	a, x, y
;	$40, $80, $81, $84, $86, $87
splash:
	lda #<title_txt
	sta $40
	lda #>title_txt
	sta $41

	lda #15					; starting x coordinate
	sta $86

	lda #11					; y coordinate
	sta $87
	ldy #0
splash_char:
	lda ($40), y			; "letter"
	 beq .quit				; [keys.asm]
	asl						; x2 Each letter is 8 bytes
	asl						; x4
	asl						; x8
	adc #<(a_sprite - 8)	; LSB: Add letter offset to sprite address
							; First letter's id = 1, not 0, hence the - 8
	sta $82					; Save LSB
	lda #0					; Reset A since we just want to inc the MSB by one if there is a carry
	adc #>(a_sprite - 8)	; MSB + carry into A
	sta $83					; Save MSB
	sty $88					; Save Y
		jsr draw_sprite		; [sprites.asm]
	ldy $88					; Restore Y
	iny						; Load next letter in string
	inc $86					; Move to next X position
	jmp splash_char			; Loop
.quit:
	rts
