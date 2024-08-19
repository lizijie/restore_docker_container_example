
#!/bin/bash
export ROOT=$(cd `dirname $0` ; pwd)

docker stop test

# backup volume
VOLUME_NAME=test_home
BACKUP_DIR=$(pwd)
TAR_VOLUME=${ROOT}/${VOLUME_NAME}_backup.tar.gz
rm -f ${TAR_VOLUME}
echo "Creating backup of volume ${VOLUME_NAME}..."
docker run --rm -v ${VOLUME_NAME}:/tmp -v ${BACKUP_DIR}:/backup alpine tar czvf /backup/${VOLUME_NAME}_backup.tar.gz -C /tmp .
echo "Backup created at ${TAR_VOLUME}"

# backup alpine
ALPINE_TAR=${ROOT}/alpine.tar
rm -rf ${ALPINE_TAR}
docker save -o ${ALPINE_TAR} alpine:latest

# backup test
TEST_IMAGE=test_jenkins_lts_jdk17
TEST_TAR=${ROOT}/${TEST_IMAGE}.tar
rm -rf ${TEST_TAR}
docker save -o ${TEST_TAR} ${TEST_IMAGE}:latest


