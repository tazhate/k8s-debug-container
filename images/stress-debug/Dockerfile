FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Stress testing and benchmarking tools for Kubernetes"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    # Stress testing
    stress-ng \
    # CPU/Memory benchmarks
    sysbench \
    # I/O benchmarks
    fio \
    iotop \
    ioping \
    bonnie++ \
    # Network benchmarks
    iperf3 \
    # System monitoring during tests
    htop \
    sysstat \
    dstat \
    procps \
    # Utilities
    jq \
    bc \
    time \
    && rm -rf /var/lib/apt/lists/*

# Install hey (HTTP load generator)
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL "https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_${ARCH}" -o /usr/local/bin/hey && \
    chmod +x /usr/local/bin/hey

WORKDIR /root
CMD ["bash"]
