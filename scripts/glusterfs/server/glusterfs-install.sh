#!/bin/sh

# glusterfs GPG
wget -O - http://download.gluster.org/pub/gluster/glusterfs/LATEST/rsa.pub | sudo apt-key add - || \
    wget -O - https://download.gluster.org/pub/gluster/glusterfs/3.12/rsa.pub | sudo apt-key add -
sudo apt-get install -y glusterfs-server
