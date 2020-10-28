#!/bin/bash -xe

if [ -z ${NOS_PROJECT} ]; then
  # No Studio project configured; skip
  return 0
fi

if [[ -e ${WORKSPACE_PATH}/${NOS_PROJECT} ]]; then
  # Folder already exists
  rm -rf ${WORKSPACE_PATH}/${NOS_PROJECT}
fi

# Clone project in coder home dir
git clone ${NOS_URL}/git/${NOS_PROJECT}.git ${WORKSPACE_PATH}/${NOS_PROJECT}
