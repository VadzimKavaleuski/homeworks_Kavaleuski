#!/bin/bash
echo "start config ssh on server1"
sudo cp /vagrant/server1/hosts /etc/hosts
cp /vagrant/.vagrant/machines/server2/virtualbox/private_key /home/vagrant/.ssh/server2_pk
sudo cp /vagrant/server1/ssh_config /etc/ssh/ssh_config
sudo chmod 700 /home/vagrant/.ssh/server2_pk
sudo chown vagrant /home/vagrant/.ssh/server2_pk
sudo rm /home/vagrant/.ssh/known_hosts
ssh-keyscan server2 >>/home/vagrant/.ssh/known_hosts
#ssh vagrant@server2 ping localhost -c 5