ARG PROJECT_BASE
FROM $PROJECT_BASE as base

ARG DEV_BASE
FROM $DEV_BASE

COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint.sh /
COPY --from=base --chown=nuxeo:nuxeo /docker-entrypoint-init.d /docker-entrypoint-init.d/

USER nuxeo

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY --chown=nuxeo:nuxeo zshrc /home/nuxeo/.zshrc

COPY 99-exec-cmd.sh /docker-entrypoint-init.d/
COPY --chown=nuxeo:nuxeo settings.json /home/nuxeo/workspace/.vscode/settings.json

WORKDIR "/home/nuxeo/workspace"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/tmux"]
