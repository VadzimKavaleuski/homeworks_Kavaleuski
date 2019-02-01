#!/bin/bash
echo "start config ssh on server1 by root"
cat /etc/hosts|grep server2 > /dev/null||sudo [echo 192.168.0.11 server2 >>/etc/hosts]
ls /home/vagrant/.ssh|grep server2_pk  > /dev/null||cp /vagrant/.vagrant/machines/server2/virtualbox/private_key /home/vagrant/.ssh/server2_pk
sudo chmod 700 /home/vagrant/.ssh/server2_pk
sudo chown vagrant /home/vagrant/.ssh/server2_pk
cat /etc/ssh/ssh_config|grep IdentityFile=/home/vagrant/.ssh/server2_pk > /dev/null||sudo echo IdentityFile=/home/vagrant/.ssh/server2_pk >>/etc/ssh/ssh_config
