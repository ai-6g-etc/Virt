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


#============LOG============》
#网络列表：
#NETWORK ID     NAME      DRIVER    SCOPE
#d39b58627ff5   bridge    bridge    local
#a04e0e0e922b   host      host      local
#3b1ee085f130   none      null      local
#镜像列表：
#REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
#容器列表：
#CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
