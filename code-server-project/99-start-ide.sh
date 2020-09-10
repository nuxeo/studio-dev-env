#!/bin/bash -xe

# No failing if an extension doesn't exist
set +e
# Install extensions
for i in $(echo $EXTENSIONS | sed "s/,/ /g"); do
  # call your procedure/other scripts here below
  code-server --install-extension ${i}
done
set -e

if [ -z $@ ]; then
  # Start Code-server
  exec dumb-init fixuid -q /usr/local/bin/code-server --host 0.0.0.0 --auth none ${PROJECT_HOME}
else
  exec $@
fi
