#!/bin/bash -e


docker stop jenkins-blueocean || true
docker rm jenkins-blueocean || true

docker build docker_jenkins-blueocean -t nand0p/jenkins-blueocean
#docker push nand0p/jenkins-blueocean

docker run -d --privileged=true \
    --net=host \
    #--volume /var/jenkins_home:/var/jenkins_home \
    --volume /dev/vboxdrv:/dev/vboxdrv \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --name jenkins-blueocean nand0p/jenkins-blueocean
