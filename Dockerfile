FROM tomcat
MAINTAINER "Shawn.Xia<shawn.xia@harmoney.co.nz>"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./KiwiList-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war 
CMD ["catalina.sh", "run"]
