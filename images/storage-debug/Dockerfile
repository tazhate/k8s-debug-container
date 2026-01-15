FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Storage and I/O debugging tools for Kubernetes"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    jq \
    fio \
    iotop \
    sysstat \
    hdparm \
    smartmontools \
    lsof \
    strace \
    blktrace \
    btrfs-progs \
    xfsprogs \
    e2fsprogs \
    parted \
    gdisk \
    ncdu \
    tree \
    pv \
    s3cmd \
    && rm -rf /var/lib/apt/lists/*

# Install rclone (download binary directly, install.sh fails in CI)
RUN ARCH=$(dpkg --print-architecture) && \
    curl -fsSL "https://downloads.rclone.org/rclone-current-linux-${ARCH}.zip" -o /tmp/rclone.zip && \
    apt-get update && apt-get install -y --no-install-recommends unzip && \
    unzip /tmp/rclone.zip -d /tmp && \
    cp /tmp/rclone-*/rclone /usr/local/bin/ && \
    chmod +x /usr/local/bin/rclone && \
    rm -rf /tmp/rclone* && \
    apt-get purge -y unzip && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install MinIO client (mc)
RUN curl -fsSL "https://dl.min.io/client/mc/release/linux-$(dpkg --print-architecture)/mc" -o /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc

# Install s5cmd (fast S3 client)
RUN S5CMD_VERSION=$(curl -s https://api.github.com/repos/peak/s5cmd/releases/latest | jq -r '.tag_name') && \
    ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
        amd64) S5_ARCH="64bit" ;; \
        arm64) S5_ARCH="arm64" ;; \
        *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/peak/s5cmd/releases/download/${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION#v}_Linux-${S5_ARCH}.tar.gz" | tar xzf - -C /usr/local/bin s5cmd

WORKDIR /root
CMD ["bash"]
