#!/bin/bash

set -e

uname=$(uname -m)
if [ "$uname" == "x86_64" ]; then
  ARCH=amd64
elif [ "$uname" == "arm" ]; then
  ARCH=arm64
elif [ "$uname" == "arm64" ]; then
  ARCH=arm64
elif [ "$uname" == "aarch64" ]; then
  ARCH=arm64
else
  echo "Unsupported architecture: $uname"
  exit 1
fi

bazelisk="$(git rev-parse --show-toplevel)/tools/bazelisk/bazelisk-darwin-$ARCH"

buildout=/tmp/build_output

export BAZELISK_HOME=$buildout/bazelisk
export GOPATH=$buildout/go
export GOCACHE=$buildout/.gocache

mkdir -p "${GOPATH}" "${GOCACHE}"

$bazelisk "${opts[@]}" "$@"

