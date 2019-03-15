FROM centos:7.5.1804
RUN yum update -y  && \
    curl -G https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.2-linux-x86_64.tar.gz | tar -xz -C /opt && \
    yum install -y httpd && \
    yum clean all 
COPY httpd/start-httpd.sh /opt/start-httpd.sh
COPY httpd/filebeat.yml /opt/filebeat-6.6.2-linux-x86_64/filebeat_my.yml
run chmod 600 /opt/filebeat-6.6.2-linux-x86_64/filebeat_my.yml
EXPOSE 80
ENTRYPOINT ["/opt/start-httpd.sh"]
