FROM maven:3-jdk-8

ARG NUXEO_VERSION=release-10.10

WORKDIR /root
RUN git clone --branch ${NUXEO_VERSION} https://github.com/nuxeo/nuxeo

RUN mvn dependency:go-offline -f /root/nuxeo/pom.xml
