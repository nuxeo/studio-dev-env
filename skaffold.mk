skaffold.yaml:
	echo "$${skaffold_template}" | sh -s > $(@)

.PHONY: skaffold.yaml

export skaffold_template
define skaffold_template :=
cat <<!
---
apiVersion: skaffold/v1
kind: Config
build:
  artifacts:
!
for container in $(containers); do
cat <<!
    - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/$${container}
      context: $${container}
      docker: {}
!
done
cat <<!
test:
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/dev-base
    structureTests:
      - ./tests/base-java.yml
      - ./tests/base-nodejs.yml
      - ./tests/base-cloud.yml
      - ./tests/base-nuxeo-tools.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/project-base
    structureTests:
      - ./tests/base-entrypoints.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/shell-project
    structureTests:
      - ./tests/base-java.yml
      - ./tests/base-entrypoints.yml
      - ./tests/base-nodejs.yml
      - ./tests/base-cloud.yml
      - ./tests/base-nuxeo-tools.yml
      - ./tests/base-entrypoints.yml
      - ./tests/shell-project.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/code-server-base
    structureTests:
      - ./tests/code-server.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/theia-base
    structureTests:
      - ./tests/theia.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/code-server-project
    structureTests:
      - ./tests/base-java.yml
      - ./tests/base-entrypoints.yml
      - ./tests/base-nodejs.yml
      - ./tests/base-cloud.yml
      - ./tests/base-nuxeo-tools.yml
      - ./tests/base-project.yml
      - ./tests/code-server.yml
      - ./tests/code-server-project.yml
  - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/theia-project
    structureTests:
      - ./tests/base-java.yml
      - ./tests/base-entrypoints.yml
      - ./tests/base-nodejs.yml
      - ./tests/base-cloud.yml
      - ./tests/base-nuxeo-tools.yml
      - ./tests/base-project.yml
      - ./tests/theia.yml
      - ./tests/theia-project.yml
!
cat <<!
deploy: {}

profiles:
  - name: dev
    activation:
      - command: dev
    build:
      local:
        push: false
      tagPolicy:
        sha256: {}
  - name: jxlabs-nos
    build:
      cluster:
        namespace: ${JX_NAMESPACE}
        pullSecretName: kaniko-secret
        dockerConfig:
          secretName: kaniko-docker-cfg
        resources:
          requests:
            cpu: 2
            memory: 2Gi
          limits:
            cpu: 4
            memory: 4Gi
      tagPolicy:
        envTemplate:
          template: "{{.IMAGE_NAME}}:{{.VERSION}}"
      artifacts:
!
for container in $(containers); do
cat <<!
        - image: $(DOCKER_REGISTRY)/$(DOCKER_REGISTRY_ORG)/$${container}
          kaniko:
            image: gcr.io/kaniko-project/executor:v1.2.0
            dockerfile: $${container}/Dockerfile
            cache: {}
!
done
endef
