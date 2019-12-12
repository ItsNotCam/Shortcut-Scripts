#!/bin/bash

grpe=$(cat /etc/group | grep quickscripts)
if [[ ${#grpe} -lt 1 ]]; then
	echo -e "\e[34mCreating quickscripts"
	sudo groupadd quickscripts
fi

ingrp=$(groups | grep quickscripts)
if [[ ${#ingrp} -lt 1 ]]; then
	sudo usermod -aG quickscripts $USER
	exec su -l $USER
fi


echo -e "\e[34mCreating quickscripts directory and setting ownership"
sudo mkdir /var/lib/quickscripts
sudo chown :quickscripts /var/lib/quickscripts
sudo chmod g+rwx /var/lib/quickscripts
echo -e "\e[34mDone ... make sure to run\n	sudo usermod -aG quickscripts <user>\n to give permissions to users"

echo -e "\e[34mMoving myself and the rest of the scripts to the quickscripts directory"
mv ${PWD}/* /var/lib/quickscripts
sudo chown -R *:quickscripts /var/lib/quickscripts
sudo chmod +x *.sh
