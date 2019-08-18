FROM tomcat:8.5-jre8
 
ENV DB_RESOURCE_NAME="jdbc/helloworld" DB_URL="" DB_USERNAME="" DB_DRIVER_CLASS_NAME=""
ENV DB_PASSWORD_FILE="secrets/db-password" 
ENV MANAGER_PASSWORD_FILE="secrets/manager-password"

COPY conf/context.xml conf/tomcat-users.xml ./conf/
COPY webapps/manager/META-INF/context.xml ./webapps/manager/META-INF/context.xml

COPY run-catalina.sh /run-catalina.sh
RUN chmod +x /run-catalina.sh

CMD ["/run-catalina.sh"]
