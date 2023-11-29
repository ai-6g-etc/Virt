#!/bin/bash

# 创建一个桥接网络
sudo brctl addbr br0
sudo ip addr add 192.168.0.1/24 dev br0
sudo ip link set dev br0 up

# 创建容器，并将其连接到桥接网络
sudo docker run -d --name mycontainer --network=bridge ubuntu:latest
