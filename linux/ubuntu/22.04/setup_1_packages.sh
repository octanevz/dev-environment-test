#!/bin/bash
set -e;

# Update OS and install some required packages
sudo apt update -y \
  && sudo apt upgrade -y \
  && sudo apt install -y \
      ca-certificates \
      curl \
      fonts-powerline \
      gimp \
      git \
      gpg \
      htop \
      libfuse2 \
      lsb-release \
      wget \
      zsh \
  && sudo apt autoremove -y \
  && sudo apt clean -y;

# Install/Update Snap Packages
sudo snap install chromium;
sudo snap refresh;

# Install and configure Oh My Zsh
sudo git clone https://github.com/ohmyzsh/ohmyzsh.git /usr/share/oh-my-zsh;
sudo cp ./files/zsh/zshrc-template /etc/skel/.zshrc; # OMZ config for new users
cp ./files/zsh/zshrc-template ~/.zshrc; # OMZ config for current user
sudo chsh -s $(which zsh) $(whoami);

# Reboot OS
sudo reboot now;
