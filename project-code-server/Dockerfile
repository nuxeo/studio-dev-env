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

USER coder
ADD --chown=coder:coder entrypoint.sh /entrypoint.sh

VOLUME [ "/home/coder/.m2/repository" ]
WORKDIR /home/coder
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
