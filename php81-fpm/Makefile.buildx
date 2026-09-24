# PILOT: buildx-based Makefile for this image only.
# Every other image still uses ../_tools/makefiles/base-image-Makefile.
# 
# Converted so far: build (single native platform, via buildx, no sed hack).
# Not converted yet, deliberately: test/push/publish/manifest/clean — those
# still need to be reasoned through one at a time.

IMAGE_BASE_NAME = $(shell basename $(shell pwd))
IMAGE_TYPE      = nfqlt
IMAGE_REGISTRY  = docker.nfq.lt/
IMAGE_FULL_NAME = $(IMAGE_REGISTRY)$(IMAGE_TYPE)/$(IMAGE_BASE_NAME)
IMAGE_PUBLISH_NAME = $(IMAGE_TYPE)/$(IMAGE_BASE_NAME)
NO_CACHE ?= false
# Parent image this Dockerfile FROMs, e.g. "nfqlt/php81-cli".
# Same fact the old sed hack needed — read once here instead of regexed at build time.
PARENT_IMAGE = $(shell grep '^FROM ' Dockerfile | head -1 | awk '{print $$2}')
ARCH ?= $(shell docker version -f '{{.Server.Arch}}')
# Where to resolve PARENT_IMAGE from for this build. Defaults to the registry's
# multi-arch "latest" manifest (so it resolves to whatever arch you're on).
# Override for a fully offline test, e.g.:
#   make build PARENT_REF=docker.nfq.lt/nfqlt/php81-cli:local
PARENT_REF = $(IMAGE_REGISTRY)$(PARENT_IMAGE):latest

COMMANDS = help build status get-image-name
.PHONY: $(COMMANDS)
.SILENT: status get-image-name

help:
	@echo
	@echo "Image name:   $(IMAGE_FULL_NAME)"
	@echo "Parent image: $(PARENT_IMAGE)  (resolved from $(PARENT_REF))"
	@echo "Available commands: $(COMMANDS)"
	@echo "Architecture: $(ARCH)"
	@echo

build:
	@echo
	@echo "# [buildx] Building $(IMAGE_FULL_NAME):$(ARCH) ..."
	@echo "# Remapping $(PARENT_IMAGE) -> $(PARENT_REF)"
	@echo
	docker buildx build \
            --platform linux/$(ARCH) \
            --build-context $(PARENT_IMAGE)=docker-image://$(PARENT_REF) \
            $(if $(filter true,$(NO_CACHE)),--no-cache,) \
            --load \
            -t $(IMAGE_FULL_NAME):$(ARCH) \
            .
	$(MAKE) status

test-dev:
	@echo
	@echo "# Testing image..."
	@echo
	if [ -d test ]; then \
            run-parts -v -a $(IMAGE_FULL_NAME):$(ARCH) test; \
	fi
	@echo
	@echo "Tests passed. ($(shell run-parts --test test | wc -l))"
	@echo

all: build test-dev push

push:
	@echo
	@echo "# Pushing $(IMAGE_FULL_NAME):$(ARCH) to registry..."
	@echo
	docker push $(IMAGE_FULL_NAME):$(ARCH)

# Run once both arch-specific pushes exist (mirrors the old job that had
# `needs: [_arm64]` and ran after both arches were pushed).
push-manifest:
	@echo
	@echo "# Creating combined manifest for $(IMAGE_FULL_NAME):latest..."
	@echo
	docker buildx imagetools create --tag $(IMAGE_FULL_NAME):latest $(IMAGE_FULL_NAME):amd64 $(IMAGE_FULL_NAME):arm64

publish:
	@echo
	@echo "# Mirroring $(IMAGE_FULL_NAME):latest -> $(IMAGE_PUBLISH_NAME):latest (Docker Hub)..."
	@echo
	docker buildx imagetools create --tag $(IMAGE_PUBLISH_NAME):latest $(IMAGE_FULL_NAME):latest

run:
	docker run -it --rm $(IMAGE_FULL_NAME):$(ARCH)

run-bash:
	docker run -it --rm $(IMAGE_FULL_NAME):$(ARCH) env TERM=xterm bash -l

clean:
	docker rmi $(IMAGE_FULL_NAME):$(ARCH) 2>/dev/null || true
	$(MAKE) status

status:
	docker images | grep -i "$(IMAGE_FULL_NAME) " || true

get-image-name:
	echo $(IMAGE_FULL_NAME)
