#!/bin/bash -e


docker stop jenkins-centos || true
docker rm jenkins-centos || true

docker build docker_jenkins-centos -t nand0p/jenkins-centos
docker push nand0p/jenkins-centos

docker run -d --privileged=true \
    --net=host \
    --volume /dev/vboxdrv:/dev/vboxdrv \
    --volume /var/lib/jenkins:/var/lib/jenkins \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --name jenkins-centos nand0p/jenkins-centos
