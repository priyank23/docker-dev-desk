DOCKER_RUN_CMD = docker run -ti --rm
DOCKER_BUILD_CMD = docker -t
DOCKERFILE_DIR = .
CONTAINER_NAME = docker-dev-desk
CLI_CMD = /usr/bin/bash
GUI_FLAGS = -e DISPLAY=$(DISPLAY) --net=host -v /tmp/.X11-unix:/tmp/.X11-unix
GUI_CMD = /usr/bin/kitty
ifneq ($(project),)
	PROJECT_FLAG = -v $(HOSTPROJECT):/root/workplace/$(DOCKERPROJECT)
	HOSTPROJECT = $(project)
	DOCKERPROJECT = $(shell basename $(project))
endif

build:
	docker build -t docker-dev-desk .
	$(DOCKER_BUILD_CMD) $(CONTAINER_NAME) $(DOCKERFILE_DIR)

runcli:
	$(DOCKER_RUN_CMD) $(PROJECT_FLAG) $(CONTAINER_NAME) $(CLI_CMD)

rungui:
	xhost +
	$(DOCKER_RUN_CMD) $(PROJECT_FLAG) $(GUI_FLAGS) $(CONTAINER_NAME) $(GUI_CMD)

