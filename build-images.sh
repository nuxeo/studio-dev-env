#!/bin/bash -ex

# Build dev base image
docker build -t akervern/dev-base dev-base
docker build -t akervern/project-base project-base

# build base image
# docker build -t akervern/code-server-base code-server-base
docker build -t akervern/theia-builder theia-builder
docker build -t akervern/theia-base theia-base

# build code-server + maven
# docker build -t akervern/code-server-java code-server-java

# build project image
# docker build -t akervern/code-server-project code-server-project
docker build -t akervern/theia-project theia-project
