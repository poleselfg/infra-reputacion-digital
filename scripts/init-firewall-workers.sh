#!/bin/sh

# swarm workers and managers
ufw allow from 192.168.0.0/16 proto tcp to any port 7946
ufw allow from 192.168.0.0/16 proto udp to any port 7946
ufw allow from 192.168.0.0/16 proto udp to any port 4789