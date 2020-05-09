%.acme : src/acme/%.acme
		mkdir -p bin
		acme -f cbm -o bin/$@ $<

%.bas : src/basic/%.bas
		mkdir -p bin
		petcat -w2 -o bin/$@ $<
