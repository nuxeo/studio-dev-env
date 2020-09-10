#!/bin/sh -e

# Setup current user
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"

# Setup credentials in .git-credentials file
git config --global credential.helper 'store'
CONNECT_PROTOCOL=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $1}')
CONNECT_DOMAIN=$(echo "${CONNECT_URL}" | awk -F[/:] '{print $4}')
echo ${CONNECT_PROTOCOL}://${USERNAME}:${TOKEN}@${CONNECT_DOMAIN} >${HOME}/.git-credentials
