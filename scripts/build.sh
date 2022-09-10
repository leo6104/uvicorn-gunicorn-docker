#!/usr/bin/env bash
set -e

use_tag="tiangolo/uvicorn-gunicorn:$NAME"

DOCKERFILE="$NAME"

if [ "$NAME" == "latest" ] ; then
    DOCKERFILE="python3.10"
fi

docker buildx use multiarch ||  docker buildx create --name multiarch --use

docker buildx build \
  --platform "linux/amd64,linux/arm64,linux/arm/v7" \
  --file "./docker-images/${DOCKERFILE}.dockerfile" \
  -t "$use_tag"  \
  "./docker-images/"