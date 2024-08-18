
FROM jenkins/jenkins:lts-jdk17

# 安装系统工具
USER root
RUN apt-get update
RUN apt-get install -y subversion git

