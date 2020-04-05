#!/bin/bash
set -ev

echo "Reverse proxy service"

if [ "$BUILD_ENV" == "production" ]; then
  echo "Building production image: dzarate/udacity-reverseproxy:latest"
  docker build -t dzarate/udacity-reverseproxy:latest .
else
  echo "Building development image: dzarate/udacity-reverseproxy:latest-dev"
  docker build -t dzarate/udacity-reverseproxy:latest-dev .
fi
