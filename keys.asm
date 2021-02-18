; ###############################
; Checks the joystick for movement
;
; Inputs:
;	keys	= current joystick state
read_keys:
	ldx #0
check_up:
	ror keys
	 bcs check_down	; if carry is set (bit = 1), that means key wasn't pressed
	dec y_pos
	 bpl check_down
		stx y_pos
check_down:
	ror keys
	 bcs check_left
	inc y_pos
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
