#!/bin/sh -ex

docker network create -d bridge buildbot 2> /dev/null || true
docker container rm buildbot-hex7 2> /dev/null || true
docker kill buildbot-hex7 2> /dev/null || true

sleep 2
docker build -t buildbot-hex7 \
             -f Dockerfile.master \
	     --build-arg AWS_ACCESS_KEY_ID=$AWS_READONLY_ID \
	     --build-arg AWS_SECRET_ACCESS_KEY=$AWS_READONLY_KEY \
	     .

sleep 2
docker run --rm \
	   --name buildbot-hex7 \
	   --network=buildbot \
	   -d \
	   -p 9989:9989 \
	   -p 8010:8010 \
	   -v /var/run/mysqld/mysqld.sock:/var/run/mysqld/mysqld.sock \
	   buildbot-hex7
sleep 5
docker ps
echo "docker run --rm --name buildbot-hex7 --network=buildbot -ti -p 9989:9989 -p 8010:8010 buildbot-hex7 bash"
echo "docker exec -ti buildbot-hex7 bash"
docker logs buildbot-hex7
