FROM java:8jdk

# Initial update
RUN apt-get update

#
# Redis Dockerfile 1
#
# https://github.com/dockerfile/redis
#
# Install Redis-Server
RUN apt-get install -y redis-server

## install maven
RUN apt-get update && apt-get --no-install-recommends install maven -y


#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /start-server
RUN echo 'cd /URL-Shortener' >> /start-server
RUN echo 'mvn package' >> /start-server
RUN echo 'java -jar target/urlshortener-0.0.1-SNAPSHOT.jar' >> /start-server
RUN chmod 755 /start-server