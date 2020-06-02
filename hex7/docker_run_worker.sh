#!/bin/sh -ex


docker kill buildbot-hex7-worker 2> /dev/null || true
sleep 2

docker build -t buildbot-hex7-worker \
             -f Dockerfile.worker \
	     --build-arg BUILDBOT_WORKER_USER=$(aws ssm get-parameter --name BUILDBOT_WORKER_USER --query Parameter.Value --output text) \
	     --build-arg BUILDBOT_WORKER_PASS=$(aws ssm get-parameter --name BUILDBOT_WORKER_PASS --query Parameter.Value --output text) \
	     --build-arg BUILDBOT_WORKER_HOST=$(aws ssm get-parameter --name BUILDBOT_WORKER_HOST --query Parameter.Value --output text) \
	     .

sleep 2
docker run --rm \
           --name buildbot-hex7-worker \
           --network=buildbot \
           --volume /var/run/docker.sock:/var/run/docker.sock \
           -d buildbot-hex7-worker

sleep 5
docker ps
docker logs buildbot-hex7-worker
echo "docker run --rm --name buildbot-hex7-worker --network=buildbot -ti --volume /var/run/docker.sock:/var/run/docker.sock buildbot-hex7-worker bash"
echo "docker exec -ti buildbot-hex7-worker bash"
