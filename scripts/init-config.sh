#!/bin/sh


cat > /etc/default/locale << EOF
LANG="en_US"
LOCALE="en_US:en"
EOF

timedatectl set-ntp no

apt-get update -y
apt-get install -y ntp

timedatectl set-timezone America/Buenos_Aires

cat > /etc/ssh/sshd_config << EOF
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile    .ssh/authorized_keys
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
PrintMotd no # pam does that
UsePrivilegeSeparation sandbox        # Default for new installations.
Subsystem    sftp    /usr/lib/ssh/sftp-server
EOF
mkdir /root/.ssh && chmod og-rwx /root/.ssh
cat >> /root/.ssh/authorized_keys << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDg3EIvSfAqlmwUBkTNJLd6n4JKmwuVIBPxnCT1k/Byxkfd8qlRIG/2qJ4bnw/7QH/fHLWCbRhCxekv8D5CvFlCy2ECtBRxw7NVYDf9BFvOmm0yn4p5Yy9xBJd+4FeQ++Cj34hAUbklRarZLqtgQfamdCD4bXHar/7AXNcue5lqJnmonaW0dlONvZ5IRjeGQbH5TeI31IPQRvEh2voL25jdNJfxg4PLZneoH1asga3dDIbTQpkacNizVYrth8ICDYAsRYfYwC6kGM9rNqeDpfThnsQ/aU/oyeZ2JfMTvrVqD8o9s344Dlge3PXlgCyf3wPs1GYg0uvGNZuIEUwYWje0jHF+ESPz8bpPLBceJYviDI5aXc518aTnsp7MlfS/e0rTOQn39+pYyKFiM9uc3pKmyTwL/c67CWtKIBq0YgqZnm+truMjDgaPjXoMSBAf2AOPKknT4kWmvkD7P8c4Jk82PvvKODi25GuOSs/WwTpaouFpF7HCfTNPvubSjTXUcLH7wpp2g4+eIGcqgWQY23AMhQfrBVH19J75ucXhb3h4CCCxyBCASfBmXmnD2PL+pRl9+RQxvH5HmdmsKDyH9a8L/uf4ILorI0LexJRwyNZY+dTrAXxWBcmShmD40BgB+Na0HyGpkZw4gR5gzkoFl1b6ARWjYecVSuBJAbIgnHMZfw== manager@txt
EOF

service sshd restart

# ssh enable
ufw allow 22/tcp
ufw --force enable

cat > /etc/hosts << EOF
127.0.0.1 localhost localhost.localdomain
192.168.236.9 manager1.swarm manager1
192.168.249.65 manager2.swarm manager2
192.168.242.9 manager3.swarm manager3
192.168.249.64 elasticsearch1.reputacion.digital elasticsearch1
192.168.246.2 elasticsearch2.reputacion.digital elasticsearch2
192.168.246.3 elasticsearch3.reputacion.digital elasticsearch3
192.168.240.2 kibana.reputacion.digital kibana
192.168.246.4 logstash.reputacion.digital lostash
192.168.249.63 senti senti.reputacion.digital
EOF
##################### DONT FORGET /etc/hosts
