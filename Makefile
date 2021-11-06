HOSTPROJECT = $(project)
DOCKERPROJECT = $(shell basename $(project))
ifeq ($(project),)
	DOCKER_RUN_CMD = docker run -ti --rm -e DISPLAY=$(DISPLAY) --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -v $(HOSTPROJECT):/root/workplace/$(DOCKERPROJECT) docker-dev-desk
else
	DOCKER_RUN_CMD = docker run -ti --rm -e DISPLAY=$(DISPLAY) --net=host -v /tmp/.X11-unix:/tmp/.X11-unix docker-dev-desk
endif

build:
	docker build -t docker-dev-desk .

run:
	xhost + 
	$(DOCKER_RUN_CMD)

