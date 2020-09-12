FROM akervern/theia-builder:latest AS theia

FROM akervern/dev-base:latest

RUN adduser -c '' --shell /bin/bash theia;

COPY --chown=theia:theia --from=theia /usr/local/theia /home/theia

USER theia

WORKDIR /home/theia

ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

RUN mkdir -p /home/theia/.theia && chown -R theia:theia /home/theia/.theia
VOLUME ["/home/theia/.theia"]

RUN mkdir -p /home/theia/workspace/.theia && chown -R theia:theia /home/theia/workspace \
  && mkdir -p /home/theia/.m2/repository && chown -R theia:theia /home/theia/.m2
ADD --chown=theia:theia settings.json /home/theia/workspace/.theia/settings.json

HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
