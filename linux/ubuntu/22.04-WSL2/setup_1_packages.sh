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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# OMZ config for new users
sudo cp ./files/zsh/.zshrc /etc/skel/.zshrc;
sudo cp ./files/zsh/.p10k.zsh /etc/skel/.p10k.zsh;

# OMZ config for current user
cp ./files/zsh/.zshrc ~/.zshrc;
cp ./files/zsh/.p10k.zsh ~/.p10k.zsh;

# Change shell to Zsh
sudo chsh -s $(which zsh) $(whoami);
