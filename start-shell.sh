#!/usr/bin/env sh

IDE=${1:-code-server}
PROJECT_PATH="/Users/arnaud/Nuxeo/tmp/toto-vscode"
PROJECT=$(basename ${PROJECT_PATH})

exec docker run --rm -it -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "/Users/arnaud/.m2/repository:/home/nuxeo/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" akervern/shell-project:latest
