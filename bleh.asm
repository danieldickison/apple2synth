
	processor 6502
	seg.u ZEROPAGE	; uninitialized zero-page variables
	org $0

	seg CODE
	org $803	; starting address

Main	lda $c010	; clear key
	jsr $fd0c 	; wait for keypress
	lda $c000 	; load key
	sta $400	; print char
	sbc #$31	; map ascii "1" to 0
        tax
        lda Table,x
        sta $1000
        jsr Buzz
        jmp Main

; Waits for y ops
Wait 	nop
	dey
        bne Wait
	rts

; Buzzes at $1000 delay between clicks
Buzz 	ldx #$cc    	; length of note
BuzzLoop
	lda $c030 	; click speaker
        ldy $1000
	jsr Wait
        dex
        bne BuzzLoop
	rts
        
Table:	hex 88 ;c
	hex 7a 6c 67 58 4f 46
	hex 42 ;c'
        