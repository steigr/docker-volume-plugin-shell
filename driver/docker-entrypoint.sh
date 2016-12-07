#!/bin/sh

[[ "$TRACE" ]] && set -x
set -eo pipefail

cd /driver
mkdir -p /var/run/docker/plugins/$DRIVER_NAME || true
[[ -d $MOUNTS ]] || mkdir -p $MOUNTS
mount --make-rshared $MOUNTS
exec bundler exec puma --config=puma.rb