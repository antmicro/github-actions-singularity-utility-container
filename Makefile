build: image.sif

.PHONY: clean

clean:
	rm -rf *.sif

%.sif: %.def
	sudo singularity build $@ $<
