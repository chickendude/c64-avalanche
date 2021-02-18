draw_player:
	lda #<player_sprite
	sta $82
	lda #>player_sprite
	sta $83
	lda x_pos
	sta $86
	lda y_pos
	sta $87
	jmp draw_sprite	; [sprites.asm]
