#!/bin/bash -ex

# build base image
docker build -t akervern/code-server-base code-server-base

# build code-server + maven
docker build -t akervern/code-server-java code-server-java

# build project image
docker build -t akervern/project-code-server project-code-server
