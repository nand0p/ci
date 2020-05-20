#!/bin/bash

docker stop buildbot-worker
docker rm buildbot-worker

docker run -d -t -i --net="host" --name buildbot-worker \
    -e BUILDMASTER='localhost' \
    -e BUILDMASTER_PORT='9989' \
    -e WORKERNAME='example-worker' \
    -e WORKERPASS='pass' \
    -e WORKER_ENVIRONMENT_BLACKLIST='' \
    buildbot/buildbot-worker:master

