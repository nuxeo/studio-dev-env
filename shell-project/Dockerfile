FROM akervern/project-base as base

FROM akervern/dev-base:latest

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

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY --chown=nuxeo:nuxeo zshrc /home/nuxeo/.zshrc

COPY 99-exec-cmd.sh /docker-entrypoint-init.d/
# See: https://code.visualstudio.com/docs/remote/devcontainerjson-reference
COPY devcontainer.json /home/nuxeo/workspace/.devcontainer.json
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/tmux"]
