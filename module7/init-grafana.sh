#!/bin/bash
collectd -C /etc/collectd/collectd.conf
influxd -config /etc/influxdb/influxdb.conf run &
sleep 10
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE collect_db"  
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=create user admin with password 'admin' with all privileges"
/opt/grafana-6.0.1/bin/grafana-server -homepath /opt/grafana-6.0.1