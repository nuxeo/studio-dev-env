FROM docker.packages.nuxeo.com/nos-dev/project-base as base

FROM docker.packages.nuxeo.com/nos-dev/dev-base:latest

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
