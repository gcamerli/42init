#!/bin/sh
# ./stop.sh

docker stop -t 1 42init
docker rm 42init
