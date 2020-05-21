#!/bin/sh 


docker kill buildbot-hex7-worker 2> /dev/null || true
sleep 2

docker build -t buildbot-hex7-worker -f Dockerfile.worker .
docker run --rm \
           --name buildbot-hex7-worker \
           --network=buildbot \
           --volume /var/run/docker.sock:/var/run/docker.sock \
           -d buildbot-hex7-worker

sleep 5
docker ps
