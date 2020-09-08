#!/bin/bash -xe

USER_HOME=/home/coder
PROJECT_HOME=/home/coder/project

# Setup current user
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"

# Setup credentials in .git-credentials file
git config --global credential.helper 'store'
CONNECT_PROTOCOL=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $1}')
CONNECT_DOMAIN=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $4}')
echo ${CONNECT_PROTOCOL}://${USERNAME}:${TOKEN}@${CONNECT_DOMAIN} > ${USER_HOME}/.git-credentials

# Clone project in coder home dir
git clone ${CONNECT_URL}/git/${PROJECT}.git ${PROJECT_HOME}/${PROJECT}

# No failing if an extension doesn't exist
set +e
# Install extensions
for i in $(echo $EXTENSIONS | sed "s/,/ /g")
do
    # call your procedure/other scripts here below
    code-server --install-extension ${i}
done
set -e

# Start Code-server
exec dumb-init fixuid -q /usr/local/bin/code-server --host 0.0.0.0 --auth none ${PROJECT_HOME}
