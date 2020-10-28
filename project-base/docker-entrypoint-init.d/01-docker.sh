#!/bin/sh
# If Docker socket mounted, fix permissions on it

if [[ -e /var/run/docker.sock ]]; then
  sudo chmod 666 /var/run/docker.sock
fi
