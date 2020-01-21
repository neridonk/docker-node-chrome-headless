FROM ubuntu:latest

MAINTAINER ACCENON®
LABEL vendor="ACCENON®"
LABEL tools="chrome node npm yarn"

# Install deps
RUN apt-get update && apt-get install -y \
    git \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    python-pip \
    python2.7 \
    python2.7-dev \
    groff-base \
    build-essential \
    --no-install-recommends

# Get Chrome sources
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Install Chrome 76
# https://www.ubuntuupdates.org/ppa/google_chrome?dist=stable
ENV CHROME_VERSION=79.0.3945.130-1

RUN apt-get update && apt-get install -y \
    google-chrome-stable=$CHROME_VERSION \
    --no-install-recommends

# Get yarn sources
RUN curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Install yarn
# https://www.ubuntuupdates.org/ppa/yarn?dist=stable
ENV YARN_VERSION=1.15.2-1

RUN apt-get update && apt-get install -y \
    yarn=$YARN_VERSION \
    --no-install-recommends

# Find your desired version here: https://deb.nodesource.com/node_12.x/pool/main/n/nodejs/
# Ubuntu 16.04.3 LTS (Xenial Xerus) (https://wiki.ubuntu.com/Releases)
ENV NODE_VERSION=12.8.1

RUN curl https://deb.nodesource.com/node_12.x/pool/main/n/nodejs/nodejs_$NODE_VERSION-1nodesource1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb
