FROM tomcat:8.5-jre8
 
ENV DB_HOST="postgres-1" DB_PORT="5432" DB_USERNAME="user" DB_NAME="helloworld" DB_PASSWORD_FILE="secrets/db-password" MANAGER_PASSWORD_FILE="secrets/manager-password"

COPY conf/context.xml conf/tomcat-users.xml ./conf/
COPY webapps/manager/META-INF/context.xml ./webapps/manager/META-INF/context.xml

COPY run-catalina.sh /run-catalina.sh
RUN chmod +x /run-catalina.sh

CMD ["/run-catalina.sh"]
