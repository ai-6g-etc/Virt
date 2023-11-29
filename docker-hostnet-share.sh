#!/bin/bash

# 创建并运行容器，使用主机网络
sudo docker run -d --name my-container --network host nginx

# 检查容器的网络配置
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-container
