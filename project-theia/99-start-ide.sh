#!/bin/bash -xe

# Start Code-server
exec yarn theia start ${PROJECT_HOME} --hostname=0.0.0.0 --port 8080
