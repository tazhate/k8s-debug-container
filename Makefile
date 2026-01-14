.PHONY: all build-% push-% build-all push-all clean help

REGISTRY ?= docker.io
IMAGE_PREFIX ?= tazhate/k8s-debug-container
TAG ?= latest

# Image name -> directory mapping
IMAGES := minimal net db k8s storage perf stress full

# Directory names
DIR_minimal := minimal-debug
DIR_net := net-debug
DIR_db := db-debug
DIR_k8s := k8s-debug
DIR_storage := storage-debug
DIR_perf := perf-debug
DIR_stress := stress-debug
DIR_full := full-debug

help:
	@echo "Usage:"
	@echo "  make build-<image>   Build a specific image (e.g., make build-net)"
	@echo "  make push-<image>    Push a specific image (e.g., make push-net)"
	@echo "  make build-all       Build all images"
	@echo "  make push-all        Push all images"
	@echo "  make clean           Remove local images"
	@echo ""
	@echo "Available images:"
	@echo "  $(IMAGES)"
	@echo ""
	@echo "Examples:"
	@echo "  make build-minimal   Build minimal image"
	@echo "  make build-net       Build network debug image"
	@echo "  make build-stress    Build stress testing image"
	@echo ""
	@echo "Variables:"
	@echo "  REGISTRY=$(REGISTRY)"
	@echo "  IMAGE_PREFIX=$(IMAGE_PREFIX)"
	@echo "  TAG=$(TAG)"

build-%:
	@echo "Building $*..."
	docker build -t $(REGISTRY)/$(IMAGE_PREFIX)-$*:$(TAG) ./images/$(DIR_$*)

push-%: build-%
	@echo "Pushing $*..."
	docker push $(REGISTRY)/$(IMAGE_PREFIX)-$*:$(TAG)

build-all: $(addprefix build-,$(IMAGES))
	@echo "All images built successfully"

push-all: $(addprefix push-,$(IMAGES))
	@echo "All images pushed successfully"

# Build multi-arch images using buildx
buildx-%:
	@echo "Building $* for multi-arch..."
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		-t $(REGISTRY)/$(IMAGE_PREFIX)-$*:$(TAG) \
		--push \
		./images/$(DIR_$*)

buildx-all: $(addprefix buildx-,$(IMAGES))
	@echo "All multi-arch images built and pushed"

clean:
	@echo "Removing local images..."
	@for img in $(IMAGES); do \
		docker rmi $(REGISTRY)/$(IMAGE_PREFIX)-$$img:$(TAG) 2>/dev/null || true; \
	done

# Test images locally
test-%:
	@echo "Testing $*..."
	docker run --rm $(REGISTRY)/$(IMAGE_PREFIX)-$*:$(TAG) bash -c "echo 'Image $* works!'"

test-all: $(addprefix test-,$(IMAGES))
	@echo "All images tested successfully"
