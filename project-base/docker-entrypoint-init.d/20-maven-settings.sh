#!/bin/sh

# Template Maven Settings.xml file
cat >${HOME}/.m2/settings.xml <<EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                           http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <!-- Nuxeo Connect Credentials -->
      <id>nuxeo-studio</id>
      <username>${USERNAME}</username>
      <password>${TOKEN}</password>
    </server>
  </servers>
</settings>
EOF
