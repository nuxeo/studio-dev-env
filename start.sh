#docker run --rm -it -p 127.0.0.1:8080:8080 -v "/Users/arnaud/Nuxeo/sources/tmp/toto:/home/coder/project/project" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" -e "EXTENSIONS=redhat.java,vscjava.vscode-maven" akervern/studio-code-server:latest

# Start CodeServer-Project
#docker run --rm -it -p 127.0.0.1:8080:8080 -v "/Users/arnaud/Nuxeo/tmp/toto-vscode:/home/coder/project/project" -v "/Users/arnaud/.m2/repository:/home/coder/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" -e "EXTENSIONS=''" akervern/project-code-server:latest

# Start Theia
docker run --rm -it -p 127.0.0.1:8080:8080 -v "/Users/arnaud/Nuxeo/tmp/toto-vscode:/home/project/project" -v "/Users/arnaud/.m2/repository:/home/theia/.m2/repository" -e "PROJECT=akervern-SANDBOX" -e "USERNAME=akervern" -e "TOKEN=${TOKEN}" akervern/project-theia:latest