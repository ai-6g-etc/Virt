#1.sh docker swarm init
#!/bin/bash

sudo docker swarm init
#运行该命令后，会输出一个加入 Swarm 集群的命令，类似于：
#```bash   
docker swarm join --token  : **
#确认节点已成功加入 Swarm 集群：
```bash
docker node ls


#2.sh overlay network for docker
#!/bin/bash

# 创建 overlay 网络
sudo docker network create --driver overlay my-overlay-network

# 创建 web 服务
sudo docker service create --name web --network my-overlay-network --publish 8080:80 nginx

# 创建 db 服务
sudo docker service create --name db --network my-overlay-network --publish 3306:3306 mysql

# 显示 overlay 网络结构
echo "Overlay 网络结构："
sudo docker network inspect my-overlay-network --format='{{range .Containers}}{{.Name}} - {{.IPv4Address}}{{println}}{{end}}'


#=================================以下是LOG===========================================================>
#root@ubuntu:/home/zsw/work/container# sudo docker swarm init
#Swarm initialized: current node (g3bhb6s5rn7zthpj0mon5h3bb) is now a manager.
#
#To add a worker to this swarm, run the following command:
#
#    docker swarm join --token SWMTKN-1-5c9nhlfboyhfx21vnbc19e5qk515b6cba9ufw8kt9b5kuoug2x-7rl1yuca1qe3bbtvfa5qdhn5p 192.168.201.128:2377
#
#To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
#
#root@ubuntu:/home/zsw/work/container# docker swarm join --token SWMTKN-1-5c9nhlfboyhfx21vnbc19e5qk515b6cba9ufw8kt9b5kuoug2x-7rl1yuca1qe3bbtvfa5qdhn5p 192.168.201.128:2377Error response from daemon: This node is already part of a swarm. Use "docker swarm leave" to leave this swarm and join another one.
#root@ubuntu:/home/zsw/work/container# docker swarm join --token SWMTKN-1-5c9nhlfboyhfx21vnbc19e5qk515b6cba9ufw8kt9b5kuoug2x-7rl1yuca1qe3bbtvfa5qdhn5p 192.168.201.128:2377Error response from daemon: This node is already part of a swarm. Use "docker swarm leave" to leave this swarm and join another one.
#root@ubuntu:/home/zsw/work/container# docker node ls
#ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
#g3bhb6s5rn7zthpj0mon5h3bb *   ubuntu     Ready     Active         Leader           20.10.21
#root@ubuntu:/home/zsw/work/container# ./2.sh
#13yye8306c8e3jnhrgjz969d7
#kjkla0ouc9ioje2k36onr77zv
#overall progress: 1 out of 1 tasks 
#1/1: running   [==================================================>] 
#verify: Service converged 
#yf0divecmk51p2i5fkjroh6v7
#overall progress: 0 out of 1 tasks 
#overall progress: 0 out of 1 tasks 
#1/1: ready     [======================================>            ] 
#verify: Detected task failure 
#^COperation continuing in background.
#Use `docker service ps yf0divecmk51p2i5fkjroh6v7` to check progress.
#Overlay 网络结构：
#web.1.c6fxzpt0uqtxwqcgph1by8i60 - 10.0.1.3/24
#my-overlay-network-endpoint - 10.0.1.4/24
