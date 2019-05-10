# Initial setup of the networking lab on the CentOS Linux

I'm quite often rebuilding the lab VM or server and to ease this task decided to create a simple BASH-based automation for inital provisioning.

## What is in the scope
- Update of all the packages
- Installation of Ansible and all dependencies
- Installation of useful Python packages (pyang, ncclient, ipaddr, etc)
- Installation of Virtual Box and all dependencies
- Installation of KVM and all dependencies
- Installation of Vagrant and all dependencies

## How to use
Just download or copy the content of the files on the freshly installed CentOS Linux and execute:
- `./initial_setup_virtualbox.sh` for installation with Virtual Box
- `./initial_setuo_kvm.sh` for installation with QEMU/KVM
