#!/bin/sh
ROOT=$(cd `dirname $0`; pwd)

. $ROOT/conf
IMAGE_NAME=${NAME}_img
IMAGE_HOME=${NAME}_home

docker stop ${NAME}
docker rm ${NAME}

docker image rm ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

docker run -d --name ${NAME} -v ${IMAGE_HOME}:${STORGE_HOME} -p 8080:8080 -p 50000:50000 --restart=on-failure ${IMAGE_NAME}