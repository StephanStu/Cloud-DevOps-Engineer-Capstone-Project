#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub
# Assumes that an image is built via `build_docker_image.sh`
# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=stephanstu/predictor
# Step 2:
# Authenticate & tag
export DOCKER_ID_USER="stephanstu"
docker login
docker tag predictor $DOCKER_ID_USER/predictor
docker push $DOCKER_ID_USER/predictor
# Step 3:
# Push image to a docker repository
docker push stephanstu/predictor
