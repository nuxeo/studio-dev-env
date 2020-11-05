FROM docker.packages.nuxeo.com/nos-dev/dev-base:latest

WORKDIR /home/nuxeo/workspace

# XXX Use NuxeoCLI#master
RUN npm install -g nuxeo/nuxeo-cli#master

COPY docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
