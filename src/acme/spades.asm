screenram = $0400
char = $41
colorram = $d800
colorno = $00
screenzeroaddr = $fb
colorzeroaddr = $fd

*=$0801
!byte $0c,$08,$e2,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

startadr
lda #<screenram
sta screenzeroaddr
lda #>(screenram+$0300)
sta screenzeroaddr+1

lda #<colorram
sta colorzeroaddr
lda #>(colorram+$0300)
sta colorzeroaddr+1

ldy #$00
lda #char
sta (screenzeroaddr),y
lda #colorno
sta (colorzeroaddr),y

lda #$01
sta $ff
ldy $ff

ldx pagecount,y

txa
ldx #$02
ldy charcount,x
tax

loop
  lda #char
  sta (screenzeroaddr),y
  lda #colorno
  sta (colorzeroaddr),y
  dey
  bne loop

  dec screenzeroaddr+1
  dec colorzeroaddr+1
  dex
  bne loop

sei
lda #%11111110
sta $dc00
getkeyloop
  lda $dc01
  and #%00010000
  bne getkeyloop

cli

rts

pagecount
  !byte $03, $04, $00, $01, $02

charcount
  !byte $ff, $00, $e7, $80
