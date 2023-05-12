# Pull base image 
FROM tomcat:8-jre8 

# Maintainer 
MAINTAINER "awafri2005@yahoo.com" 
COPY ./webapp.war /usr/local/tomcat/webapps
