FROM ubuntu:14.04

# Initial update
RUN apt-get update

#common files
RUN apt-get install -y software-properties-common

#Java 8 install
#RUN apt-get purge openjdk*
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
#RUN apt-get install -y oracle-java8-installer
RUN "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

# Install Redis-Server
RUN apt-get install -y redis-server

#Install Git
RUN apt-get install -y git


## install maven
RUN apt-get update && apt-get --no-install-recommends install maven -y
#oppure RUN apt-get install maven


#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /start-server
RUN echo 'cd /URL-Shortener' >> /start-server
RUN echo 'mvn package' >> /start-server
RUN echo 'java -jar target/urlshortener-0.0.1-SNAPSHOT.jar' >> /start-server
RUN chmod 777 /start-server