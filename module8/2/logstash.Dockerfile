FROM docker.elastic.co/logstash/logstash-oss:6.2.2
COPY logstash.conf /usr/share/logstash/pipeline
#COPY logstash.conf /opt/logstash.conf
#CMD ["-f","/opt/logstash.conf"]
