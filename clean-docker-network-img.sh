#!/bin/bash
sudo service docker start 


# 停止并删除所有容器
echo "停止并删除所有容器："
sudo docker container stop $(docker container ls -aq)
sudo docker container rm $(docker container ls -aq)

# 删除所有的 Docker 容器
sudo docker rm -f $(sudo docker ps -aq)

# 删除所有的 Docker 镜像
sudo docker rmi -f $(sudo docker images -aq)


# 删除所有网络
docker network rm $(docker network ls -q)

# 删除所有卷
docker volume rm $(docker volume ls -q)

# 删除所有匿名卷
docker volume prune --force

# 删除所有无用的网络
docker network prune --force

# 删除所有无用的镜像
docker image prune --force

# 删除所有无用的容器
docker container prune --force

# 删除所有无用的卷
docker volume prune --force

# 删除所有的 Docker 网络
sudo docker network prune -f

# 获取所有网络的 ID
network_ids=$(docker network ls -q)

# 循环删除每个网络
for network_id in $network_ids; do
    echo "删除网络 $network_id"
    sudo docker network rm $network_id
done

# 获取所有无法删除的网络
networks=$(docker network ls -qf "dangling=true")

# 循环删除每个网络
for network in $networks
do
    docker network rm --force $network
done

# Get a list of all Docker networks
docker_networks=$(docker network ls --format "{{.Name}}")

# Iterate over the Docker networks and delete the ones starting with "docker"
for network in $docker_networks; do
  if [[ $network == docker* ]]; then
    echo "Deleting network: $network"
    docker network rm $network
  fi
done

echo "All Docker networks starting with 'docker' have been deleted."


# 删除以 "docker" 开头的网络
sudo ip link show | awk -F: '/docker/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/docker/ {print $2}' | xargs -I {} sudo ip link delete {}

# 删除以 "br" 开头的网络
sudo ip link show | awk -F: '/br/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/br/ {print $2}' | xargs -I {} sudo brctl delbr {}

# 删除以 "tap" 开头的网络
sudo ip link show | awk -F: '/tap/ {print $2}' | xargs -I {} sudo ip link set {} down
sudo ip link show | awk -F: '/tap/ {print $2}' | xargs -I {} sudo ip tuntap del mode tap dev {}


# Stop Docker services
sudo service docker stop

# Remove Docker services
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io

# Remove Docker configuration files and directories
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo rm -rf /var/run/docker
sudo rm -rf /var/log/docker

# Remove Docker user and group
sudo groupdel docker
sudo userdel -r docker

echo "Docker services have been successfully removed."

sudo service docker stop
sudo killall dockerd
sudo killall containerd
sudo killall runc
sudo killall libnetwork-setkey
sudo rm -rf /var/run/docker
sudo rm -rf /etc/docker
sudo rm -rf /var/log/docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo service docker start
#sudo docker run hello-world
