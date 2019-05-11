#!/usr/bin/bash

echo 'INSTALLING AND UPDATING APPS // YUM ...'

sudo yum -y update && sudo yum -y upgrade
sudo yum -y install ansible python python-devel epel-release python-pip vim gcc git python-netaddr wget tcpdump curl vconfig telnet wireshark-gnome wireshark
sudo yum -y group install "Development Tools"

echo 'INSTALLING AND UPDATING APPS // PIP ...'

sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install --upgrade lxml
sudo pip install -r requirements.txt

echo 'INSTALLING AND UPDATING APPS // VIRTUAL BOX ...'

sudo yum -y install kernel-devel kernel-headers make patch
sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
sudo yum -y install VirtualBox-5.2
echo '=============================================================================================' > installation.log
echo 'systemctl status vboxdrv' >> installation.log
sudo systemctl status vboxdrv >> installation.log
echo '=============================================================================================' >> installation.log

echo 'INSTALLING AND UPDATING APPS // VIRTUAL BOX ...'

sudo wget https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.rpm
sudo yum -y localinstall vagrant_2.2.4_x86_64.rpm 
echo 'vagrant --version'
vagrant --version >> installation.log
echo '=============================================================================================' >> installation.log

echo 'WATCHING LOGS ...'
cat installation.log

echo 'CLEARING TEMPs ...'
sudo rm installation.log
sudo rm vagrant_2.2.4_x86_64.rpm 
