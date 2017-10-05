#!/bin/bash

# Figure out where this script is located, get project name
PROJECT_DIR=$(realpath "$(dirname "$(readlink -f "$0")")/../..")
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Build a new Docker image
exec docker build --rm \
	--file "${PROJECT_DIR}/.docker/dev/Dockerfile" \
	--tag "${PROJECT_NAME}-dev:latest" \
	${PROJECT_DIR}
	
