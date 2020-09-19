FROM akervern/project-base as base

# Final Image
FROM akervern/code-server-base:latest

# NOS Image related
ENV CONNECT_URL=https://connect.nuxeo.com/nuxeo
ENV PROJECT=dummy
ENV USERNAME=studio-user
ENV TOKEN=tmp-pwd
ENV GIT_USER_EMAIL=devnull@nuxeo.com
ENV GIT_USER_NAME=${USERNAME}
ENV EXTENSIONS=

COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint.sh /
COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER nuxeo

COPY 99-start-ide.sh /docker-entrypoint-init.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
