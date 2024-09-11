#! /bin/bash
#TODO
# - use mkdir to make dir structure needed
# - more elegant solution to cat ~./.env (use example commented out below

#install prereqs
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common gnupg dirmngr acl

#download and add docker gpg key, add docker repo
#debian
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

#ubuntu
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#install docker docker-ce and test with hello world
sudo apt-get update
sudo apt-get -y install docker-ce 
sudo docker run hello-world

#install docker-compose and change ownership
sudo curl -L https://github.com/docker/compose/releases/download/v2.11.1/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#verify
docker-compose --version

sudo usermod -aG docker ${USER}

if [ ! -d ~/docker ] ; then
    mkdir ~/docker
fi

sudo setfacl -Rdm g:docker:rwx ~/docker
sudo chmod -R 775 ~/docker


## Create the .env file
#echo "Creating the .env file with the values we have gathered"
#printf "\\n"
#cat << EOF > .env
####  ------------------------------------------------
####  M E D I A B O X   C O N F I G   S E T T I N G S
####  ------------------------------------------------
####  The values configured here are applied during
####  $ docker-compose up
####  -----------------------------------------------
####  DOCKER-COMPOSE ENVIRONMENT VARIABLES BEGIN HERE
####  -----------------------------------------------
####
#EOF
#{
#echo "LOCALUSER=$localuname"
#echo "HOSTNAME=$thishost"
#echo "IP_ADDRESS=$locip"
#echo "PUID=$PUID"
#echo "PGID=$PGID"
#echo "DOCKERGRP=$DOCKERGRP"
#echo "PWD=$PWD"
#echo "DLDIR=$dldirectory"
#echo "TVDIR=$tvdirectory"
#echo "MOVIEDIR=$moviedirectory"
#echo "MUSICDIR=$musicdirectory"
#echo "PIAUNAME=$piauname"
#echo "PIAPASS=$piapass"
#echo "CIDR_ADDRESS=$lannet"
#echo "TZ=$time_zone"
#echo "PMSTAG=$pmstag"
#echo "PMSTOKEN=$pmstoken"
#echo "PORTAINERSTYLE=$portainerstyle"
#echo "VPN_REMOTE=$vpnremote"
#} >> .env
#echo ".env file creation complete"
#printf "\\n\\n"


## POTENTIAL USEFUL THINGS TO PILFER FROM
#
## Ask for the user password
## Script only works if sudo caches the password for a few minutes
#sudo true

## Install kernel extra's to enable docker aufs support
## sudo apt-get -y install linux-image-extra-$(uname -r)

## Add Docker PPA and install latest version
## sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
## sudo sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
## sudo apt-get update
## sudo apt-get install lxc-docker -y

## Alternatively you can use the official docker install script
#wget -qO- https://get.docker.com/ | sh

## Install docker-compose
#COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
#sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
#sudo chmod +x /usr/local/bin/docker-compose
#sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

## Install docker-cleanup command
#cd /tmp
#git clone https://gist.github.com/76b450a0c986e576e98b.git
#cd 76b450a0c986e576e98b
#sudo mv docker-cleanup /usr/local/bin/docker-cleanup
#sudo chmod +x /usr/local/bin/docker-cleanup
