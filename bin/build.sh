#!/usr/bin/env sh

set -e

bin="`dirname "$0"`"
root="$bin/.."

name="`basename "$(realpath "$root")"`"
user="${FLUX_PUBLISH_DOCKER_USER:=fluxfw}"
image="$user/$name"

for nodejs_version in 10 12 14; do
    docker build "$root" --pull --build-arg NODEJS_VERSION=$nodejs_version -t "$image:nodejs$nodejs_version"
done
docker tag "$image:nodejs10" "$image:latest"
