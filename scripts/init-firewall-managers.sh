#!/bin/sh

# docker swarm rules, managers only
ufw allow from 192.168.0.0/16 proto tcp to any port 2376
ufw allow from 192.168.0.0/16 proto tcp to any port 2377
# swarm workers and managers
ufw allow from 192.168.0.0/16 proto tcp to any port 7946
ufw allow from 192.168.0.0/16 proto udp to any port 7946
ufw allow from 192.168.0.0/16 proto udp to any port 4789
# glusterfs rules
ufw allow from 192.168.0.0/16 proto tcp to any port 24007
ufw allow from 192.168.0.0/16 proto tcp to any port 24008
# glusterfs brick1
ufw allow from 192.168.0.0/16 proto tcp to any port 49152 
# glusterfs brick2
ufw allow from 192.168.0.0/16 proto tcp to any port 49153
# glusterfs brick3
ufw allow from 192.168.0.0/16 proto tcp to any port 49154
# glusterfs inline Gluster NFS server
ufw allow from 192.168.0.0/16 proto tcp to any port 38465
ufw allow from 192.168.0.0/16 proto tcp to any port 38466
ufw allow from 192.168.0.0/16 proto tcp to any port 38467
# glusterfs portmapper
ufw allow from 192.168.0.0/16 to any port 111
ufw allow from 192.168.0.0/16 proto tcp to any port 2049
