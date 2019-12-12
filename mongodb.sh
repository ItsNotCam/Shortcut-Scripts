#!/bin/bash

echo "Making temporary directory"
mkdir tmp

printf "\nInstalling gnupg and adding apt-key"
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

printf "\nCreating lists file for mongodb"
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update -y

printf "\nInstalling mongodb"
sudo apt-get install -y mongodb-org

printf "\nRunning mongodb service"
sudo service mongod start
sudo service mongod status

rm -rf tmp
