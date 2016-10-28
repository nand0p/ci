#!/bin/sh

docker stop gitlab
docker rm gitlab

docker build . -f Dockerfile.gitlab -t nand0p/gitlab
docker push nand0p/gitlab

docker run -d -v /etc/gitlab:/etc/gitlab -v /var/opt/gitlab:/var/opt/gitlab \
	   -p 9991:22 -p 9992:80 -p 9993:443 --name gitlab nand0p/gitlab
