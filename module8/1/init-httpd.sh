#!/bin/bash
cat /etc/apache2/envvars
source /etc/apache2/envvars
apache2 -k start
echo "apache started"
collectd -C /etc/collectd.conf -f
