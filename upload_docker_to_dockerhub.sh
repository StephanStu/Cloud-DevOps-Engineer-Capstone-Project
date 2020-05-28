#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=stephanstu/udacity_capstone_project_repository
# Step 2:
# Authenticate & tag
export DOCKER_ID_USER="stephanstu"
docker login
docker tag udacity_capstone_project_repository $DOCKER_ID_USER/udacity_capstone_project_repository
docker push $DOCKER_ID_USER/udacity_capstone_project_repository

# Step 3:
# Push image to a docker repository
docker push stephanstu/udacity_capstone_project_repository
