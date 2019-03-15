FROM influxdb
#COPY init-influx.sh /opt/init-influx.sh
RUN wget https://dl.grafana.com/oss/release/grafana-6.0.1.linux-amd64.tar.gz -O /tmp/grafana.tar.gz && \
    tar -zxvf /tmp/grafana.tar.gz -C /opt && \
    rm /tmp/grafana.tar.gz && \
    apt-get update && \
    apt-get install collectd -y && \
    apt-get clean all 
#run exec /opt/init-influx.sh  
COPY influxdb.conf /etc/influxdb/influxdb.conf   
COPY collectd.conf /etc/collectd/collectd.conf   
COPY collectd.conf /etc/collectd.conf   
COPY types.db /usr/local/share/collectd/types.db
COPY init-grafana.sh /opt/init-grafana.sh
CMD ["/opt/init-grafana.sh"]