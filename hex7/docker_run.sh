#!/bin/sh 

docker network create -d bridge buildbot || true

if [ "$1" == "kill" ]; then
  docker kill buildbot-hex7
  docker container rm buildbot-hex7
  docker kill buildbot-hex7-worker
  docker container rm buildbot-hex7-worker
fi


docker build -t buildbot-hex7 -f Dockerfile.master .
docker run --rm --name buildbot-hex7 --network=buildbot -d -p 9989:9989 -p 8010:8010 buildbot-hex7

sleep 2

docker build -t buildbot-hex7-worker -f Dockerfile.worker .
docker run --rm --name buildbot-hex7-worker --network=buildbot -d buildbot-hex7-worker

sleep 5
docker ps
