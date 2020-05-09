*=$0801
!byte $0c,$08,$e2,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00

lda #%10000000
ldy #$00

binoutloop
  bit number
  bne one
  ldx #"0"
  jmp out

one
  ldx #"1"

out
  pha
  txa
  sta $0400,y
  pla
  iny
  lsr
  bne binoutloop
  rts

number
  !byte $c9
