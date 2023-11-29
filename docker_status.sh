#!/bin/bash

# 列出所有网络
echo "网络列表："
docker network ls

# 列出所有镜像
echo "镜像列表："
docker image ls

# 列出所有容器
echo "容器列表："
docker container ls -a
