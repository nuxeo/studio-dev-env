ARG PROJECT_BASE
FROM $PROJECT_BASE as base

# Final Image
ARG CODE_SERVER_BASE
FROM $CODE_SERVER_BASE

# Code Server additional extension
ENV EXTENSIONS=

COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint.sh /
COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER nuxeo

COPY 99-start-ide.sh /docker-entrypoint-init.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
