#!/bin/bash

docker stop buildbot-master
docker rm buildbot-master

rm -fv buildbot-config.tar.gz
tar cfvz buildbot-config.tar.gz buildbot-config

aws --profile hex7 s3 cp buildbot-config.tar.gz s3://buildbot-master/buildbot-config.tar.gz
aws --profile hex7 s3api put-object-acl --bucket buildbot-master --key buildbot-config.tar.gz --acl public-read

docker build . -f Dockerfile.buildbot-master -t nand0p/buildbot-master
docker push nand0p/buildbot-master

docker run -d --net="host" --name buildbot-master \
    -e BUILDBOT_CONFIG_URL="https://buildbot-master.s3.amazonaws.com/buildbot-config.tar.gz" \
    -e BUILDBOT_CONFIG_DIR="/var/lib/buildbot" \
    nand0p/buildbot-master
    

# http://localhost:9999/buildbot-config.tar.gz
# https://buildbot-master.s3.amazonaws.com/buildbot-config.tar.gz
