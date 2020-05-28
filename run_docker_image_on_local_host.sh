#!/usr/bin/env bash
# Step 1:
# Uncomment, if you did not run buidl_docker_imags.sh; build image and add a descriptive tag
# docker build -t udacity_capstone_project_repository .

# Step 2:
# List docker images
docker image ls

# Step 3:
# Run containerized application
docker run -p 8000:80 udacity_capstone_project_repository
