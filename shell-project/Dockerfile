FROM akervern/project-base as base

FROM akervern/dev-base:latest

RUN adduser -c '' --shell /bin/bash nuxeo \
  && mkdir -p /home/nuxeo/.m2/repository && chown -R nuxeo:nuxeo /home/nuxeo/.m2 \
  && mkdir -p /home/nuxeo/workspace && chown -R nuxeo:nuxeo /home/nuxeo/workspace

# NOS Image related
ENV CONNECT_URL=https://connect.nuxeo.com/nuxeo
ENV PROJECT=dummy
ENV USERNAME=studio-user
ENV TOKEN=tmp-pwd
ENV GIT_USER_EMAIL=devnull@nuxeo.com
ENV GIT_USER_NAME=${USERNAME}

COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint.sh /
COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER nuxeo

VOLUME [ "/home/nuxeo/.m2/repository" ]
WORKDIR /home/nuxeo

COPY 99-exec-cmd.sh /docker-entrypoint-init.d/
# See: https://code.visualstudio.com/docs/remote/devcontainerjson-reference
COPY devcontainer.json /home/nuxeo/workspace/.devcontainer.json
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
