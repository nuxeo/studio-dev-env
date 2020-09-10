FROM akervern/theia-builder:latest AS theia

FROM akervern/dev-base:latest

RUN chmod g+rw /home && \
  adduser -c '' --shell /bin/bash theia \
  && mkdir -p /home/project \
  && chown -R theia:theia /home/theia \
  && chown -R theia:theia /home/project;

COPY --chown=theia:theia --from=theia /usr/local/theia /home/theia

USER theia

WORKDIR /home/theia

ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

RUN mkdir -p /home/theia/.theia && chown -R theia:theia /home/theia/.theia
VOLUME ["/home/theia/.theia"]

RUN mkdir -p /home/theia/project/.theia && chown -R theia:theia /home/theia/project/ \
  && mkdir -p /home/theia/.m2 && chown -R theia:theia /home/theia/.m2
ADD --chown=theia:theia settings.json /home/theia/project/.theia/settings.json

HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
