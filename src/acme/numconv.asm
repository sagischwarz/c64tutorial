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

;Binärausgabe

;Hexausgabe

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

;Sub Binärausgabe

;Sub Hexausgabe
