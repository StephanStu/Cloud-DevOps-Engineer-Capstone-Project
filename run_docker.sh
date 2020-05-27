#!/usr/bin/env bash
# Step 1:
# Build image and add a descriptive tag
docker build --tag=my_static_website_host .

# Step 2:
# List docker images
docker image ls

# Step 3:
# Run containerized application
# docker run -p 8000:80 my_static_website_host
