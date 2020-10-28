ARG NODE_VERSION=12
ARG CENTOS_VERSION=8

FROM centos:${CENTOS_VERSION}

ARG NODE_VERSION

RUN dnf install -y dnf-utils make python38 gcc-c++ \
  && dnf module install -y nodejs:${NODE_VERSION} \
  && npm install -g yarn \
  && dnf clean all

RUN mkdir -p /usr/local/theia
WORKDIR /usr/local/theia

ADD package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --cache-folder ./ycache && rm -rf ./ycache \
  && NODE_OPTIONS="--max_old_space_size=4096" yarn theia build \
  ; yarn theia download:plugins
