#!/usr/bin/env sh

CWD=$(realpath $(dirname $0))
PROJECT_PATH="/Users/arnaud/Nuxeo/tmp/train-test"
PROJECT=$(basename ${PROJECT_PATH})

exec docker run --rm -it -u $(id -u):$(id -g) -w "/" -v "/var/run/docker.sock:/var/run/docker.sock" -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "${HOME}/.m2/repository:/home/nuxeo/.m2/repository" --mount "type=bind,source=${CWD}/.env.nuxeo-cli,target=/home/nuxeo/workspace/.env.nuxeo-cli,readonly" docker.packages.nuxeo.com/nos-dev/shell-project:latest
