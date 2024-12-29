# Step 1: Use Ubuntu as a base image
FROM ubuntu:20.04

# Step 2: Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Step 3: Install dependencies (OpenJDK 17, Maven, wget, curl, unzip)
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    wget \
    curl \
    unzip \
    && apt-get clean

# Step 4: Install Tomcat (version 9.0.55 in this case)
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.55/bin/apache-tomcat-9.0.55.tar.gz -P /tmp \
    && tar -xvzf /tmp/apache-tomcat-9.0.55.tar.gz -C /opt \
    && mv /opt/apache-tomcat-9.0.55 /opt/tomcat \
    && rm /tmp/apache-tomcat-9.0.55.tar.gz

# Step 5: Set the Tomcat environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

# Step 6: Copy Maven project files into the container (use your actual project path here)
COPY . /app

# Step 7: Build the Maven project inside the container
WORKDIR /app
RUN mvn clean package -DskipTests

# Step 8: Copy the generated WAR file to Tomcat's webapps directory
# Make sure the WAR file is in the target directory from the Maven build
COPY target/your-application.war $CATALINA_HOME/webapps/your-application.war

# Step 9: Expose the necessary ports for Tomcat
EXPOSE 8080

# Step 10: Run Tomcat in the foreground
CMD ["sh", "-c", "$CATALINA_HOME/bin/catalina.sh run"]

