#!/bin/sh

# Template Maven Settings.xml file
cat >${HOME}/.m2/settings.xml <<EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                           http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <!-- Nuxeo Connect Server -->
    <server>
      <id>nuxeo-studio</id>
      <username>${NOS_USERNAME}</username>
      <password>${NOS_TOKEN}</password>
    </server>
    <!-- Nuxeo Internal Server -->
    <server>
      <id>maven-internal</id>
      <username>${NEXUS_USER_CODE}</username>
      <password>${NEXUS_PASS_CODE}</password>
    </server>
  </servers>
</settings>
EOF
