IMAGE_NAME = image.sif
INSTANCE_NAME = gha-utility-container

# Example b64-encoded config for user test and two port forwards (2100, 2101).
define EXAMPLE_SSH_CONFIG_B64
SG9zdCBzb21lLWhvc3QKICBIb3N0TmFtZSAxMjcuMC4wLjEKICBVc2VyIHRlc3QKICBTdHJpY3RIb3N0S2V5Q2hlY2tpbmcgbm8KICBFeGl0T25Gb3J3YXJkRmFpbHVyZSB5ZXMKICBMb2NhbEZvcndhcmQgbG9jYWxob3N0OjIxMDAgMTI3LjAuMC4xOjIxMDAKICBMb2NhbEZvcndhcmQgbG9jYWxob3N0OjIxMDEgMTI3LjAuMC4xOjIxMDEK
endef

.PHONY: clean run-instance stop-instance

build: $(IMAGE_NAME)

clean:
	rm -rf *.sif

run-instance:
	sudo singularity instance start \
		-C -e --writable-tmpfs $(IMAGE_NAME) $(INSTANCE_NAME)

stop-instance:
	sudo singularity instance stop $(INSTANCE_NAME)

test-instance-ssh:
	sudo singularity run \
		--app sshtunnel \
		instance://$(INSTANCE_NAME) \
		1 \
		$(strip $(EXAMPLE_SSH_CONFIG_B64)) \
		$(shell cat ~/.ssh/id_rsa | base64 -w0)	

%.sif: %.def
	sudo singularity build -F $@ $<
