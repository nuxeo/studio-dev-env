#!/bin/sh
# If Docker socket mounted, fix permissions on it and create credentials file
if [[ -e /var/run/docker.sock ]]; then
  sudo chmod 666 /var/run/docker.sock

  # Configured Docker Credentials
  mkdir -p ${HOME}/.docker
  cat >${HOME}/.docker/config.json <<EOF
{
  "auths": {
    "docker-private.packages.nuxeo.com": {
      "auth": "$(echo -n "${NEXUS_USER_CODE}:${NEXUS_PASS_CODE}" | base64)"
    }
  },
  "HttpHeaders": {
    "User-Agent": "Docker-Client/19.03.13 (linux)"
  },
  "credHelpers" : {
    "marketplace.gcr.io" : "gcloud",
    "asia.gcr.io" : "gcloud",
    "us.gcr.io" : "gcloud",
    "eu.gcr.io" : "gcloud",
    "gcr.io" : "gcloud",
    "staging-k8s.gcr.io" : "gcloud"
  }
}
EOF

fi
