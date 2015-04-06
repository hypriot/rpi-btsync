DOCKER_IMAGE_VERSION=2.0.93
DOCKER_IMAGE_NAME=hypriot/rpi-btsync
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag -f $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

version:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /opt/btsync/bin/btsync --version

run:
	docker run -d -p=8888:8888 -p=5555:5555 -p 5555:5555/udp -v $$(pwd)/bt-storage:/bt-storage -v $$(pwd)/data:/data hypriot/rpi-btsync