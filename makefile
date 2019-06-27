hello: src/basic/hello.bas
		mkdir -p bin
		petcat -w2 -o bin/hello.prg src/basic/hello.bas
sprite: src/basic/sprite.bas
		mkdir -p bin
		petcat -w2 -o bin/sprite.prg src/basic/sprite.bas
spades: src/acme/spades.asm
		mkdir -p bin
		acme -f cbm -o bin/spades.prg src/acme/spades.asm
flicker: src/acme/flicker.asm
		mkdir -p bin
		acme -f cbm -o bin/flicker.prg src/acme/flicker.asm
bitcount: src/acme/bitcount.asm
		mkdir -p bin
		acme -f cbm -o bin/bitcount.prg src/acme/bitcount.asm
