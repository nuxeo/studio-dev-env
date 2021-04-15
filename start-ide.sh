#!/usr/bin/env sh

CWD=$(realpath "$(dirname "$0")")
IDE=${1:-code-server}
PROJECT_PATH="/Users/arnaud/Nuxeo/tmp/toto-vscode"
PROJECT=$(basename "${PROJECT_PATH}")
B64_PROJECT=$(echo -n "${PROJECT}" | base64)

if [ "code-server" == "${IDE}" ]; then
  # Start CodeServer-Project
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "${HOME}/.m2/repository:/home/nuxeo/.m2/repository" --mount "source=cs-settings-${B64_PROJECT},target=/home/nuxeo/.local/share/code-server/User" --mount "type=bind,source=${CWD}/.env.nuxeo-cli,target=/home/nuxeo/workspace/.env.nuxeo-cli,readonly" -e "EXTENSIONS=''" docker.packages.nuxeo.com/nos-dev/code-server-project:latest
fi

if [ "theia" == "${IDE}" ]; then
  # Start Theia
  exec docker run --rm -it -p 127.0.0.1:8080:8080 -v "${PROJECT_PATH}:/home/nuxeo/workspace/${PROJECT}" -v "${HOME}/.m2/repository:/home/nuxeo/.m2/repository" --mount "source=theia-settings-${B64_PROJECT},target=/home/nuxeo/.theia" --mount "type=bind,source=${CWD}/.env.nuxeo-cli,target=/home/nuxeo/workspace/.env.nuxeo-cli,readonly" docker.packages.nuxeo.com/nos-dev/theia-project:latest
fi
