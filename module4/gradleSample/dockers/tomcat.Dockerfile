FROM tomcat:8.5-jre8
ARG version
RUN curl -o "/var/lib/tomcat/webapps/app.war" "http://192.168.0.100:8081/nexus/service/local/repositories/internalSample/content/snapshots/test/$version/app.war"
