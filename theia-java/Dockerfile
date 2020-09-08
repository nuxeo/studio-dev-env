FROM openjdk:11 AS java11

FROM akervern/theia-base:latest

HEALTHCHECK CMD curl --fail http://localhost:3000/ || exit 1

COPY --from=java11 /usr/local/openjdk-11 /opt/openjdk/java-11

ADD package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --cache-folder ./ycache && rm -rf ./ycache && \
  NODE_OPTIONS="--max_old_space_size=4096" yarn theia build ; \
  yarn theia download:plugins
EXPOSE 3000
ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

RUN mkdir -p /home/theia/.theia && chown -R theia:theia /home/theia/.theia
VOLUME ["/home/theia/.theia"]

RUN mkdir -p /home/project/.theia && chown -R theia:theia /home/project
ADD --chown=theia:theia settings.json /home/project/.theia/settings.json
