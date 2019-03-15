#!/bin/bash
echo start apache
httpd -k start
echo "apache started"
collectd -C /etc/collectd.conf -f