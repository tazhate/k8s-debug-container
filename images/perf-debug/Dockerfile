FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Performance profiling and monitoring tools for Kubernetes"

ENV DEBIAN_FRONTEND=noninteractive

# Note: ltrace and cpuid are not available on arm64
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    jq \
    htop \
    iotop \
    strace \
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
    stress-ng \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["bash"]
