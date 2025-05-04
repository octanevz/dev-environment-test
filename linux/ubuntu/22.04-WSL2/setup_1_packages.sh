#!/bin/bash
set -e;

# Update OS and install some required packages
sudo apt update -y \
  && sudo apt upgrade -y \
  && sudo apt install -y \
      git \
      zsh \
  && sudo apt autoremove -y \
  && sudo apt clean -y;

# Install and configure Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# OMZ config for new users
sudo cp ./files/zsh/.zshrc /etc/skel/.zshrc;
sudo cp ./files/zsh/.zsh_aliases /etc/skel/.zsh_aliases;

# OMZ config for current user
cp ./files/zsh/.zshrc ~/.zshrc;
cp ./files/zsh/.zsh_aliases ~/.zsh_aliases;

# Change shell to Zsh
sudo chsh -s $(which zsh) $(whoami);
