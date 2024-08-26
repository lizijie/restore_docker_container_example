
#!/bin/sh
ROOT=$(cd `dirname $0` ; pwd)

. ${ROOT}/conf
IMAGE_NAME=${NAME}_img
IMAGE_HOME=${NAME}_home

docker stop ${NAME}

# backup volume
rm -f ${ROOT}/${IMAGE_HOME}_backup.tar.gz
echo "Creating backup of volume ${IMAGE_HOME}..."
docker run --rm -v ${IMAGE_HOME}:/tmp -v ${ROOT}:/backup alpine tar czvf /backup/${IMAGE_HOME}_backup.tar.gz -C /tmp .
echo "Backup created at ${ROOT}/${IMAGE_HOME}_backup.tar.gz"

# backup alpine
ALPINE_TAR=${ROOT}/alpine.tar
rm -rf ${ALPINE_TAR}
docker save -o ${ALPINE_TAR} alpine:latest

# backup
TEST_TAR=${ROOT}/${IMAGE_NAME}.tar
rm -rf ${TEST_TAR}
docker save -o ${TEST_TAR} ${IMAGE_NAME}:latest