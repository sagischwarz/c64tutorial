%.prg : src/acme/%.asm
		mkdir -p bin
		acme -f cbm -o bin/$@ $<

%.prg : src/basic/%.bas
		mkdir -p bin
		petcat -w2 -o bin/$@ $<
