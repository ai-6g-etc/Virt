#以下有待整理，暂时记录在这里
set -eo pipefail
kubeadm reset -f
df -h|grep kubelet |awk -F % '{print $2}'|xargs umount
sudo docker rm -f $(sudo docker ps -qa)
for m in $(sudo tac /proc/mounts | sudo awk '{print $2}'|sudo grep /var/lib/kubelet);do
sudo umount $m||true
done
docker stop $(docker ps -aq)
docker system prune -f
docker volume rm $(docker volume ls -q)
docker rmi $(docker image ls -q)
for mount in $(mount | grep tmpfs | grep '/var/lib/kubelet' | awk '{ print $3 }') /var/lib/kubelet /var/lib/rancher; do umount $mount; done
ip link set docker0 down
ip link delete docker0
ifconfig cni0 down && ip link delete cni0
ifconfig flannel.1 down && ip link delete flannel.1
for m in $(sudo tac /proc/mounts | sudo awk '{print $2}'|sudo grep /var/lib/rancher);do

sudo docker volume rm $(sudo docker volume ls -q)
sudo docker ps -a
docker stop $(docker ps -q) & docker rm -f $(docker ps -aq)
docker rmi $(docker images -q)
# 杀死所有 Docker 进程
sudo docker kill $(docker ps -q)
# 删除所有 Docker 容器
sudo docker rm $(docker ps -a -q)
# 删除所有 Docker 镜像
sudo docker rmi $(docker images -q)
# 杀死所有 Kubernetes 进程
sudo systemctl stop kubelet
sudo systemctl stop kube-proxy
sudo systemctl stop kube-controller-manager
sudo systemctl stop kube-scheduler
sudo systemctl stop kube-apiserver
 # 删除所有 Kubernetes 相关服务
sudo systemctl disable kubelet
sudo systemctl disable kube-proxy
sudo systemctl disable kube-controller-manager
sudo systemctl disable kube-scheduler
sudo systemctl disable kube-apiserver

iptables -F && iptables -t nat -F
ip link del flannel.1
docker ps -a|awk '{print $1}'|xargs docker rm -f
docker volume ls|awk '{print $2}'|xargs docker volume rm


kill -9 $(lsof -ti :6443)
kill -9 $(lsof -ti :10259)
kill -9 $(lsof -ti :10257)
kill -9 $(lsof -ti :10250)
kill -9 $(lsof -ti :2379)
kill -9 $(lsof -ti :2380)
ps -ef | grep k8s | grep -v grep | awk '{print $2}' | xargs kill -9
# 杀死 Kubernetes 的进程
ps -ef | grep kube | grep -v grep | awk '{print $2}' | xargs kill -9
# 杀死 Docker 的进程
ps -ef | grep docker | grep -v grep | awk '{print $2}' | xargs kill -9
ip link set dev br-1751ba8b4069 down
ip link set dev br-45f07ab1dfc6 down
ip link set dev br-81c05491c741 down
ip link set dev br-8cf59e54a08e down
ip link set dev br-ba89f1897e2a down
ip link set dev br-c1423d5ab35d down
ip link set dev br-f45ca292fdcf down
brctl delbr br-1751ba8b4069
brctl delbr br-45f07ab1dfc6
brctl delbr br-81c05491c741
brctl delbr br-8cf59e54a08e
brctl delbr br-ba89f1897e2a
brctl delbr br-c1423d5ab35d
brctl delbr br-f45ca292fdcf


#删除所有容器
#删除/var/lib/kubelet/目录，删除前先卸载
#删除/var/lib/rancher/目录，删除前先卸载
#删除/run/kubernetes/ 目录
#删除所有的数据卷
#再次显示所有的容器和数据卷，确保没有残留

sudo rm -rf /var/lib/kubelet/
sudo rm -rf /var/lib/rancher/
sudo rm -rf /run/kubernetes/
rm /var/lib/kubelet/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/rancher/* -rf
rm /var/lib/etcd/* -rf
rm /var/lib/kubelet/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/rancher/* -rf
rm /var/lib/cni/* -rf

rm -rf /docker_volume/rancher_home/rancher
rm -rf /docker_volume/rancher_home/auditlog

#删除/var/etcd目录
rm /var/lib/cni/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/cni/* -rf
sudo rm -rf /var/etcd
rm -rf /etc/etcd/*
rm -rf /etc/kubernetes/*
rm -rf /usr/local/bin/etcdctl
rm -rf /etc/ssl/etcd
rm -rf /var/lib/etcd
rm -rf /etc/etcd.env
rm /var/lib/etcd/* -rf
rm /var/lib/etcd/* -rf
rm -rf /etc/cni/net.d
rm -rf ~/.kube/config
rm /var/lib/kubelet/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/rancher/* -rf
rm /var/lib/etcd/* -rf
rm /var/lib/kubelet/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/rancher/* -rf
rm /var/lib/cni/* -rf
rm /var/lib/cni/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/cni/* -rf
rm /var/lib/etcd/* -rf
rm /var/lib/etcd/* -rf
rm -rf /etc/ceph \
/etc/cni \
/etc/kubernetes \
/opt/cni \
/opt/rke \
/opt/containerd \
/run/secrets/kubernetes.io \
/run/calico \
/run/flannel \
/var/lib/calico \
/var/lib/etcd \
/var/lib/cni \
/var/lib/kubelet \
/var/lib/rancher/rke/log \
/var/log/containers \
/var/log/pods \
/var/run/calico

rm -rf /var/lib/cni/
docker rm -f $(docker ps -qa)
cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico"
for dir in $cleanupdirs; do
echo "Removing $dir"
rm -rf $dir


rm /var/lib/kubelet/* -rf
rm /etc/kubernetes/* -rf
rm /var/lib/rancher/* -rf
rm /var/lib/etcd/* -rf
rm /var/lib/cni/* -rf

 # 删除所有相关文件
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/etcd
rm -rf /etc/containerd/config.toml

rm /var/lib/kubelet/kubeadm-flags.env -rf
rm /var/lib/kubelet/config.yaml -rf
rm /etc/kubernetes/manifests -rf
rm /etc/kubernetes/pki -rf
rm /etc/kubernetes -rf
sudo apt remove kubelet kubeadm kubectl -y

