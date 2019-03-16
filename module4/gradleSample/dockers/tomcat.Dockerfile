FROM tomcat:8.5-jre8
ARG version
RUN curl -o "/var/lib/tomcat/webapps/app.war" "http://192.168.0.100:8081/snapshots/test/$version/app.war"
