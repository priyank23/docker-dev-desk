# docker-dev-desk
A docker container to be used as a general dev environment

## Building the container
Run the following command to build the container
```bash
make build
```

## Running the image
There are two options to run the images
* with GUI support
```bash 
make rungui
```
* without GUI support
```bash
make runcli
```
You can bind your project directory as volumes with the `project` flag.
```bash
make rungui project=~/path_to_project
```
