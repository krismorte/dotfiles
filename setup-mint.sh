 #!/bin/sh

#add new repository
sudo add-apt-repository ppa:ansible/ansible-2.8 -y

sudo apt-get update

sudo apt-get install ansible

ansible-playbook -K ansible/main-mint.yml

reboot 