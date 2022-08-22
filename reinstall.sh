#!/bin/bash

docker plugin disable mrtc0/docker-request-logger
docker plugin rm mrtc0/docker-request-logger

make clean && make build && make plugin/create && make plugin/enable

sudo systemctl restart docker
