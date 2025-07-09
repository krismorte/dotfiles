 #!/bin/sh

echo "Adding repo to new ansible version."
sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt update

# Function to check if a command exists
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

if command_exists "ansible"; then
  echo "Ansible already instaled..."
else
  echo "Installing ansible..."
  sudo apt install ansible
fi

if command_exists "git"; then
  echo "Git already instaled..."
else
  echo "Installing git..."
  sudo apt install git
fi


echo "Running playbook..."
ansible-playbook -K ansible/main-mint.yml
