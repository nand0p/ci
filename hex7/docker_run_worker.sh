#!/bin/sh 


if [ "$1" == "kill" ]; then
  docker kill buildbot-hex7-worker
fi


docker build -t buildbot-hex7-worker -f Dockerfile.worker .
docker run --rm \
           --name buildbot-hex7-worker \
           --network=buildbot \
           --volume /var/run/docker.sock:/var/run/docker.sock \
           -d buildbot-hex7-worker

sleep 5
docker ps
