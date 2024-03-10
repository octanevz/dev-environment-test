#!/bin/bash
set -e;

# Update OS and install some required packages
sudo apt update -y \
  && sudo apt upgrade -y \
  && sudo apt install -y \
      git \
      keychain \
      zsh \
  && sudo apt autoremove -y \
  && sudo apt clean -y;

# Install and configure Oh My Zsh
sudo git clone https://github.com/ohmyzsh/ohmyzsh.git /usr/share/oh-my-zsh;
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/oh-my-zsh/custom/plugins/zsh-autosuggestions;
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/oh-my-zsh/custom/themes/powerlevel10k;

# OMZ config for new users
sudo cp ./files/zsh/.zshrc /etc/skel/.zshrc;
sudo cp ./files/zsh/.p10k.zsh /etc/skel/.p10k.zsh;

# OMZ config for current user
cp ./files/zsh/.zshrc ~/.zshrc;
cp ./files/zsh/.p10k.zsh ~/.p10k.zsh;

# Change shell to Zsh
sudo chsh -s $(which zsh) $(whoami);
