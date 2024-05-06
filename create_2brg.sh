
#!/bin/bash

# 创建两个bridge
brctl addbr br1
brctl addbr br2

# 启用bridge
ip link set br1 up
ip link set br2 up

# 创建两个tap设备
ip tuntap add tap1 mode tap
ip tuntap add tap2 mode tap

# 将tap设备添加到bridge
brctl addif br1 tap1
brctl addif br2 tap2

# 设置tap设备的IP地址
ip addr add 192.168.1.1/24 dev tap1
ip addr add 192.168.2.1/24 dev tap2
ip link set tap1 up
ip link set tap2 up

# 启用IP转发
sysctl -w net.ipv4.ip_forward=1

# 添加路由规则
ip route add 192.168.2.0/24 via 192.168.1.1 dev tap1
ip route add 192.168.1.0/24 via 192.168.2.1 dev tap2

# 禁用防火墙
ufw disable

# 在tap设备上禁用STP（Spanning Tree Protocol）
brctl stp br1 off
brctl stp br2 off

# 在tap设备上禁用IPv6
sysctl -w net.ipv6.conf.tap1.disable_ipv6=1
sysctl -w net.ipv6.conf.tap2.disable_ipv6=1

# 使得两个tap能够互相ping通
ping -c 4 192.168.2.1
