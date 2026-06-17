#!/bin/bash

echo "Running stop container script..."

container=`docker ps -q`

docker stop $container