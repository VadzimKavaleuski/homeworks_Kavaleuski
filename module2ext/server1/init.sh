#!/bin/bash
echo "start config ssh on server1 by vagrant"
cat /home/vagrant/.ssh/known_host 2>/dev/null|cat|grep server2>/dev/null||ssh-keyscan server2 >>/home/vagrant/.ssh/known_hosts