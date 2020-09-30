FROM docker.packages.nuxeo.com/nos-dev/dev-base:latest

RUN dnf install -y make python38 gcc-c++ \
  && dnf clean all

RUN mkdir -p /usr/local/theia
WORKDIR /usr/local/theia

ADD package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --cache-folder ./ycache && rm -rf ./ycache \
  && NODE_OPTIONS="--max_old_space_size=4096" yarn theia build \
  ; yarn theia download:plugins
