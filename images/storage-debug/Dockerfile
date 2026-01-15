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

WORKDIR /root
CMD ["bash"]
