#!/bin/sh

# XXX Questions:
# Do we want to enforce variable values setted from dotenv file? Or do we let already set env variables passing the init?
#  - Current implementation doesn't enforce it, and lets external env variables to be used.

DOTENV=.env.nuxeo-cli

showHelp() {
  echo "Sampled ${DOTENV} file:"
  echo ""
  echo "# NOS - Studio access and package download:"
  echo "# - Documentation: https://doc.nuxeo.com/studio/token-management"
  echo "# - NOS: https://connect.nuxeo.com"
  echo "NOS_USERNAME=nos_username"
  echo "NOS_TOKEN=nos_token"
  echo "NOS_PROJECT=nos_project"
  echo "# Nexus - Maven / NPM:"
  echo "# - Documentation: https://help.sonatype.com/iqserver/automating/rest-apis/user-token-rest-api---v2#UserTokenRESTAPI-v2-CreatingaUserToken"
  echo "# - Nexus: https://packages.nuxeo.com"
  echo "NEXUS_USER_CODE=user_code"
  echo "NEXUS_PASS_CODE=pass_code"
  echo "# Optional(s):"
  echo "# NOS_URL=https://connect.nuxeo.com/nuxeo"
  echo "# GIT_USER_EMAIL=devnull@nuxeo.com"
  echo "# GIT_USER_NAME=username"
  echo ""
  echo "File lookup locations: ${WORKSPACE_PATH}/${DOTENV}, and subfolders."
  echo ""
}

export WORKSPACE_PATH=${HOME}/workspace

# Source as exported dotenv files content within worspace
set -a
DOTENVS=$(find ${WORKSPACE_PATH} -name ${DOTENV} 2>/dev/null)
for FILE in ${DOTENVS}; do
  source ${FILE}
done
set +a

# Ensure required variables are set
REQUIRED_ENV_VARIABLES=(NOS_USERNAME NOS_TOKEN NEXUS_USER_CODE NEXUS_PASS_CODE)
for ENV_VARIABLE in "${REQUIRED_ENV_VARIABLES[@]}"; do
  if ! $(env | grep ${ENV_VARIABLE} &>/dev/null); then
    echo "Error: Missing value for ${ENV_VARIABLE}."
    showHelp
    exit 1
  fi
done

# Enforce optional variables
export NOS_URL=${NOS_URL:-"https://connect.nuxeo.com/nuxeo"}
export GIT_USER_EMAIL=${GIT_USER_EMAIL:-"devnull@nuxeo.com"}
export GIT_USER_NAME=${GIT_USER_NAME:-${NOS_USERNAME}}
