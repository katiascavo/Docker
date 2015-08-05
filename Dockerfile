FROM ubuntu:14.04

# Initial update
RUN apt-get update

#common files
RUN apt-get install -y software-properties-common

#Java 8 install
#RUN apt-get purge openjdk*
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install oracle-java8-installer
RUN apt-get install oracle-java8-set-default

# Install Redis-Server
RUN apt-get install redis-server

#Install Git
RUN apt-get install git


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
RUN chmod 755 /start-server