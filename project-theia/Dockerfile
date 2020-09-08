# Final Image
FROM akervern/theia-java:latest

# NOS Image related
ENV CONNECT_URL=https://connect.nuxeo.com/nuxeo
ENV PROJECT=dummy
ENV USERNAME=studio-user
ENV TOKEN=tmp-pwd
ENV GIT_USER_EMAIL=devnull@nuxeo.com
ENV GIT_USER_NAME=${USERNAME}

USER theia
ADD --chown=theia:theia entrypoint.sh /entrypoint.sh

VOLUME [ "/home/theia/.m2/repository" ]

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
