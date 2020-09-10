FROM akervern/project-base as base

# Final Image
FROM akervern/theia-base:latest

# NOS Image related
ENV CONNECT_URL=https://connect.nuxeo.com/nuxeo
ENV PROJECT=dummy
ENV USERNAME=studio-user
ENV TOKEN=tmp-pwd
ENV GIT_USER_EMAIL=devnull@nuxeo.com
ENV GIT_USER_NAME=${USERNAME}

COPY --from=base --chown=theia:theia /docker-entrypoint.sh /
COPY --from=base --chown=theia:theia /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER theia

VOLUME [ "/home/theia/.m2/repository" ]
WORKDIR /home/theia
EXPOSE 8080

COPY 99-start-ide.sh /docker-entrypoint-init.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
