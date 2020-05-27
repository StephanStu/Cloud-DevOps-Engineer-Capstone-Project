#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=stephanstu/my_static_website_host
# Step 2:
# Authenticate & tag
export DOCKER_ID_USER="stephanstu"
docker login
docker tag my_static_website_host $DOCKER_ID_USER/my_static_website_host
docker push $DOCKER_ID_USER/my_static_website_host

# Step 3:
# Push image to a docker repository
docker push stephanstu/my_static_website_host
