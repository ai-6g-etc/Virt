#!/bin/bash

# 停止并删除所有容器
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
# 删除所有的 Docker 容器
sudo docker rm -f $(sudo docker ps -aq)

# 删除所有的 Docker 镜像
sudo docker rmi -f $(sudo docker images -aq)

# 删除所有的 Docker 网络
sudo docker network prune -f

# 获取所有无法删除的网络
networks=$(docker network ls -qf "dangling=true")

# 循环删除每个网络
for network in $networks
do
    docker network rm $network
done


# 删除以 "docker" 开头的网络
sudo ip link show | awk -F: '/docker/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/docker/ {print $2}' | xargs -I {} sudo ip link delete {}

# 删除以 "br" 开头的网络
sudo ip link show | awk -F: '/br/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/br/ {print $2}' | xargs -I {} sudo brctl delbr {}

# 删除以 "tap" 开头的网络
sudo ip link show | awk -F: '/tap/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/tap/ {print $2}' | xargs -I {} sudo ip tuntap del mode tap dev {}
