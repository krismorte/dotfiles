#!/bin/sh

COMMAND=$1

run_arch_setup(){
  echo "Verifying ansible installation..."

  if [[ ! -x /usr/bin/ansible ]]; then
    echo "Installing ansible..."
    sudo pacman -S ansible --noconfirm
  fi

  echo "Verifying ansible plugin for yay..."

  if [[ ! -x /usr/share/ansible/plugins/modules/yay ]]; then
    echo "Installing ansible-yay..."
    sudo curl -fLo /usr/share/ansible/plugins/modules/yay --create-dirs https://raw.githubusercontent.com/mnussbaum/ansible-yay/master/yay
    sudo chmod -R 755 /usr/share/ansible/plugins
  fi

  echo "Running playbook..."
  ansible-playbook -K ansible/main-arch.yml
}

run_mint_setup(){
  echo "Adding repo to new ansible version."
  sudo add-apt-repository ppa:ansible/ansible-2.8 -y

  sudo apt-get update

  echo "Installing ansible..."
  sudo apt-get install ansible

  echo "Running playbook..."
  ansible-playbook -K ansible/main-mint.yml
}

run_mac_setup(){
  echo "Check brew installation"
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      echo "Installing brew"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
      echo "Updating brew"
      brew update
  fi
  echo "Installing ansible..."
  brew install ansible

  echo "Running playbook..."
  ansible-playbook -K ansible/main-mac.yml
}

case "${COMMAND}" in
  arch)
    run_arch_setup
    ;;
  
  mint)
    run_mint_setup
    ;;
  
  mac)
    run_mac_setup
    ;;

	*)
		echo "Invalid Command ${COMMAND}"
		;;
esac
