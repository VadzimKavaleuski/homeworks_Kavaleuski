#!/bin/bash
echo "start config ssh on server2"
sudo cp /vagrant/server2/hosts /etc/hosts
sudo cp /vagrant/server2/ssh_config /etc/ssh/ssh_config
sudo cp /vagrant/.vagrant/machines/server1/virtualbox/private_key /home/vagrant/.ssh/server1_pk
sudo chmod 700 /home/vagrant/.ssh/server1_pk
sudo chown vagrant /home/vagrant/.ssh/server1_pk
sudo cp /vagrant/server2/ssh_config /etc/ssh_config
sudo rm /home/vagrant/.ssh/known_hosts
ssh-keyscan server1 >>/home/vagrant/.ssh/known_hosts
echo "start config ssh on server1"
ssh vagrant@server1 /vagrant/server1/init.sh