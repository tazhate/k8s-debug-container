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

# Install hey (HTTP load generator) - build from source since S3 downloads blocked in CI
RUN ARCH=$(dpkg --print-architecture) && \
    GO_VERSION="1.21.6" && \
    case "$ARCH" in \
        amd64) GO_ARCH="amd64" ;; \
        arm64) GO_ARCH="arm64" ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" -o /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    /usr/local/go/bin/go install github.com/rakyll/hey@latest && \
    mv /root/go/bin/hey /usr/local/bin/hey && \
    rm -rf /tmp/go.tar.gz /usr/local/go /root/go

WORKDIR /root
CMD ["bash"]
