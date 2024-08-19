#!/bin/bash
# 删除container
docker stop test
docker rm test

# 恢复image
TEST_IMAGE=test_jenkins_lts_jdk17
docker image rm ${TEST_IMAGE}
docker load -i ${TEST_IMAGE}.tar
docker load -i alpine.tar

# 恢复volume
docker volume rm test_home
VOLUME_NAME=test_home
BACKUP_DIR=$(pwd)
BACKUP_FILE=${BACKUP_DIR}/${VOLUME_NAME}_backup.tar.gz
echo "Restoring volume ${VOLUME_NAME} from backup..."
docker run --rm -v ${VOLUME_NAME}:/tmp -v ${BACKUP_DIR}:/backup alpine tar xzvf /backup/${VOLUME_NAME}_backup.tar.gz -C /tmp
echo "Volume ${VOLUME_NAME} restored from ${BACKUP_FILE}"

docker run --name test -d -v test_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure ${TEST_IMAGE}:latest

