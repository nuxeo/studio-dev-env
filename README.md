# Studio Dev Environment

> Work in progress.

This repository contains a bench of Docker images to POC different approach around a [Nuxeo Studio](https://www.nuxeo.com/fr/produits/studio/) projects.

## Content

**Agnostic Images description:**

- `dev-base`: Initialize shared developer tooling, and create `nuxeo` user. It contains:

  - Development tooling: NodeJS, NPM, Maven, Docker CLI, Docker Compose, Zulu OpenJDK8, Zulu OpenJDK11 and Nuxeo CLI
  - Third parties CLIs: Kafka CLI and Mongo Shell, GCloud SDK, Azure CLI and AWS CLI.

- `project-base`: Contains shared entrypoints to configure Maven Settings, global Environment variables, Git Credentials, ...
- `shell-project`: Multi-stage image with `dev-base` and `project-base` to start a full development environment. It adds `devcontainer.json` file to be able to user [Visual Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers) plugin.

**Code-Server Images:**

[Code-Server](https://github.com/cdr/code-server) is a VS Code fork allowing you to run it everywhere.

- `core-server-base`: Installs and configure Code-Server
- `core-server-project`: Multi-stage image with `code-server-base` and `project-base` to start a full development environment that exposes Code-Server as main IDE.

*Notes:*

- User Settings are stored and exposed as a volume from `/home/nuxeo/.local/share/code-server/User`. Use Docker [mount option](https://docs.docker.com/storage/volumes/) `--mount "source=my-settings,target=/home/nuxeo/.local/share/code-server/User"` to share settings between container's executions.

**Theia Images:**

[Eclipse Theia](https://github.com/eclipse-theia/theia) is an extensible platform to develop full-fledged multi-language Cloud & Desktop IDE-like products with state-of-the-art web technologies.

- `theia-builder`: Builds a Theia IDE.
- `theia-base`: Installs and configure Theia
- `theia-project`: Multi-stage image with `theia-base` and `project-base` to start a full development environment that exposes Theia as main IDE.

*Notes:*

- User Settings are stored and exposed as a volume from `/home/nuxeo/.theia`. Use Docker [mount option](https://docs.docker.com/storage/volumes/) `--mount "source=my-settings,target=/home/nuxeo/.theia"` to share settings between container's executions.

## Scripts

A few helper scripts are available in that repository:

- `bootstrap-project.sh`: Prototype script that bootstraps a bare Nuxeo project wrapping required tools ([Nuxeo CLI](https://doc.nuxeo.com/nxdoc/nuxeo-cli/), Maven, Java, Node,...) within Docker run using `dev-base` image.
- `start-(ide|shell).sh`: Quickly start a dev environment based previously built images. You **must** create a local `.env.nuxeo-cli` file that will be mounted within the container.

## Configure Cloud Provider

TODO: Describe how to inject, or persist, provider's credentials and execution context between container's run.

### GCloud SDK

XXX `~/.config/gcloud`?

### Azure CLI

XXX

### AWS CLI

XXX

## Dotenv File Usage

Configuration and secrets are passed to the environment using a dotenv (`.env.nuxeo-cli` file) file.

It must contain the following variables:

```shell
# NOS - Studio access and package download:
# - Documentation: https://doc.nuxeo.com/studio/token-management
# - NOS: https://connect.nuxeo.com
NOS_USERNAME=nos_username
NOS_TOKEN=nos_token
NOS_PROJECT=nos_project
# Nexus - Maven / NPM:
# - Documentation: https://help.sonatype.com/iqserver/automating/rest-apis/user-token-rest-api---v2#UserTokenRESTAPI-v2-CreatingaUserToken
# - Nexus: https://packages.nuxeo.com
NEXUS_USER_CODE=user_code
NEXUS_PASS_CODE=pass_code
# Optional(s):
# NOS_URL=https://connect.nuxeo.com/nuxeo
# GIT_USER_EMAIL=devnull@nuxeo.com
# GIT_USER_NAME=username
```

The [environment loading script](./project-base/docker-entrypoin-init.d/00-envs.sh) is looking for the `.env.nuxeo-cli` file in `{HOME}/workspace` and any subfolders. For instance, it can exist within the project folder as well. Loaded in the `find` cmd return order; which is deepest file first. Last loaded file is `{HOME}/workspace/.env.nuxeo-cli` if exists.

## Build

With [Skaffold](https://skaffold.dev/) to build and test images:

```bash
./run-skaffold.sh
```

Or, Docker images can be built one by one; following the regular build command:

```bash
docker build -t docker.packages.nuxeo.com/nos-dev/dev-base dev-base
...
```

## Tests

Images are during Skaffold build using Google [Container Structure Test](https://github.com/GoogleContainerTools/container-structure-test) Framework.

Test files can be found in `./tests/*`.

## References

- [Visual Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers#_getting-started)
- [Using Remote Docker Host](https://code.visualstudio.com/docs/remote/containers-advanced#_developing-inside-a-container-on-a-remote-docker-host)
- [Visual Code Remote - SSH](https://code.visualstudio.com/docs/remote/ssh-tutorial)
- [Dev Containers Repository](https://github.com/Microsoft/vscode-dev-containers)
- [devcontainer.json Reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)
- [Theia IDE](https://theia-ide.org)
- [Theia Extension Authoring](https://theia-ide.org/docs/authoring_extensions)
- [Visual Code Extension Authoring](https://code.visualstudio.com/api)

## About Nuxeo

Nuxeo dramatically improves how content-based applications are built, managed and deployed, making customers more agile, innovative and successful. Nuxeo provides a next generation, enterprise ready platform for building traditional and cutting-edge content oriented applications. Combining a powerful application development environment with SaaS-based tools and a modular architecture, the Nuxeo Platform and Products provide clear business value to some of the most recognizable brands including Verizon, Electronic Arts, Sharp, FICO, the U.S. Navy, and Boeing. Nuxeo is headquartered in New York and Paris. More information is available at [www.nuxeo.com](http://www.nuxeo.com).
