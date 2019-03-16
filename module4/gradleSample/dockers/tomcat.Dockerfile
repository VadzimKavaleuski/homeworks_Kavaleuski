FROM tomcat:8.5-jre8
ARG version
RUN curl -o /usr/local/tomcat/webapps/app.war http://10.0.2.15:8081/nexus/service/local/repositories/internalSample/content/snapshots/test/$version/app.war
