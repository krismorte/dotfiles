 #!/bin/sh

echo "Adding repo to new ansible version."
sudo add-apt-repository ppa:ansible/ansible-2.8 -y

sudo apt-get update

echo "Installing ansible..."
sudo apt-get install ansible

echo "Running playbook..."
ansible-playbook -K ansible/main-mint.yml
