#!/bin/bash

echo 'export DIR=`pwd`' >>$BASH_ENV
echo 'export GITHUB_REPO=grafana/grafana' >>$BASH_ENV
echo 'export IMAGE=grafana' >>$BASH_ENV
echo 'export REGISTRY=jessestuart' >>$BASH_ENV
echo 'export QEMU_VERSION=v2.12.0' >>$BASH_ENV
echo 'export VERSION=$(curl -s https://api.github.com/repos/${GITHUB_REPO}/releases/latest | jq -r ".tag_name")' >>$BASH_ENV
echo 'export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"' >>$BASH_ENV

source $BASH_ENV
