FROM --platform=linux/amd64 ubuntu:22.04

# This Dockerfile is configured for AMD64 architecture only
ARG DEBIAN_FRONTEND=noninteractive

# Install SDK dependencies as mentioned in the README
RUN apt-get update && apt-get install -y \
    git \
    ssh \
    make \
    gcc \
    g++-multilib \
    gcc-multilib \
    module-assistant \
    expect \
    g++ \
    gawk \
    texinfo \
    libssl-dev \
    bison \
    flex \
    fakeroot \
    cmake \
    unzip \
    gperf \
    autoconf \
    device-tree-compiler \
    libncurses5-dev \
    pkg-config \
    bc \
    python3 \
    passwd \
    openssl \
    openssh-server \
    openssh-client \
    vim \
    file \
    cpio \
    rsync \
    curl \
    wget \
    sudo \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up Python symlink for python-is-python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Set up locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m vscode \
    && echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

# Switch to the non-root user
USER vscode
WORKDIR /home/vscode

# Create workspace directory and set ownership
RUN sudo mkdir -p /workspace && sudo chown vscode:vscode /workspace
WORKDIR /workspace

# Set up bash as default shell
ENV SHELL /bin/bash

# Set up the SDK environment
RUN echo 'echo "Luckfox Pico SDK Development Environment"' >> ~/.bashrc
RUN echo 'echo "Run ./build.sh lunch to configure and start building"' >> ~/.bashrc
