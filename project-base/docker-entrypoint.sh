#!/bin/sh -e

# Allow child images to add custom entrypoints
for f in /docker-entrypoint-init.d/*; do
  case "$f" in
  *.sh)
    echo "$0: running $f"
    . "$f"
    ;;
  esac
done
