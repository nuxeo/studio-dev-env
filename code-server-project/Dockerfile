FROM docker.packages.nuxeo.com/nos-dev/project-base as base

# Final Image
FROM docker.packages.nuxeo.com/nos-dev/code-server-base:latest

# Code Server additional extension
ENV EXTENSIONS=

COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint.sh /
COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER nuxeo

COPY 99-start-ide.sh /docker-entrypoint-init.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
