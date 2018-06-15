OUT := go-guess
PKG := github.com/AaronNBrock/go-guess
VERSION := $(shell git describe --always --long --dirty)
DOCKER_TAG := aaronnbrock/$(OUT)
# DOCKER_TAG_LATEST := $(DOCKER_TAG):latest
DOCKER_TAG_VERSION := $(DOCKER_TAG):$(VERSION:v%=%) # Version with out the `v` at the beginning

build:
	go build -o $(OUT) -ldflags="-X main.version=$(VERSION)" $(PKG)

build-docker:
	docker build -t $(DOCKER_TAG_VERSION) -t $(OUT) .

run: build
	./$(OUT)

version: build
	./${OUT} -version