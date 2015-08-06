FROM ubuntu:latest

#ports
EXPOSE 8080

#common files
RUN apt-get install -y software-properties-common

#Get repositories for java8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update

#Install JDK 8
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install oracle-java8-installer -y

# Install Redis-Server
RUN apt-get install -y redis-server

#Install Git
RUN apt-get install git -y 

#Install maven
RUN apt-get install maven -y

#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /server
RUN echo 'cd /URL-Shortener/URLShortener' >> /server
RUN echo 'mvn package' >> /server
RUN echo 'java -jar target/urlshortener-0.0.1-SNAPSHOT.jar' >> /server
RUN chmod 777 /server