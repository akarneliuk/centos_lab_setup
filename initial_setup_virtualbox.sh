#!/usr/bin/bash

# Released on 08-09-2019

CURRENT_PATH=$PWD

echo 'INSTALLING AND UPDATING APPS // YUM ...'

sudo yum -y update && sudo yum -y upgrade
sudo yum --enablerepo=extras install -y epel-release
sudo yum -y install ansible python python-devel python-pip vim gcc git python-netaddr wget tcpdump curl vconfig telnet wireshark-gnome wireshark
sudo yum -y group install "Development Tools"

echo 'INSTALLING AND UPDATING APPS // PIP2 ...'

sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install --upgrade lxml
sudo pip install -r requirements.txt

echo 'INSTALLING AND UPDATING APPS // Python 3.7 ...'

sudo yum -y install openssl-devel libffi-devel zlib-devel
cd /opt
sudo wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
sudo taf -xzf Python-3.7.3.tgz
cd Python-3.7.3
sudo ./configure
sudo make
sudo make altinstall
cd $CURRENT_PATH

echo 'INSTALLING AND UPDATING APPS // VIRTUAL BOX ...'

sudo yum -y install kernel-devel kernel-headers make patch
sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
sudo yum -y install VirtualBox-5.2
echo '=============================================================================================' >> installation.log
echo 'systemctl status vboxdrv' >> installation.log
sudo systemctl status vboxdrv >> installation.log
echo '=============================================================================================' >> installation.log

echo 'INSTALLING AND UPDATING APPS // DOCKER ...'

sudo yum -y install sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo systemctl start docker.service
echo '=============================================================================================' >> installation.log
sudo docker --version >> installation.log
sudo docker-compose --version >> installation.log

echo 'INSTALLING AND UPDATING APPS // POSTMAN ...'

sudo yum -y install libXScrnSaver
cd /opt
sudo wget -O postman.tar.gz https://dl.pstmn.io/download/latest/linux64
sudo tar -xzf postman.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
sudo rm postman.tar.gz
cd $CURRENT_PATH

echo 'INSTALLING AND UPDATING APPS // VAGRANT ...'

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
