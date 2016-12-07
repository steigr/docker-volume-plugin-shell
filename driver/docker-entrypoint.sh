#!/bin/sh

if [[ -z $HAS_TINI ]]; then
  HAS_TINI=1 TINI_SUBREAPER=1 exec tini -- "$0" "$@"
fi
unset HAS_TINI

[[ "$TRACE" ]] && set -x
set -eo pipefail

cd /driver
mkdir -p /var/run/docker/plugins/$DRIVER_NAME || true
[[ -d $MOUNTS ]] || mkdir -p $MOUNTS
mount --make-rshared $MOUNTS
exec bundler exec puma --config=puma.rb