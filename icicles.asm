; draws the icicle array to the screen
draw_icicles:
	ldx #0
draw_icicles_loop:
	stx $89
	lda icicle_frame, x				; Check if frame is < 0
	 bmi .1							; Skip if < 0
		jsr draw_icicle				; If frame >= 0, we should erase it before drawing the next one
.1:
	ldx $89							; Save X since it gets overwritten in some subroutines
	ldy icicle_frame, x				; Put current frame number into Y
	iny								; Advance to next frame
	 bmi .2					; If frame is still < 0, don't
	cpy #16
	 bcc .2
		dey
		inc icicle_y, x
		lda #24
		cmp icicle_y, x
		 bcs .2
			lda $D14B
			ora #%11111100
			tay
.2:	sty icicle_frame, x
	lda icicle_frame, x
	 bmi draw_icicles_next			; If frame is < 0, it shouldn't be drawn yet
	 bne draw_icicles_skip_new		; If frame = 0, we need to set the starting coordinates
 		inc icicle_y, x
		lda $D41B					; "Random" number (see init in [main.asm])
		and #7						; 0 - 7
		sta $86
		lda $D41B
		and #31						; 0 - 31
		adc $86						; random number between 0 - 38
		sta icicle_x, x				; Update x value
		lda #0						;
		sta icicle_y, x				; Reset y to 0
draw_icicles_skip_new:
	jsr draw_icicle
draw_icicles_next:
	ldx $89
	inx
	inx
	inx
	cpx #30
	 bne draw_icicles_loop
	rts

; ###############################
; Draws an icicle us
;
; Inputs:
;	x	= icicle offset
; Destroys:
;	a, y
;	$81, $82, $83, $86, $87
draw_icicle:
	ldy icicle_x, x			; X coord
	sty $86					; Store x value for draw_sprite
	lda icicle_y, x			; Y coord
	sta $87					; Store y value for draw_sprite

; frame id
	lda icicle_frame, x		; Calculate the frame to use
	ror						; Frame / 2
	clc
	ror						; / 4
	and #3
	sta $81					; Save frame to $81

; Determine which frame to draw
	lda #<icicle_sprite1		; Load base sprite address into $82
	sta $82						;
	lda #>icicle_sprite1		;
	sta $83						;
	clc
draw_icicle_frame_loop:
	dec $81						; If $90 = 0, we've found the frame
	 bpl draw_icicle_continue	; Out of range, so have to do it this way
		jmp draw_sprite			; [sprites.asm] $86/$87 = x/y, $82 = sprite address
draw_icicle_continue:
	lda #8
	adc $82
	sta $82
	 bcc draw_icicle_frame_loop
	inc $83
	jmp draw_icicle_frame_loop


; Set all icicles to empty
clear_icicles:
	ldx #10			; 10 icicles
	ldy #0			; y = counter
clear_icicles_loop:
	lda $D41B
	ora #%11100000	; Make sure frame is negative
	sta icicle_frame, y
	iny
	iny
	iny
	dex
	 bne clear_icicles_loop
	rts
