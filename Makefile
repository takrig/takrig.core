#!make
include env.dev
export $(shell sed 's/=.*//' env.dev)
export WORKER_NAME=worker
export PYTHON=/usr/bin/python3.9
export VERSION=latest
export DEPLOYMENT=server
export IMAGE_NAME=$(DEPLOYMENT)
export CONTAINER=$(IMAGE_NAME)_container

default: run

build:
	$(PYTHON) -m pip install -r requirements.txt

run:
	export DEPLOYMENT=server && $(PYTHON) -m src.server.main

buildc:
	export DEPLOYMENT=server && DOCKER_BUILDKIT=1 docker image build --tag $(IMAGE_NAME):${VERSION} --build-arg DEPLOYMENT=$(deployment) --no-cache -f Dockerfile .

stopc:
	docker rm --force $(CONTAINER)

runc:
	docker run   --env-file env.dev --name ${CONTAINER} $(IMAGE_NAME):${VERSION}

run_tests:
	$(PYTHON) -m pytest --cov=src/ --ignore=tests/temporay

