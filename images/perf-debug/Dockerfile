FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Performance profiling and monitoring tools for Kubernetes"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    jq \
    htop \
    iotop \
    strace \
    ltrace \
    sysstat \
    linux-perf \
    bpfcc-tools \
    procps \
    psmisc \
    lsof \
    dstat \
    atop \
    nmon \
    numactl \
    cpuid \
    stress-ng \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["bash"]
