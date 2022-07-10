#!/bin/bash
set -e;

# Install VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg;
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/;
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list';
rm -f packages.microsoft.gpg;
sudo apt update -y \
  && sudo apt install -y \
      code \
  && sudo apt autoremove -y \
  && sudo apt clean -y;

# Install VSCode extensions
code --install-extension davidanson.vscode-markdownlint;
code --install-extension donjayamanne.git-extension-pack;
code --install-extension ms-azuretools.vscode-docker;
code --install-extension ms-vscode-remote.vscode-remote-extensionpack;
code --install-extension tyriar.sort-lines;
code --install-extension vscode-icons-team.vscode-icons;
code --install-extension github.github-vscode-theme;

# Configure VSCode
cp ./files/vscode/argv.json ~/.vscode;
uuid=$(uuidgen); # Generate fresh guid for VSCode crash reporting
sed -i "s/\"crash-reporter-id\": \"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx\"/\"crash-reporter-id\": \"${uuid}\"/1" ~/.vscode/argv.json;
cp ./files/vscode/settings.json ~/.config/Code/User;

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
sudo apt update -y \
  && sudo apt install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-compose-plugin \
  && sudo apt autoremove -y \
  && sudo apt clean -y;

# Pull Docker Images
sudo docker pull ubuntu:jammy;
sudo docker pull buildpack-deps:jammy-curl;
sudo docker pull buildpack-deps:jammy-scm;
sudo docker pull buildpack-deps:jammy;
sudo docker pull amazon/aws-cli:latest;
sudo docker pull mcr.microsoft.com/azure-cli:latest;
sudo docker pull bitnami/postgresql:14-debian-11;
sudo docker pull node:16-bullseye;
sudo docker pull hadolint/hadolint:latest;

# Reboot OS
sudo reboot now;
