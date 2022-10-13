# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.231.6/containers/javascript-node/.devcontainer/base.Dockerfile

# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 16, 14, 12, 16-bullseye, 14-bullseye, 12-bullseye, 16-buster, 14-buster, 12-buster
ARG VARIANT="16-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# [Optional] Uncomment this section to install additional packages.
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl git python3-setuptools python3-pip bash-completion yarn \
    && sed -i -e "35,41s:^#::" /etc/bash.bashrc
RUN curl https://getsubstrate.io -sSf | bash -s -- --fast

WORKDIR /tmp

# Add astar
ENV ASTAR_VERSION=3.27.0
ENV ASTAR_CONTROLLER_URL=https://github.com/AstarNetwork/Astar/releases/download/v{$ASTAR_VERSION}/astar-collator-${ASTAR_VERSION}-ubuntu-x86_64.tar.gz
RUN curl -L -o astar.tar.gz ${ASTAR_CONTROLLER_URL} \
    && tar -xvf astar.tar.gz \
    && chmod +x ./astar-collator \
    && mv astar-collator /usr/local/bin \
    && rm -f astar.tar.gz

# Add foundry
ENV FOUNDRY_URL https://github.com/foundry-rs/foundry/releases/download/nightly/foundry_nightly_linux_amd64.tar.gz
RUN curl -L -o foundry.tar.gz ${FOUNDRY_URL} \
    && tar -zxvf foundry.tar.gz \
    && chmod +x ./anvil ./cast ./forge \
    && mv anvil cast forge /usr/local/bin \
    && rm -f foundry.tar.gz
