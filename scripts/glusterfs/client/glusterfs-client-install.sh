#!/bin/sh

sudo apt-get install -y glusterfs-client

echo "manager1:/shared_v0 /mnt/ glusterfs defaults,_netdev 0 0" >> /etc/fstab