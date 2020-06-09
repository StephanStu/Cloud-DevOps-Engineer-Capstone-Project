#!/usr/bin/env bash

# Step 1:
# Build image and add a descriptive tag
docker build --tag=predictor .

# Step 2:
# List docker images
docker image ls

# Step 3 (if you want to run locally and catch the app at port 8000 of the host):
# Run flask app
#docker run -p 8000:80 predictor
