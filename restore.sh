#!/bin/bash
ROOT=$(cd `dirname $0`; pwd)

. $ROOT/conf
IMAGE_NAME=${NAME}_img
IMAGE_HOME=${NAME}_home

# 删除container
docker stop test
docker rm test

# 恢复image
docker image rm ${IMAGE_NAME}
docker load -i ${IMAGE_NAME}.tar
docker load -i alpine.tar

# 恢复volume
docker volume rm ${IMAGE_HOME}
echo "Restoring volume ${IMAGE_HOME} from backup..."
docker run --rm -v ${IMAGE_HOME}:/tmp -v ${ROOT}:/backup alpine tar xzvf /backup/${IMAGE_HOME}_backup.tar.gz -C /tmp
echo "Volume ${IMAGE_HOME} restored from ${ROOT}/${IMAGE_HOME}_backup.tar.gz"

docker run --name ${NAME} -d -v ${IMAGE_HOME}:$STORGE_HOME -p 8080:8080 -p 50000:50000 --restart=on-failure ${IMAGE_NAME}:latest

