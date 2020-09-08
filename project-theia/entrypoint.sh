#!/bin/bash -xe

USER_HOME=/home/theia
PROJECT_HOME=/home/project

# Setup current user
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"

# Setup credentials in .git-credentials file
git config --global credential.helper 'store'
CONNECT_PROTOCOL=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $1}')
CONNECT_DOMAIN=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $4}')
echo ${CONNECT_PROTOCOL}://${USERNAME}:${TOKEN}@${CONNECT_DOMAIN} >${USER_HOME}/.git-credentials

# Clone project in coder home dir
git clone ${CONNECT_URL}/git/${PROJECT}.git ${PROJECT_HOME}/${PROJECT}

# Start Code-server
exec yarn theia start ${PROJECT_HOME} --hostname=0.0.0.0 --port 8080
