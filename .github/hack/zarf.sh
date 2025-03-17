#!/usr/bin/env bash

set -euo pipefail

export IMAGES=`zarf dev find-images --skip-cosign 2>/dev/null | yq '(del(.components[].images[] | select(test("^127") or test("\*$"))) | .components[].images | select(. | length > 0)) // []'`

yq -i '.components[0].images= (env(IMAGES) | sort | unique)' zarf.yaml

unset IMAGES
