#!/bin/bash

export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"

cd $GOPATH/src/github.com/${GITHUB_REPO}
# ============
# <qemu-support>
if [ $GOARCH == 'amd64' ]; then
  touch qemu-amd64-static
else
  curl -sL "https://github.com/multiarch/qemu-user-static/releases/download/${QEMU_VERSION}/qemu-${QEMU_ARCH}-static.tar.gz" | tar xz
  docker run --rm --privileged multiarch/qemu-user-static:register
fi
# </qemu-support>
# ============

# Replace the repo's Dockerfile with our own.
cp -f $DIR/Dockerfile .
docker build -t ${IMAGE_ID} \
  --build-arg target=$TARGET \
  --build-arg arch=$QEMU_ARCH \
  --build-arg goarch=$GOARCH \
  --build-arg image=${GITHUB_REPO} .

# Login to Docker Hub.
echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
# Push push push
docker push ${IMAGE_ID}
if [ $CIRCLE_BRANCH == 'master' ]; then
  docker tag "${IMAGE_ID}" "${REGISTRY}/${IMAGE}:latest-${TAG}"
  docker push "${REGISTRY}/${IMAGE}:latest-${TAG}"
fi
