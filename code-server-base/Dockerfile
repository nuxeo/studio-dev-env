# Code Server - Official image
FROM codercom/code-server:3.6.1 AS codeserver

# Ideally, we should install Java pack but server-code cannot find it yet.
RUN code-server --install-extension vscjava.vscode-java-pack \
  && code-server --install-extension redhat.vscode-xml
# RUN code-server --install-extension redhat.java \
#   && code-server --install-extension vscjava.vscode-maven \
#   && code-server --install-extension vscjava.vscode-java-test \
#   && code-server --install-extension vscjava.vscode-java-debug \
#   && code-server --install-extension vscjava.vscode-java-dependency \
#   && code-server --install-extension lgdd.vscode-osgi \
#   && code-server --install-extension dotjoshjohnson.xml

# Mutli-taged with dev image
ARG DEV_BASE
FROM $DEV_BASE

# Install dumb-init
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
  && chmod 4755 /usr/local/bin/dumb-init

# Copy codde-server
COPY --from=codeserver /usr/lib/code-server /usr/local/lib/code-server
COPY --from=codeserver --chown=nuxeo:nuxeo /home/coder/.local/share/code-server/ /home/nuxeo/.local/share/code-server/
RUN ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server

# Add settings
ADD --chown=nuxeo:nuxeo settings.json /home/nuxeo/workspace/.vscode/settings.json

VOLUME ["/home/nuxeo/.local/share/code-server/User"]

EXPOSE 8080
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
