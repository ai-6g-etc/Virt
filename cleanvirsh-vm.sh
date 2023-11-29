#!/bin/bash

# 停止并删除所有虚拟机
virsh list --all --name | while read -r vm; do
    virsh shutdown "$vm"
    virsh undefine "$vm"
done

# 删除虚拟机磁盘镜像文件
rm -rf /var/lib/libvirt/images/*.qcow2

# 停止并删除所有网络
virsh net-list --name | while read -r network; do
    virsh net-destroy "$network"
    virsh net-undefine "$network"
done

# 删除网络配置文件
rm -rf /etc/libvirt/qemu/networks/*.xml
rm -rf /etc/libvirt/qemu/networks/autostart/*.xml

echo "所有虚拟机和网络已成功清除。"
