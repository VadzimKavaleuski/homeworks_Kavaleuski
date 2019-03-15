#!/bin/bash
#/opt/logstash-6.6.2/bin/logstash -f /etc/logstash/logstash.conf
httpd -k start 
/opt/filebeat-6.6.2-linux-x86_64/filebeat -e -c /opt/filebeat-6.6.2-linux-x86_64/filebeat_my.yml
#||/opt/filebeat-6.6.2-linux-x86_64/filebeat -e -c /opt/filebeat-6.6.2-linux-x86_64/filebeat.yml