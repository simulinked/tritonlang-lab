.PHONY: help build push dev test test-env

IMAGE:=simulinked/tritonlang-lab
TAG?=latest
VERSION=1.1.1

help:
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean:
	docker image prune

build: DARGS?=--pull --build-arg triton_version=$(VERSION)
build:
	docker build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest

dev: ARGS?=
dev: DARGS?=-v $(PWD)/notebook:/home/jovyan/notebook
dev: PORT?=8888
dev:
	docker run -it --rm -p $(PORT):8888 $(DARGS) $(IMAGE):$(VERSION) $(ARGS)

test:
	pytest tests

test-env:
	pip install -r requirements-test.txt
