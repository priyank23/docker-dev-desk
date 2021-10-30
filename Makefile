build:
	docker build -t docker-dev-desk .

run:
	xhost + 
	docker run -ti --rm -e DISPLAY=$(DISPLAY) --net=host -v /tmp/.X11-unix:/tmp/.X11-unix docker-dev-desk
	
