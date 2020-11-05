#!/bin/sh -e

B64_AUTH=$(echo -n "${NEXUS_USER_CODE}:${NEXUS_PASS_CODE}" | base64)

cat >${HOME}/.npmrc <<EOF
@nuxeo-internal:registry=https://packages.nuxeo.com/repository/npm-internal/
//packages.nuxeo.com/repository/npm-internal/:_auth=${B64_AUTH}:always-auth=true:email=${GIT_USER_EMAIL}
@nuxeo:registry=https://packages.nuxeo.com/repository/npm-all/
//packages.nuxeo.com/repository/npm-all/:_auth=${B64_AUTH}:always-auth=true:email=${GIT_USER_EMAIL}
EOF
