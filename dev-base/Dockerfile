ARG ALPINE_VERSION=3.12
ARG CENTOS_VERSION=8

# Use Python36, insteaf of python38, because Azure-CLI depends on
ARG PYTHON_VERSION=36
ARG NODE_VERSION=12
ARG JDK_VERSION=11
ARG MAVEN_VERSION=3.6.3

ARG AWS_VERSION=2.0.30
ARG AZURE_VERSION=2.12.1-1.el7
ARG GCLOUD_SDK_VERSION=312.0.0
ARG KAFKA_VERSION=2.3.1
ARG MONGO_VERSION=4.4.0

# Zulu OpenJDK builds
FROM azul/zulu-openjdk-centos:11 AS java11
FROM azul/zulu-openjdk-centos:8 AS java8

FROM alpine:${ALPINE_VERSION} AS ALPINE_CURL
RUN apk add --no-cache curl

#
# Kafka CLI
#
FROM ALPINE_CURL AS KAFKA_CLI
ARG KAFKA_VERSION
RUN curl -fsSL http://apache.mirrors.hoobly.com/kafka/${KAFKA_VERSION}/kafka_2.11-${KAFKA_VERSION}.tgz -o /tmp/kafka-cli.tgz \
  && mkdir -p /export/ \
  && tar -xzvf /tmp/kafka-cli.tgz -C /export/ \
  && rm /tmp/kafka-cli.tgz

#
# Mongo Shell
#
FROM ALPINE_CURL AS MONGO_SHELL
ARG MONGO_VERSION
RUN curl -fsSL https://downloads.mongodb.org/linux/mongodb-shell-linux-x86_64-ubuntu1804-${MONGO_VERSION}.tgz -o /tmp/mongodb-shell.tgz \
  && mkdir -p /export/ \
  && tar -xzvf /tmp/mongodb-shell.tgz -C /export/ \
  && rm /tmp/mongodb-shell.tgz

#
# AWS CLI
#
FROM centos:${CENTOS_VERSION} AS AWS_CLI
ARG AWS_VERSION
ARG PYTHON_VERSION
RUN dnf install -y unzip python${PYTHON_VERSION} \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "/tmp/awscli.zip" \
  && mkdir -p /export/ \
  && unzip /tmp/awscli.zip -d /tmp/ \
  && /tmp/aws/install -i /export/aws

#
# Google Cloud-SDK - XXX Try with gcr.io/google.com/cloudsdktool/cloud-sdk:slim|latest
#
FROM centos:${CENTOS_VERSION} AS GCLOUD_SDK
ARG GCLOUD_SDK_VERSION
ARG PYTHON_VERSION
RUN dnf install -y python${PYTHON_VERSION} \
  && curl "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz?hl=fr" -o "/tmp/google-cloud-sdk.tag.gz" \
  && mkdir -p /export/ \
  && tar zxvf /tmp/google-cloud-sdk.tag.gz -C /export/ \
  && rm /tmp/google-cloud-sdk.tag.gz \
  && /export/google-cloud-sdk/install.sh -q \
  && /export/google-cloud-sdk/bin/gcloud components update -q

#
# Maven
#
FROM ALPINE_CURL AS MAVEN
ARG MAVEN_VERSION
RUN curl -fsSL -o /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && mkdir -p /export/maven \
  && tar -xzf /tmp/apache-maven.tar.gz -C /export/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz

#
# Final Image
#
FROM centos:${CENTOS_VERSION}

ARG AWS_VERSION
ARG AZURE_VERSION
ARG GCLOUD_SDK_VERSION

ARG JDK_VERSION
ARG MAVEN_VERSION
ARG PYTHON_VERSION
ARG NODE_VERSION
ARG KAFKA_VERSION
ARG MONGO_VERSION

# Install Tooling
RUN dnf install -y sudo curl tmux wget man nano git procps openssh vim zsh libxslt expect python${PYTHON_VERSION} \
  && dnf clean all

# Install JDK
COPY --from=java8 /usr/lib/jvm/zulu8 /usr/local/openjdk-8
COPY --from=java11 /usr/lib/jvm/zulu11 /usr/local/openjdk-11
ENV JAVA_HOME=/usr/local/openjdk-${JDK_VERSION}
ENV PATH=${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin/:${PATH}

# Tooling
COPY --from=KAFKA_CLI /export/kafka_2.11-${KAFKA_VERSION} /usr/local/tools/kafka_cli
COPY --from=MONGO_SHELL /export/mongodb-linux-x86_64-ubuntu1804-${MONGO_VERSION} /usr/local/tools/mongodb_shell
COPY --from=AWS_CLI /export/aws /usr/local/tools/awscli
COPY --from=GCLOUD_SDK /export/google-cloud-sdk /usr/local/tools/gcloud-sdk
COPY --from=MAVEN /export/maven /usr/local/tools/maven

# Setup PATH
ENV PATH /usr/local/tools/kafka_cli/bin:/usr/local/tools/mongodb_shell/bin:${PATH}
RUN ln -s /usr/local/tools/maven/bin/mvn /usr/local/bin/ \
  && ln -s /usr/local/tools/awscli/v2/${AWS_VERSION}/bin/aws /usr/local/bin/ \
  && ln -s /usr/local/tools/gcloud-sdk/bin/gcloud /usr/local/bin/ \
  && ln -s /usr/local/tools/azure/az /usr/local/bin/
ENV MAVEN_HOME /usr/local/tools/maven

# Azure-CLI
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc \
  && echo $'[azure-cli]\nname=Microsoft - Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' > /etc/yum.repos.d/azure-cli.repo \
  && dnf install -y azure-cli-${AZURE_VERSION} \
  && rm -rf /etc/yum.repos.d/azure-cli.repo

# Install Node, Azure, NPM
RUN dnf module install -y nodejs:${NODE_VERSION} \
  && dnf clean all \
  && npm install -g nuxeo-cli yarn

# Create Nuxeo user
RUN adduser -u 900 -c '' --shell /usr/bin/zsh nuxeo \
  && mkdir -p /home/nuxeo/.m2/repository && chown -R nuxeo:nuxeo /home/nuxeo/.m2 \
  && mkdir -p /home/nuxeo/workspace && chown -R nuxeo:nuxeo /home/nuxeo/workspace \
  && mkdir -p /home/nuxeo/.vscode-server/extensions && chown -R nuxeo:nuxeo /home/nuxeo/.vscode-server \
  && mkdir -p /home/nuxeo/.vscode-server-insiders/extensions && chown -R nuxeo:nuxeo /home/nuxeo/.vscode-server-insiders \
  && echo "nuxeo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

VOLUME [ "/home/nuxeo/.m2/repository" ]
WORKDIR /home/nuxeo
