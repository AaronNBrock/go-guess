OUT := go-guess
PKG := github.com/AaronNBrock/go-guess
VERSION := $(shell git describe --always --dirty)
DOCKER_TAG := aaronnbrock/$(OUT)

DOCKER_TAG_VERSION := $(DOCKER_TAG):$(VERSION:v%=%) # Version with out the `v` at the beginning

# If version doesn't have a '-'
ifeq ($(findstring -,$(VERSION)),)
# tag docker with "latest"
DOCKER_TAG_LATEST := $(DOCKER_TAG):latest
# else
else
# tag docker with "edge"
DOCKER_TAG_LATEST := $(DOCKER_TAG):edge
endif



check-deploy:
ifneq ($(findstring -dirtyPOTATO,$(VERSION)POTATO),)
	@echo "***************************************************"
	@echo "Error: Can't deploy with a dirty working directory."
	@echo "***************************************************"
	@exit 1
else
	@echo "Ready for deployment"
endif

build:
	go build -o $(OUT) -ldflags="-X main.version=$(VERSION)" $(PKG)

run: build
	./$(OUT)

version: build
	./$(OUT) -version

docker-build: build
	docker build -t $(DOCKER_TAG_VERSION) -t $(DOCKER_TAG_LATEST) -t $(OUT) .

docker-deploy: check-deploy docker-build
	docker push $(DOCKER_TAG_LATEST)
	docker push $(DOCKER_TAG_VERSION)

docker-run: docker-build
	docker run -i $(OUT)

docker-version: docker-build
	docker run -i $(OUT) -version
