screenpos = $05e5 ;position in the screen RAM from where the character is read (between ( ) of runtext)
chrout = $ffd2 ;vector to Kernal function to print a character in A
setcursor = $fff0 ;vector to Kernal function to set the cursor to a given position in X/Y

*=$0801 ;start of the program
!byte $0c,$08,$e2,$07,$9e,$20,$32,$30,$36,$32,$00,$00,$00 ;basic command to run the program

;character set to uppcercase
lda #$15
sta $d018

;save current char at screenpos on stack
lda screenpos
pha

;clear screen
lda #$93
jsr chrout

;define row and colum of text output in X/Y
ldx #$0c ;row
ldy #$00 ;column
jsr runtextout

;restore screenpos char from the beginning
pla
sta screenpos

ldx #$0c
ldy #$08
jsr binaryout

ldx #$0c
ldy #$12
jsr hexout

rts ;back to BASIC

;print text stored at $runtext
;X = row of output start
;Y = column of output start
;returns: nothing
;changes: A,X,Y,SR
runtextout
  clc ;clear carry to tell setcursor to set and not to read the cursor
  jsr setcursor ; set cursor to position in X/Y
  ldx #$00 ;index of runtext

  runtextcharin
    lda runtext,x ;load char at position x from runtext into A
    beq done ;end of text if char is 0
    jsr chrout ;print char
    inx ;next char
    jmp runtextcharin ; next loop cycle
  done
    rts

runtext
  !text "RUN:( ) "
  !byte $00 ;marker for text end

;print character at A in binary at position X/Y
;A = char to be shown in binary
;X = row of output start
;Y = column of output start
;returns: nothing
;changes: X,Y,SR
binaryout
  pha ;store character, because A will be used
  clc ;clear carry to set and not get cursor
  jsr setcursor ;set cursor to X/Y
  lda #"%" ; prefix for binary number
  jsr chrout
  pla ;restore char to be printed in binary
  pha ;and store it for later

  ldy #$07 ;binary representation will have 8 digits
  binoutloop
    ldx #"0" ;default is zero
    asl ;shift msb into carry
    bcc out ;if carry is zero, print
    inx ;if not zero, increaese to one
  out
    pha ;store char
    txa ;move binary digit to A
    jsr chrout ;print A on screen
    pla ;load char
    dey ;decrease loop var
    bpl binoutloop ;continue loop until Y is negative
    pla ;restore original A
    rts

;print character at A in hex at position X/Y
;A = char to be shown in binary
;X = row of output start
;Y = column of output start
;returns: nothing
;changes: X,Y,S
hexout
  pha ;store character, because A will be used
  clc ;clear carry to set and not get cursor
  jsr setcursor ;set cursor to X/Y
  lda #"$" ;prefix for hex number
  jsr chrout
  pla ;restore char to be printed in hex
  pha ;and store it for later
  pha ;again because of LSR and chrout
  lsr ;move MSB into LSB
  lsr
  lsr
  lsr
  tax ;
  lda possiblehexchars,x ;char for upper nibble
  jsr chrout ;print char
  pla ;restore char to be printed for next nibble
  and #$0f ;mask upper nibble
  tax ;
  lda possiblehexchars, x ;char for lower nibble
  jsr chrout ;print char
  pla ;restore akku
  rts

possiblehexchars
  !text "0123456789ABCDEF"
