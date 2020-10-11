# BASE STAGE: Minimal install for what is required for the SDK to run
FROM ubuntu:20.04 AS base

ARG DEBIAN_FRONTEND=noninteractive

# Install needed applications for running the SDK
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential=12.8ubuntu1 \
      ca-certificates=20190110ubuntu1.1 \
      clang=1:10.0-50~exp1 \
      curl=7.68.0-1ubuntu2.2 \
      libicu66=66.1-2ubuntu2 \
      lld=1:10.0-50~exp1 \
      tar=1.30+dfsg-7 && \
    rm -rf /var/lib/apt/lists/*

ENV OO_PS4_TOOLCHAIN=/lib/OpenOrbisSDK
ENV PATH=$OO_PS4_TOOLCHAIN:$OO_PS4_TOOLCHAIN/bin/linux:$PATH

RUN mkdir -p $OO_PS4_TOOLCHAIN && \
    mkdir -p /tmp/toolchain-cache

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# If we could specify build-args in the action.yml... this should be a feature the docker file could be trimmed to this:

#ARG VERSION

#FROM openorbis/toolchain:${VERSION}

#COPY entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

# This would also shrink the size and complexity of entrypoint.sh... a lot
