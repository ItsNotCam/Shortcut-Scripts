#!/bin/bash

usrnms=( $@ )

grpe=$(cat /etc/group | grep quickscripts)
if [[ ${#grpe} -lt 1 ]]; then
	echo -e "\e[34mCreating quickscripts"
	sudo groupadd quickscripts
fi

for usr in $usrnms; do
	ingrp=$(groups $usr | grep quickscripts)
	if [[ ${#ingrp} -lt 1 ]]; then
		echo "Adding $USER to quickscripts group"
		sudo usermod -aG quickscripts $usr
	fi
done

ingrp=$(groups | grep quickscripts)
if [[ ${#ingrp} -lt 1 ]]; then
	exec su -l $USER
fi


echo -e "\e[34mCreating quickscripts directory and setting ownership"
sudo mkdir /var/lib/quickscripts
sudo chgrp quickscripts /var/lib/quickscripts
sudo chmod g+rwx /var/lib/quickscripts

echo -e "\e[34mMoving myself and the rest of the scripts to the quickscripts directory"
mv ${PWD}/* /var/lib/quickscripts
