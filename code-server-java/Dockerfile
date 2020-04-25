# Code Server - Official image
FROM akervern/code-server-base:latest AS codeserver

# Ideally, we should install Java pack but server-code cannot find it yet.
# RUN code-server --install-extension vscjava.vscode-java-pack

RUN code-server --install-extension redhat.java \
  && code-server --install-extension vscjava.vscode-maven \
  && code-server --install-extension vscjava.vscode-java-test \
  && code-server --install-extension vscjava.vscode-java-debug \
  && code-server --install-extension vscjava.vscode-java-dependency \
  && code-server --install-extension dotjoshjohnson.xml

FROM openjdk:8 AS java8

# Maven 3 and JDK 11 - Official image
# Plus code-server execution requirements
FROM maven:3-jdk-11

RUN apt-get update \
  && apt-get install -y \
  curl \
  dumb-init \
  htop \
  locales \
  man \
  nano \
  git \
  procps \
  ssh \
  sudo \
  vim \
  && rm -rf /var/lib/apt/lists/*

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# Copy other JDK
COPY --from=java8 --chown=coder:coder /usr/local/openjdk-8 /usr/local/openjdk-8

# Install fixuid
RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
  chown root:root /usr/local/bin/fixuid && \
  chmod 4755 /usr/local/bin/fixuid && \
  mkdir -p /etc/fixuid && \
  printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml

# Copy codde-server
COPY --from=codeserver /usr/local/lib/code-server /usr/local/lib/code-server
COPY --from=codeserver --chown=coder:coder /home/coder/.local/share/code-server/ /home/coder/.local/share/code-server/
RUN ln -s /usr/local/lib/code-server/code-server /usr/local/bin/code-server

# Add settings
RUN mkdir -p /home/coder/project/.vscode && chown -R coder:coder /home/coder/project
ADD --chown=coder:coder settings.json /home/coder/project/.vscode/settings.json

VOLUME ["/home/coder/.local/share/code-server/User"]
