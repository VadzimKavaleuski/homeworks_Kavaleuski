FROM httpd:2.4.38
RUN curl -o "/var/lib/tomcat/webapps/app.war" "http://192.168.0.100:8081/snapshots/test/'+version+'/app.war"