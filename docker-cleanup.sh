#!/bin/bash

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock spotify/docker-gc

