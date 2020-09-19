#!/usr/bin/env sh

IDE=${1:-code-server}
PROJECT_PATH="/Users/arnaud/Nuxeo/tmp/toto-vscode"
PROJECT=$(basename ${PROJECT_PATH})

if [ "code-server" == ${IDE} ]; then
  # Start CodeServer-Project
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "${HOME}/.m2/repository:/home/nuxeo/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" -e "EXTENSIONS=''" akervern/code-server-project:latest
fi

if [ "theia" == ${IDE} ]; then
  # Start Theia
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "${HOME}/.m2/repository:/home/nuxeo/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" akervern/theia-project:latest
fi
