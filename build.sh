#!/bin/sh

VERSION=$1
_grafana_target=$2

echo "target: $_grafana_target"

case "$2" in
  arm)
    _grafana_target=armv7
    ;;
  arm64)
    _grafana_target=arm64
    ;;
  *)
    _grafana_target=amd64
    ;;
esac

if ! [ $_grafana_target == 'amd64' ]; then
  curl -sL "https://github.com/multiarch/qemu-user-static/releases/download/${QEMU_VERSION}/qemu-${QEMU_ARCH}-static.tar.gz" | tar xz
  docker run --rm --privileged multiarch/qemu-user-static:register
fi

# If the tag starts with v, treat this as a official release
if echo "$VERSION" | grep -q "^v"; then
  _grafana_version=$(echo "${VERSION}" | cut -d "v" -f 2)
else
  _grafana_version=${VERSION}
fi
_grafana_url="https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${_grafana_version}.linux-${_grafana_target}.tar.gz"
_docker_repo=${2:-jessestuart/grafana}
# else
#   _grafana_url="https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana-${_grafana_version}.linux-${_grafana_target}.tar.gz"
#   _docker_repo=${2:-jessestuart/grafana-dev}
# fi

echo "Building ${_docker_repo}:${_grafana_version} from ${_grafana_url}"

docker build \
  --build-arg GRAFANA_URL="${_grafana_url}" \
  --build-arg TARGET=${TARGET} \
  --tag ${IMAGE_ID} \
  .

# Tag as 'latest' for official release; otherwise tag as grafana/grafana:master
# if echo "$VERSION" | grep -q "^v"; then
#   docker tag "${_docker_repo}:${_grafana_version}" "${_docker_repo}:latest"
# else
#   docker tag "${_docker_repo}:${_grafana_version}" "grafana/grafana:master"
# fi
