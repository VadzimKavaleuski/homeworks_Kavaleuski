FROM camptocamp/node-collectd
RUN apt-get update && \
    apt-get install -y apache2 && \ 
    apt-get clean all && \
    mkdir /var/run/apache2 && \
    echo "DefaultRuntimeDir=/var/run/apache2" >> /etc/apache2/envvars
EXPOSE 80
COPY collectd.conf /etc/collectd.conf   
COPY init-httpd.sh /opt/init-httpd.sh
ENTRYPOINT ["/opt/init-httpd.sh"]