ARG THEIA_BUILDER
ARG DEV_BASE
FROM $THEIA_BUILDER AS builder
FROM $DEV_BASE

COPY --chown=nuxeo:nuxeo --from=builder /usr/local/theia /home/nuxeo

ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/home/nuxeo/plugins

RUN mkdir -p /home/nuxeo/.theia && chown -R nuxeo:nuxeo /home/nuxeo/.theia
VOLUME ["/home/nuxeo/.theia"]

ADD --chown=nuxeo:nuxeo settings.json /home/nuxeo/workspace/.theia/settings.json

EXPOSE 8080
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
