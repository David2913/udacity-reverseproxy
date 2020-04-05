#!/bin/bash
set -ev

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

if [ "$BUILD_ENV" == "production" ]; then
  echo "Deploying production image: dzarate/udacity-reverseproxy:latest"
  docker push dzarate/udacity-reverseproxy:latest
else
  echo "Deploying development image: dzarate/udacity-reverseproxy:latest-dev"
  docker push dzarate/udacity-reverseproxy:latest-dev
fi
