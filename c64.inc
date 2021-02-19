; ================================================
; VIC-II registers
; ================================================

; Sprite coordinates
VSPR0_X		equ $D000		; Sets X position using bit 0 of VSPR_9 for 9th bit
VSPR0_Y		equ $D001
VSPR1_X		equ $D002
VSPR1_Y		equ $D003
VSPR2_X		equ $D004
VSPR2_Y		equ $D005
VSPR3_X		equ $D006
VSPR3_Y		equ $D007
VSPR4_X		equ $D008
VSPR4_Y		equ $D009
VSPR5_X		equ $D00A
VSPR5_Y		equ $D00B
VSPR6_X		equ $D00C
VSPR6_Y		equ $D00D
VSPR7_X		equ $D00E
VSPR7_Y		equ $D00F
VSPR_9		equ $D010		; 9th bit for sprite X coords, bit 0 = spr0, bit 1 = spr1, etc.
VSPRITE		equ $D015		; Each bit corresponds to a sprite
VSTRETCHY	equ $D017		; Stretches sprite vertically x2. Each bit = one sprite
VSTRETCHX	equ $D01D		; Stretches sprite horizontally x2. Each bit = one sprite
VSPR_COLLP	equ $D01B		; Sprite collision priority, 1 bit per sprite, 0 = sprite on top, 1 = bg on top
VSPR_MULT	equ $D01C		; Sprite Multicolor, 1 bit per sprite
VSPR_SCOLL	equ $D01E		; Sprite-Sprite collision: 1 bit per sprite
							; If two sprites collide, corresponding bits involved in collision are set (1).
							; Sets bit 2 of VINT_REQ.
VSPR_BCOLL	equ $D01F		; Sprite-Background collision: 1 bit per sprite
							; If sprite collides with bg, it's bit is set.
							; Sets bit 1 of VINT_REQ
VSPR_MULT1	equ $D025		; Sprite Multicolor 0: Set color 0 shared by multicolor sprites
VSPR_MULT2	equ $D026		; Sprite Multicolor 1: Set color 1 shared by multicolor sprites
VSPR_CLR0	equ $D027		; Color Sprite 0: Set color for sprite 0
VSPR_CLR1	equ $D028		; Color Sprite 0: Set color for sprite 1
VSPR_CLR2	equ $D029		; Color Sprite 0: Set color for sprite 2
VSPR_CLR3	equ $D02A		; Color Sprite 0: Set color for sprite 3
VSPR_CLR4	equ $D02B		; Color Sprite 0: Set color for sprite 4
VSPR_CLR5	equ $D02C		; Color Sprite 0: Set color for sprite 5
VSPR_CLR6	equ $D02D		; Color Sprite 0: Set color for sprite 6
VSPR_CLR7	equ $D02E		; Color Sprite 0: Set color for sprite 7

; Background
VBORDER_CLR	equ $D020		; Border Color: one of 16 colors ($00-0F)
VBG_CLR1	equ $D021		; Background Color 0: one of 16 colors ($00-0F)
VBG_CLR2	equ $D022		; Background Color 1: one of 16 colors ($00-0F)
VBG_CLR3	equ $D023		; Background Color 2: one of 16 colors ($00-0F)
VBG_CLR4	equ $D024		; Background Color 3: one of 16 colors ($00-0F)

; Control Registers
VCTRL1		equ $D011		; Initial %10011011
							; 0-2: shift screen vertically
							; 3: Enable 25 rows instead of 24
							; 4: Turn on VIC-II output
							; 5: Enable bitmap mode
							; 6: Enable Extended Color mode
							; 7: 9th bit for RAST_CNT ($D012)

VCTRL2		equ $D016		; Initial %00010100
							; 0-2: shift screen horizontally
							; 3: Enable 40 columns instead of 38
							; 4: Enable Multicolor Mode
							; 5-7: Not used

VBASE		equ $D018		; VIC-II base addresses (%00010100)
							; (bit 0 not used)
							; 1-3 = address bits 11-13 of Character Set (*2048)
							; 4-7 = address bits 10-13 of Screen RAM (*1024)

; Raster
RAST_CNT	equ $D012		; Read: current rasterline
							; Write: define rasterline that should trigger interrupt
							;        (bit 7 of VCTRL_1 holds 9th bit since may be > 255)

; Light Pen
LIGHT_PENX	equ $D013		; Light Pen's X coord, as half the value (x2 to get full value)
LIGHT_PENY	equ $D014		; Light Pen's Y coord

; Interrupt
VINT_REQ	equ $D019		; Interrupt Request Register
							; 0: Rasterline
							; 1: Sprite-Background collision
							; 2: Sprite-Sprite collision
							; 3: Light Pen impulse
							; 4-6: Not used
							; 7: At least one interrupt triggered
VINT_MASK	equ $D01A		; Interrupt Mask Register
							; 0: Rasterline
							; 1: Sprite-Background collision
							; 2: Sprite-Sprite collision
							; 3: Light Pen impulse
							; 4-7: Not used
