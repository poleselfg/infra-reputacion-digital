#!/bin/sh

shared_dir=/opt/shared
mkdir $shared_dir
chmod og-rwx $shared_dir

systemctl enable rpcbind
systemctl start rpcbind

volume_name=shared_v0
gluster_command="gluster volume create $volume_name replica 3"
nodes="manager1.swarm=192.168.236.9,manager2.swarm=192.168.249.65,manager3.swarm=192.168.242.9"


OLD_IFS=$IFS
IFS=","
for node in $nodes; do
    node_ip=$(echo ${node} | cut -d '=' -f 2)
    node_host=$(echo ${node} | cut -d '=' -f 1)
    ufw allow from $node_ip
    gluster peer probe $node_host
    gluster_command="$gluster_command $node_host:$shared_dir"
done
ufw --force enable
IFS=$OLD_IFS

if [ $(hostname) = "manager1.swarm" ]; then
    echo "Executing command: $gluster_command"
    # create the gluster volume
    $gluster_command force
    # start the volume
    gluster volume start $volume_name
fi

gluster volume set $volume_name auth.allow 192.168.242.9,192.168.236.9,192.168.249.65,192.168.242.0,192.168.249.64,192.168.246.2,192.168.246.3,192.168.240.2,192.168.246.4

echo "manager1:/shared_v0 /mnt/ glusterfs defaults,_netdev 0 0" >> /etc/fstab