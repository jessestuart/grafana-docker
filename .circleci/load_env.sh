#!/bin/bash

echo '
export DIR=`pwd`
export GITHUB_REPO=grafana/grafana
export IMAGE=grafana
export REGISTRY=jessestuart
export QEMU_VERSION=v4.0.0
# export VERSION=$(curl -s https://api.github.com/repos/${GITHUB_REPO}/releases/latest | jq -r ".tag_name")
export VERSION=$(curl -s https://api.github.com/repos/${GITHUB_REPO}/releases | jq -r "sort_by(.tag_name)[-1].tag_name")
export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"
' >> $BASH_ENV

. $BASH_ENV
