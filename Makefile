ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

IMAGE_NAME=opencord/mavenrepo
PACKAGE_TAG=candidate

.PHONY: all
all: images

.PHONY: images
images:
	docker build -f Dockerfile.make -t $(IMAGE_NAME):$(PACKAGE_TAG) $(ROOT_DIR)

.PHONY: clean
clean:
	docker rmi opencord/mavenrepo:$(PACKAGE_TAG) | true

.PHONY: test
test:
	@echo "No unit tests at present"

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  images: build the Docker image (Maven repo with the CORD ONOS apps)"
	@echo "  clean:  remove the Docker image"
	@echo "  test:   run unit tests"
	@echo "  help:   print this help message"

