#!/bin/bash

# Figure out where this script is located, get project name
PROJECT_DIR=$(realpath "$(dirname "$(readlink -f "$0")")/../..")
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Replace the current shell with an interactive Docker container
exec docker run -it --rm \
	-v /etc/group:/etc/group:ro \
	-v /etc/passwd:/etc/passwd:ro \
	-u $(id -u $USER):$(id -g $USER) \
	-v $PROJECT_DIR:/app \
	-p 80:8888 \
	"${PROJECT_NAME}-dev"
