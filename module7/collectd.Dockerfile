FROM centos:7.5.1804
RUN yum install -y epel-release && \
    yum install -y collectd && \
    yum install -y httpd && \ 
    yum clean all 
EXPOSE 80
COPY collectd.conf /etc/collectd.conf   
COPY init-httpd.sh /opt/init-httpd.sh
ENTRYPOINT  ["/opt/init-httpd.sh"]