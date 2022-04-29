IMAGE_NAME = image.sif
INSTANCE_NAME = gha-utility-container

.PHONY: clean run-instance stop-instance

build: $(IMAGE_NAME)

clean:
	rm -rf *.sif

run-instance:
	sudo singularity instance start \
		-C -e $(IMAGE_NAME) $(INSTANCE_NAME)

stop-instance:
	sudo singularity instance stop $(INSTANCE_NAME)

%.sif: %.def
	sudo singularity build $@ $<
