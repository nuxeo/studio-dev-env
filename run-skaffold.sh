#!/usr/bin/env sh
set -ex

# Pull latest skaffold image
# docker pull gcr.io/k8s-skaffold/skaffold:latest

# Use this cmd to skip tests
# $ skaffold --cache-artifacts=false --skip-tests=true -p dev build

WORK_FOLDER=$(dirname $(realpath $0))
docker run --rm -ti --privileged -v "/var/run/docker.sock:/var/run/docker.sock" -v "${WORK_FOLDER}:/root/ctx" -w "/root/ctx" gcr.io/k8s-skaffold/skaffold:latest ${@:-skaffold --cache-artifacts=false -p dev build}
