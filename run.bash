#!/usr/bin/env bash

set -euo pipefail

dir="$(dirname "$0")"

exec nix-instantiate --argstr minVersion "$1" --json --eval "$dir/versions.nix" \
    | jq -c '.[]' \
    | sort -d -r | \
    while read name
    do
        nix run "github:akirak/makem.nix#compile-$name" -- -s
    done
