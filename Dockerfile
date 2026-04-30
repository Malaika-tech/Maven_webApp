FROM tomcat
WORKDIR /usr/local/tomcat
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY target/java-example.war /usr/local/tomcat/webapps/java-example.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
