#!/bin/sh

[[ "$TRACE" ]] && set -x
set -eo pipefail

cd /driver
mkdir -p /var/run/docker/plugins/$DRIVER_NAME || true
exec bundler exec puma --config=puma.rb