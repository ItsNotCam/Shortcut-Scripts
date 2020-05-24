#!/bin/bash

echo -e "\e[33mInstalling dependencies ..."
dpkg --configure -a
dpkg --add-architecture i386
apt-get update
apt-get install libc6-i386 lib32gcc1 lib32stdc++6 -y

echo -e "\e[36mCreating user"
useradd --create-home steam --shell /bin/bash

# setup bash as default shell
echo '
if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
	fi
fi' > ~steam/.profile

echo -e "\n\e[34mCreating steam folders"
mkdir ~steam/steam
mkdir ~steam/games

echo -e "\n\e[95mInstalling steamcmd"
cd ~steam/steam

echo ""
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar -xvf steamcmd_linux.tar.gz
rm steamcmd_linux.tar.gz

echo ""
chmod +x steamcmd.sh
chown -R steam:steam ~steam

echo -e "\n\e[34mSTARTING STEAMCMD, EXIT UPON UPDATE FINISH"
/bin/bash ./steamcmd.sh

echo -e "\n\e[32mDone\e[0m\n"
