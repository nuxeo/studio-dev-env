#!/usr/bin/env bash
set -e
# set -ex

echo "Nuxeo Developer Environment bootstrap:"
read -p "- Studio Username: " STUDIO_USERNAME
read -p "- Studio Token: " STUDIO_TOKEN
read -p "- Studio Project: " STUDIO_PROJECT

CWD=$(realpath $(pwd))
PROJECT=$(basename ${CWD})
RANDOM_STR=$(
  date +%s | sha256sum | base64 | head -c 8
  echo
)
DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-akervern}
DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME:-dev-base}
DOCKER_TAG=${DOCKER_TAG:-latest}
DOCKER_IMAGE=${DOCKER_REPOSITORY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
DOCKER_MOUNTS="-v ${CWD}:/tmp/workspace/${PROJECT} -w /tmp/workspace/${PROJECT}"

CLI_BOOTSTRAP=${NUXEO_BOOTSTRAP:-multi-module operation package}

STUDIO_PROJECT=${STUDIO_PROJECT:-}
STUDIO_USERNAME=${STUDIO_USERNAME:-}
STUDIO_TOKEN=${STUDIO_TOKEN:-}

# Force pulling Docker image
docker pull ${DOCKER_IMAGE} &>/dev/null || true

# Ensure folder is empty
if [ "$(ls -A ${CWD})" ]; then
  echo "Current directory must be empty."
  exit 1
fi

# Bootstrap Project
# TODO Disable end message, to KISS without displaying useless msg
echo "Bootstraping a new Nuxeo Project:"
bash -e -c "docker run --init --rm -ti ${DOCKER_MOUNTS} ${DOCKER_IMAGE} nuxeo -n b ${CLI_BOOTSTRAP}"

# Register Instance
# TODO Use non-interactive/batch mode, and pass username, project and token from env variables at script generation time?
bash -c "docker run --init --rm -ti ${DOCKER_MOUNTS} ${DOCKER_IMAGE} nuxeo -n studio link"

# Create start-ide.sh script
cat >${CWD}/start-ide.sh <<EOF
#!/usr/bin/env sh
set -ex

exec docker run --rm -it -p 127.0.0.1:8080:8080 --mount "type=bind,source=${CWD},destination=/home/nuxeo/workspace/${PROJECT}" --mount "type=bind,source=${HOME}/.m2/repository,destination=/home/nuxeo/.m2/repository" --mount "source=cs-user-settings-${RANDOM_STR},target=/home/nuxeo/.local/share/code-server/User" -e "PROJECT=${STUDIO_PROJECT}" -e "USERNAME=${STUDIO_USERNAME}" -e "TOKEN=${STUDIO_TOKEN}"  ${DOCKER_REPOSITORY}/code-server-project:latest
EOF
chmod +x ${CWD}/start-ide.sh

# Create start-shell.sh
cat >${CWD}/start-shell.sh <<EOF
#!/usr/bin/env sh
set -e

exec docker run --rm -it --mount "type=bind,source=${CWD},destination=/home/nuxeo/workspace/${PROJECT}" --mount "type=bind,source=${HOME}/.m2/repository,destination=/home/nuxeo/.m2/repository" -e "PROJECT=${STUDIO_PROJECT}" -e "USERNAME=${STUDIO_USERNAME}" -e "TOKEN=${STUDIO_TOKEN}"  ${DOCKER_REPOSITORY}/shell-project:latest
EOF
chmod +x ${CWD}/start-shell.sh

# TODO Create start-(ide|shell).cmd scripts too?

# End Message
echo ""
echo ""
echo "🍻 Congrats! Your environment is ready to go."
echo "What to do next?"
echo "  - Start Online IDE: ./start-ide.sh"
echo "  - Start Dev Shell: ./start-shell.sh"
echo "  - Use VS Code Remote-Container extension: ./start-shell.sh then \"Remote-Container: Attach to Running Container\" from VS Code"
echo "  - Use your prefered IDE: open ./pom.xml"
echo ""
