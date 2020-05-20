#!/bin/sh 

docker network create -d bridge buildbot || true

if [ "$1" == "kill" ]; then
  docker kill buildbot-hex7
fi


docker build -t buildbot-hex7 -f Dockerfile.master .
docker run --rm --name buildbot-hex7 --network=buildbot -d -p 9989:9989 -p 8010:8010 buildbot-hex7

sleep 5
docker ps
