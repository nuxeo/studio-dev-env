#!/usr/bin/env sh
docker --debug run --rm -ti -u "$(id -u):$(id -g)" -v "${PWD}:/home/nuxeo/workspace" docker.packages.nuxeo.com/nos-dev/bootstrap:latest "${*}"
