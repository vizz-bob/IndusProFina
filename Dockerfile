# Use an official Tomcat base image
FROM tomcat:9.0

# Set environment variables for the Tomcat home
ENV CATALINA_HOME /usr/local/tomcat

# Expose the desired port (8081) for Tomcat
EXPOSE 8081

# Copy your web application (WAR file) into the Tomcat webapps directory
# Replace 'ABCtechnologiesbyVinzap-1.0.war' with the actual file path if necessary
COPY ABCtechnologiesbyVinzap-1.0.war $CATALINA_HOME/webapps/ROOT.war

# Change the port to 8081 in the server.xml file
RUN sed -i 's/8080/8081/' $CATALINA_HOME/conf/server.xml

# Start Tomcat
CMD ["catalina.sh", "run"]
