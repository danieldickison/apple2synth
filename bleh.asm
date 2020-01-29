
	processor 6502
	seg.u ZEROPAGE	; uninitialized zero-page variables
	org $0

	seg CODE
	org $803	; starting address

Main	lda $c010	; clear key
	jsr $fd0c 	; wait for keypress
	lda $c000 	; load key
	sta $400	; print char
        cmp #$41
        beq Song
        clc
	sbc #$30	; map ascii "1" to 0
        tax
        ldy #200
        jsr Buzz
        jmp Main

; Waits for x*255 ops
Wait 	
WaitOuter
	ldy #255
WaitInner
	nop
        dey
        bne WaitInner
        dex
        bne WaitOuter
	rts

; Buzzes note x
Buzz 	lda Lengths,x
BuzzLoop
	sta $c030 	; click speaker
        ldy Notes,x
BuzzWait
	nop
        dey
        bne BuzzWait
	clc
        sbc #1
        bne BuzzLoop
	rts
        
Notes	hex 88 ;c
	hex 7a 6c 67 5a 4f 46
	hex 42 ;c'
Lengths hex 7e 9a ae c0 cc d4 e0 fe

Song 	ldx #0
        jsr Buzz
        ldx #150
        jsr Wait
        ldx #1
        jsr Buzz
        ldx #50
        jsr Wait
        ldx #2
        jsr Buzz
        ldx #150
        jsr Wait
        ldx #0
        jsr Buzz
        ldx #50
        jsr Wait
        ldx #2
        jsr Buzz
        ldx #100
        jsr Wait
        ldx #0
        jsr Buzz
        ldx #100
        jsr Wait
        ldx #2
        jsr Buzz
        ldx #200
        jsr Wait
        jmp Main
        