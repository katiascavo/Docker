FROM ubuntu:latest

# Initial update
RUN apt-get update

#
# Redis Dockerfile 1
#
# https://github.com/dockerfile/redis
#


#Install nano - file editor
RUN apt-get install nano

#Install maven
RUN apt-get install maven -y

#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /start-server
RUN echo 'cd /URL-Shortener' >> /start-server
RUN echo 'mvn package' >> /start-server
RUN echo 'java -jar target/URL-Shortener.jar' >> /start-server
RUN chmod 755 /start-server