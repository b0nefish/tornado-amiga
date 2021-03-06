����                                        start	lea	player(pc),a6
	lea	myPlayer,a0
	lea	mySong,a1
	lea	song0,a2
	add.l	(0,a6),a6
	jsr	(a6)		; songInit

	lea	player(pc),a6
	lea	myPlayer,a0
	lea	chipmem,a1
	lea	mySong,a2
	add.l	(4,a6),a6
	jsr	(a6)		; playerInit

.loop	btst	#6,$bfe001
	beq	.exit
	jsr	waitVbl
	lea	player(pc),a6
	lea	myPlayer,a0
	add.l	(8,a6),a6
	jsr	(a6)		; playerTick
	bra	.loop
.exit	rts

waitVbl	
.0	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0
	beq	.0

.1	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0
	bne	.1
	rts

	incdir  "hd0:sources/"
player	incbin	"player.bin"
song0	incbin	"prefix.prt"

	section bss,bss
mySong	ds.w	16*1024/2
myPlayer	ds.l	16*1024/4

	section	chip,bss_c
chipmem	ds.b	128*1024
