#!/bin/bash
cat /home/vagrant/.ssh/known_hosts 2>/dev/null|grep server1 > /dev/null||ssh-keyscan server1 >>/home/vagrant/.ssh/known_hosts 
echo "start config ssh on server1"
ssh vagrant@server1 sudo /vagrant/server1/init_p.sh
ssh vagrant@server1 /vagrant/server1/init.sh