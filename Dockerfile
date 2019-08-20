FROM tomcat:8.5-jre8
 
ENV DB_RESOURCE_NAME="jdbc/helloworld" DB_URL="" DB_USERNAME="" DB_DRIVER_CLASS_NAME=""

COPY dependency/*.jar lib/

COPY run-catalina.sh /run-catalina.sh
RUN chmod +x /run-catalina.sh

COPY webapps/*.war webapps/ 

CMD ["/run-catalina.sh"]
