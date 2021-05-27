#!/usr/bin/env sh
docker run --rm -ti -u "$(id -u):$(id -g)" -v "${PWD}:/home/nuxeo/workspace" docker.packages.nuxeo.com/nos-dev/bootstrap:latest $*
