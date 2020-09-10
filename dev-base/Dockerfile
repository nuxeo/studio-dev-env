FROM openjdk:11 AS java11

FROM openjdk:8 AS java8

FROM centos:8

ARG JDK_VERSION=11
ARG NODE_VERSION=12
ARG MAVEN_VERSION=3.6.3

# Install Tooling
RUN dnf install -y sudo curl wget man nano git procps openssh vim \
  && dnf clean all

# Install JDK
COPY --from=java8 /usr/local/openjdk-8 /usr/local/openjdk-8
COPY --from=java11 /usr/local/openjdk-11 /usr/local/openjdk-11
ENV JAVA_HOME=/usr/local/openjdk-${JDK_VERSION} \
  PATH=${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin/:${PATH}

# Install Dev Dependencies
RUN dnf module install -y nodejs:${NODE_VERSION} \
  && dnf clean all

# Install Maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven

# Install NPM Dependencies
RUN npm install -g nuxeo-cli yarn

