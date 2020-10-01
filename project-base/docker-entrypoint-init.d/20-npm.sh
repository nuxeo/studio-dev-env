#!/bin/sh -e

add_registry() {
  expect <<EOF
spawn npm adduser --registry ${1}
expect {
  "Username:" {send -- "${NEXUS_USER_CODE}\r"; exp_continue}
  "Password:" {send -- "${NEXUS_PASS_CODE}\r"; exp_continue}
  "Email: (this IS public)" {send -- "${GIT_USER_EMAIL}\r"; exp_continue}
  "Logged in as ${NEXUS_USER_CODE} on ${1}.
}
EOF
}

add_registry "https://packages.nuxeo.com/repository/npm-internal/"
add_registry "https://packages.nuxeo.com/repository/npm-all/"
