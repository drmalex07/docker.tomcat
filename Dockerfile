FROM tomcat:8.5-jre8
 
ENV DB_RESOURCE_NAME="jdbc/helloworld" DB_URL="" DB_USERNAME="" DB_DRIVER_CLASS_NAME=""

COPY dependency/*.jar lib/

COPY run-catalina.sh /run-catalina.sh
RUN chmod +x /run-catalina.sh

COPY webapps/hello-spring.war webapps/ 
RUN mkdir webapps/hello-spring && \
    unzip webapps/hello-spring.war -d webapps/hello-spring && rm -v webapps/hello-spring.war 
    

CMD ["/run-catalina.sh"]
