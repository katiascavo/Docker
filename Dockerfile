# Pull base image.
FROM ubuntu:14.04

#ports
EXPOSE 8080
# Expose ports.
EXPOSE 6379

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

#Install Maven
RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-3.3.3 /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

#Get the source repository
RUN git clone https://github.com/GruppoPBDMNG-1/URL-Shortener

#create the start server file and make it executable
RUN echo '#!/bin/bash' >> /server
RUN echo 'cd /URL-Shortener/URLShortener' >> /server
RUN echo 'mvn package' >> /server
RUN echo 'java -jar target/urlshortener-0.0.1-SNAPSHOT.jar' >> /server
RUN chmod 777 /server