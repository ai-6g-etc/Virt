#!/bin/bash

# 定义虚拟机定义文件的路径
vm1_xml="/etc/libvirt/qemu/vm1.xml"
vm2_xml="/etc/libvirt/qemu/vm2.xml"
network_xml="/etc/libvirt/qemu/vmx-network.xml"

# 创建虚拟网络定义文件
cat > $network_xml <<EOF
<network>
  <name>vmx-network</name>
  <forward mode="nat"/>
  <bridge name="virbr0" stp="on" delay="0"/>
  <ip address="192.168.123.1" netmask="255.255.255.0">
    <dhcp>
      <range start="192.168.123.2" end="192.168.123.254"/>
    </dhcp>
  </ip>
</network>
EOF

# 定义虚拟网络
virsh net-define $network_xml

# 启动虚拟网络
virsh net-start vmx-network

# 创建虚拟机1的定义文件
cat > $vm1_xml <<EOF
<domain type='kvm'>
  <name>vm1</name>
  <memory unit='KiB'>1048576</memory>
  <vcpu placement='static'>1</vcpu>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.9'>hvm</type>
    <boot dev='hd'/>
  </os>
  <devices>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/home/zsw/work/vm/vm1.qcow2'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </disk>
    <interface type='network'>
      <mac address='52:54:00:11:11:11'/>
      <source network='vmx-network'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </interface>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <graphics type='vnc' port='-1' autoport='yes' listen='0.0.0.0'/>
  </devices>
</domain>
EOF

# 创建虚拟机2的定义文件
cat > $vm2_xml <<EOF
<domain type='kvm'>
  <name>vm2</name>
  <memory unit='KiB'>1048576</memory>
  <vcpu placement='static'>1</vcpu>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.9'>hvm</type>
    <boot dev='hd'/>
  </os>
  <devices>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/home/zsw/work/vm/vm2.qcow2'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </disk>
    <interface type='network'>
      <mac address='52:54:00:22:22:22'/>
      <source network='vmx-network'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </interface>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <graphics type='vnc' port='-1' autoport='yes' listen='0.0.0.0'/>
  </devices>
</domain>
EOF

# 定义虚拟机1
virsh define $vm1_xml

# 启动虚拟机1
virsh start vm1

# 定义虚拟机2
virsh define $vm2_xml

# 启动虚拟机2
virsh start vm2

