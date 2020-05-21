#!/bin/bash -ex

docker network create -d bridge buildbot 2> /dev/null || true
docker container rm buildbot-hex7 2> /dev/null || true
docker kill buildbot-hex7 2> /dev/null || true

docker build -t buildbot-hex7 -f Dockerfile.master .

if [ "$1" == "console" ]; then
  echo "docker run --rm --name buildbot-hex7 --network=buildbot -ti -p 9989:9989 -p 8010:8010 buildbot-hex7 bash"
else
  docker run --rm --name buildbot-hex7 --network=buildbot -d -p 9989:9989 -p 8010:8010 buildbot-hex7
  sleep 5
  docker ps
fi

