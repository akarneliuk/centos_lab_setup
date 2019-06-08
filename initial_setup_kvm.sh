#!/usr/bin/bash

echo 'INSTALLING AND UPDATING APPS // YUM ...'

sudo yum -y update && sudo yum -y upgrade
sudo yum --enablerepo=extras install -y epel-release
sudo yum -y install ansible python python-devel python-pip vim gcc git python-netaddr wget tcpdump curl vconfig telnet wireshark-gnome wireshark
sudo yum -y group install "Development Tools"

echo 'INSTALLING AND UPDATING APPS // PIP ...'

sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install --upgrade lxml
sudo pip install -r requirements.txt

echo 'INSTALLING AND UPDATING APPS // KVM ...'

sudo yum -y install qemu-kvm qemu-img virt-manager libvirt libvirt-python libvirt-client virt-install virt-viewer libvirt-devel ruby-devel

echo 'INSTALLING AND UPDATING APPS // DOCKER ...'

sudo yum -y install sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io


echo 'INSTALLING AND UPDATING APPS // POSTMAN ...'

sudo mkdir /opt
cd /opt
sudo wget -O postman.tar.gz https://dl.pstmn.io/download/latest/linux64
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
cd ~

echo 'INSTALLING AND UPDATING APPS // VAGRANT ...'

sudo wget https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
sudo yum -y localinstall vagrant_2.2.4_x86_64.rpm
echo '=============================================================================================' > installation.log
echo 'vagrant --version'
vagrant --version >> installation.log
# Details how to add libvirt provider `https://github.com/vagrant-libvirt/vagrant-libvirt`
vagrant plugin install vagrant-libvirt
echo 'vagrant plugin list'
vagrant plugin list >> installation.log
echo '=============================================================================================' >> installation.log

echo 'CREATING BRIDGE FOR OOB ...'
echo 'DEVICE=br0' > ifcfg-br0
echo 'TYPE=Bridge' >> ifcfg-br0
echo 'BOOTPROTO=none' >> ifcfg-br0
echo 'ONBOOT=yes' >> ifcfg-br0
echo 'IPADDR=192.168.1.1' >> ifcfg-br0
echo 'PREFIX=24' >> ifcfg-br0
echo 'DELAY=0' >> ifcfg-br0
echo 'IPV6INIT=yes' >> ifcfg-br0
echo 'IPV6FORWARDING=yes' >> ifcfg-br0
echo 'IPV6_AUTOCONF=no' >> ifcfg-br0
echo 'IPV6_FAILURE_FATAL=no' >> ifcfg-br0
echo 'ZONE=public' >> ifcfg-br0
echo 'IPV6ADDR=fc00:de:1:ffff::1/64' >> ifcfg-br0
sudo mv ifcfg-br0 /etc/sysconfig/network-scripts/
sudo systemctl restart network
echo '=============================================================================================' >> installation.log
echo 'ip addr show dev br0'
ip addr show dev br0 >> installation.log
echo '=============================================================================================' >> installation.log

echo 'WATCHING LOGS ...'
cat installation.log

echo 'CLEARING TEMPs ...'
sudo rm installation.log
sudo rm vagrant_2.2.4_x86_64.rpm 
