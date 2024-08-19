#!/bin/bash

docker stop test
docker rm test 

TEST_IMAGE=test_jenkins_lts_jdk17:latest
docker image rm ${TEST_IMAGE} 
docker build -t ${TEST_IMAGE} .

docker run -d --name test -v test_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure $TEST_IMAGE
