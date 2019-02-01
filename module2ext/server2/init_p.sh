#!/bin/bash
echo "start config ssh on server2 by root"
cat /etc/hosts|grep server1 > /dev/null||echo 192.168.0.10 server1 >>/etc/hosts
cat /etc/ssh/ssh_config|grep IdentityFile=/home/vagrant/.ssh/server1_pk > /dev/null||echo IdentityFile=/home/vagrant/.ssh/server1_pk >>/etc/ssh/ssh_config 
ls /home/vagrant/.ssh|grep server1_pk  > /dev/null||cp /vagrant/.vagrant/machines/server1/virtualbox/private_key /home/vagrant/.ssh/server1_pk
chmod 700 /home/vagrant/.ssh/server1_pk
chown vagrant /home/vagrant/.ssh/server1_pk
