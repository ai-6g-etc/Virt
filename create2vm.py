import subprocess
import time

def create_vm(name, image, iso):
    subprocess.call(['qemu-img', 'create', '-f', 'qcow2', image, '10G'])
    subprocess.call(['qemu-system-x86_64', '-name', name, '-hda', image, '-m', '1G', '-enable-kvm', '-vga', 'std', '-cdrom', iso])

if __name__ == '__main__':
    vm1_image = 'vm1.qcow2'
    vm2_image = 'vm2.qcow2'
    iso_file = 'ubuntu.iso'  # 替换为您的ISO文件路径

    # 创建第一个虚拟机
    create_vm('VM1', vm1_image, iso_file)
    time.sleep(2)

    # 创建第二个虚拟机
    create_vm('VM2', vm2_image, iso_file)
