#!/bin/sh

docker stop jenkins-master
docker rm jenkins-master

docker build . -f Dockerfile.jenkins-master -t nand0p/jenkins-master
docker push nand0p/jenkins-master

docker run -d --privileged=true \
    --net=host \
    --volume /var/jenkins_home:/var/jenkins_home \
    --volume /dev/vboxdrv:/dev/vboxdrv \
    --name jenkins-master nand0p/jenkins-master
