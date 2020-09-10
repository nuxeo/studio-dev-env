#!/bin/bash

IDE=${1:-code-server}

if [ "code-server" == ${IDE} ]; then
  # Start CodeServer-Project
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "/Users/arnaud/Nuxeo/tmp/toto-vscode:/home/coder/project/project" -v "/Users/arnaud/.m2/repository:/home/coder/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" -e "EXTENSIONS=''" akervern/project-code-server:latest
fi

if [ "theia" == ${IDE} ]; then
  # Start Theia
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "/Users/arnaud/Nuxeo/tmp/toto-vscode:/home/theia/project/project" -v "/Users/arnaud/.m2/repository:/home/theia/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" akervern/project-theia:latest
fi
