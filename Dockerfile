
FROM jenkins/jenkins:lts-jdk17

# 安装系统工具
USER root
RUN apt-get update && apt-get install -y subversion git vim
