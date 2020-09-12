#!/bin/bash -xe

# Start Code-server
exec yarn theia start ${WORKSPACE_PATH} --hostname=0.0.0.0 --port 8080
