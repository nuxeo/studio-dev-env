#!/usr/bin/env sh
set -ex

# Build dev base image
docker build -t docker.packages.nuxeo.com/nos-dev/dev-base dev-base
docker build -t docker.packages.nuxeo.com/nos-dev/project-base project-base

# build base image
# docker build -t docker.packages.nuxeo.com/nos-dev/code-server-base code-server-base
docker build -t docker.packages.nuxeo.com/nos-dev/theia-builder theia-builder
docker build -t docker.packages.nuxeo.com/nos-dev/theia-base theia-base

# build code-server + maven
# docker build -t docker.packages.nuxeo.com/nos-dev/code-server-java code-server-java

# build project image
# docker build -t docker.packages.nuxeo.com/nos-dev/code-server-project code-server-project
docker build -t docker.packages.nuxeo.com/nos-dev/theia-project theia-project
