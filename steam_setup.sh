#!/bin/bash

echo "Installing dependencies ..."
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6-i386 lib32gcc1 lib32stdc++6 -y

echo "Creating user"
sudo useradd --create-home steam
su steam
# setup bash as default shell
echo '
if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
	fi
fi' > ~steam/.profile

echo "Creating steam folders"
mkdir ~steam/steam
mkdir ~steam/games

echo "Installing steamcmd"
cd ~steam/steam
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar -xf steam_cmd_linux.tar.gz
rm steam_cmd_linux.tar.gz
chmod +x steamcmd.sh

echo "Steamcmd setup"
logout
