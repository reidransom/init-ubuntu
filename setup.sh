#!/bin/bash

display_usage() { 
	echo "Please supply a hostname for the first argument." 
	echo -e "\nUsage:\n./setup.sh <hostname>\n" 
}

if [  $# -le 0 ] 
then 
	display_usage
	exit 1
fi

sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended
sudo chsh -s /usr/bin/zsh ubuntu

# Add domain name/alias ID to cli prompt:
sed -i "s/➜/${1}➜/g" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

echo "\nexport PATH=/usr/local/bin:\$PATH" >> ~/.zshrc

curl -O https://raw.githubusercontent.com/reidransom/init-ubuntu/master/.tmux.conf
curl -O https://raw.githubusercontent.com/reidransom/init-ubuntu/master/.vimrc

# Install docker (From <https://docs.docker.com/install/linux/docker-ce/ubuntu/> on 5/1/19)
sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl enable docker

# Use latest release number from [releases page](https://github.com/docker/compose/releases).
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
