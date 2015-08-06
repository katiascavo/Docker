FROM ubuntu:14.04

# Initial update
RUN apt-get update

#common files
RUN apt-get install -y software-properties-common

#Java 8 install
#non messo RUN apt-get purge openjdk*
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get update
#non messo RUN apt-get install -y oracle-java8-installer
#RUN "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

# Install maven
#RUN apt-get update
#RUN apt-get install -y maven


# Install Redis-Server
#RUN apt-get install -y redis-server

#Install Git
RUN apt-get install -y git

EXPOSE 8080 6379

#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /server
RUN echo 'cd URL-Shortener/URLShortener' >> /server
RUN echo 'mvn install' >> /server
RUN echo 'java -jar target/urlshortener-0.0.1-SNAPSHOT.jar' >> /server
RUN chmod 777 /server