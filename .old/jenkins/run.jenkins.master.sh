#!/bin/bash -e


docker stop jenkins-master || true
docker rm jenkins-master || true

docker build docker_jenkins-master -t nand0p/jenkins-master
docker push nand0p/jenkins-master

docker run -d --privileged=true \
    --net=host \
    --volume /var/jenkins_home:/var/jenkins_home \
    --volume /dev/vboxdrv:/dev/vboxdrv \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --name jenkins-master nand0p/jenkins-master
