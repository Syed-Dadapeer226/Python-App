#!/bin/bash

echo "Running start container script..."

IMAGE="syeddadapeer226/python-app"

# Function
docker_run() {

    TAG=`curl -s "https://hub.docker.com/v2/repositories/${IMAGE}/tags?page_size=100" \
    | jq -r '.results[].name' | head -n 1`

    echo "Latest Image tag: $IMAGE:$TAG"

    # Pull Image + Create + Start the container
    docker run -d -p 5000:5000 $IMAGE:$TAG
}

# Function call
docker_run
