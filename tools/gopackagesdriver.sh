#!/bin/bash

bazel="$(git rev-parse --show-toplevel)/bazel.sh"

export GOPACKAGESDRIVER_BAZEL="$bazel"
#export GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS='--remote_download_regex=.*/external/io_bazel_rules_go/stdlib_/gocache/.*'

# exec "$bazel" run -- @io_bazel_rules_go//go/tools/gopackagesdriver "${@}"

exec "$bazel" run --tool_tag=gopackagesdriver -- //go/tools/gopackagesdriver "${@}"
