#!/usr/bin/env sh

docker run --rm -ti -v "${PWD}:/home/nuxeo/workspace" docker.packages.nuxeo.com/nos-dev/bootstrap:latest $*
