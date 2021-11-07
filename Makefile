DOCKER_RUN_CMD = docker run
DOCKER_BUILD_CMD = docker build -t
DOCKERFILE_DIR = .
CONTAINER_NAME = docker-dev-desk
CLI_FLAGS = -it
CLI_CMD = /usr/bin/bash
GUI_FLAGS = -d -e DISPLAY=$(DISPLAY) --net=host -v /tmp/.X11-unix:/tmp/.X11-unix
GUI_CMD = /usr/bin/kitty
ifneq ($(project),)
	PROJECT_FLAG = -v $(HOSTPROJECT):/root/workplace/$(DOCKERPROJECT)
	HOSTPROJECT = $(project)
	DOCKERPROJECT = $(shell basename $(project))
endif
KVM_FLAGS = --device=/dev/kvm
USB_FLAGS = --privileged -v /dev/bus/usb:/dev/bus/usb

build:
	$(DOCKER_BUILD_CMD) $(CONTAINER_NAME) $(DOCKERFILE_DIR)

runcli:
	$(DOCKER_RUN_CMD) $(PROJECT_FLAG) $(CLI_FLAGS) $(KVM_FLAGS) $(USB_FLAGS) $(CONTAINER_NAME) $(CLI_CMD)

rungui:
	xhost +
	$(DOCKER_RUN_CMD) $(PROJECT_FLAG) $(GUI_FLAGS) $(KVM_FLAGS) $(USB_FLAGS) $(CONTAINER_NAME) $(GUI_CMD)

