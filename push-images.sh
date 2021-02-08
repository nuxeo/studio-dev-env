#!/bin/bash -e

for NAME in bootstrap theia-project code-server-project shell-project dev-base; do
  IMG="docker.packages.nuxeo.com/nos-dev/${NAME}:latest"
  docker push ${IMG}
done
