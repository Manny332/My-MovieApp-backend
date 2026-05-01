# Defining base/parent image
FROM ubuntu

# Patching, Upgrate and Installing packages & Dependencies
RUN apt-get update ; apt-get install upgrade -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

# Setting work dir
WORKDIR /app

# Copy source codes to workdir
COPY ./.mvn /app
COPY ./src /app
COPY ./pom.xml /app

# Run the application  build
RUN mvn -f /app clean packege

# Copy the app file
RUN cp /app/target/*.jar /app/app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]