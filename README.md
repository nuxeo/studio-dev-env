# Studio VSCode

> Work in progress.

This repository contains a bench of Docker images to POC different approach around a [Nuxeo Studio](https://www.nuxeo.com/fr/produits/studio/) projects.

## Content

Agnostic Images description:

- `dev-base`: Contains developer tooling like NodeJS, Maven, Java, ...
- `project-base`: Contains shared entrypoints to configure Maven Settings, global Environment variables, Git Credentials, ...
- `shell-project`: Multi-stage image with `dev-base` and `project-base` using `nuxeo` user to start a full development environment. It adds `devcontainer.json` file to be able to user [Visual Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers) plugin.

Code-Server Images:

[Code-Server](https://github.com/cdr/code-server) is a VS Code fork allowing you to run it everywhere.

- `core-server-base`: Installs and configure Code-Server
- `core-server-project`: Multi-stage image with `code-server-base` and `project-base` using `coder` user to start a full development environment that exposes Code-Server as main IDE.

Theia Images:

[Eclipse Theia](https://github.com/eclipse-theia/theia) is an extensible platform to develop full-fledged multi-language Cloud & Desktop IDE-like products with state-of-the-art web technologies.

- `theia-builder`: Builds a Theia IDE.
- `theia-base`: Installs and configure Theia
- `theia-project`: Multi-stage image with `theia-base` and `project-base` using `theia` user to start a full development environment that exposes Theia as main IDE.

## Scripts

- `bootstrap-project.sh`: Prototype script that bootstraps a bare Nuxeo project wrapping required tools ([Nuxeo CLI](https://doc.nuxeo.com/nxdoc/nuxeo-cli/), Maven, Java, Node,...) within Docker run using `dev-base` image.
- `start-(ide|shell).sh: Test scripts to start a dev environment.

## Build

With [Skaffold](https://skaffold.dev/) to build and test images:

```bash
./run-skaffold.sh
```

Or, Docker images can be built one by one; following the regular build command:

```bash
docker build -t akervern/dev-base dev-base
...
```

## About Nuxeo

Nuxeo dramatically improves how content-based applications are built, managed and deployed, making customers more agile, innovative and successful. Nuxeo provides a next generation, enterprise ready platform for building traditional and cutting-edge content oriented applications. Combining a powerful application development environment with SaaS-based tools and a modular architecture, the Nuxeo Platform and Products provide clear business value to some of the most recognizable brands including Verizon, Electronic Arts, Sharp, FICO, the U.S. Navy, and Boeing. Nuxeo is headquartered in New York and Paris. More information is available at [www.nuxeo.com](http://www.nuxeo.com).
