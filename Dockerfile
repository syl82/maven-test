# Pull base image 
FROM tomcat:8-jre8 

# Maintainer 
MAINTAINER "sylvie" 
COPY ./webapp.war /usr/local/tomcat/webapps
