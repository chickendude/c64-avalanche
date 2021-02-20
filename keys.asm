; ###############################
; Checks the joystick for movement
;
; Inputs:
;	keys	= current joystick state
read_keys:
	ldx #0
	ror keys
	ror keys
check_left:
	ror keys
	 bcs check_right
	dec x_pos
	 bpl check_right
		stx x_pos
check_right:
	ror keys
	 bcs end_read_keys
	lda x_pos
	cmp #39
	 bcs end_read_keys
		inc x_pos
end_read_keys:
	rts

; ###############################
; Waits for a key to be pressed
;
; Inputs: None
; Outputs: None
wait_key:
	lda joystick
	ora #%11100000
	cmp #$FF
	 beq wait_key
	rts
