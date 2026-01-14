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

# Install rclone
RUN curl -fsSL https://rclone.org/install.sh | bash

# Install MinIO client (mc)
RUN curl -fsSL "https://dl.min.io/client/mc/release/linux-$(dpkg --print-architecture)/mc" -o /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc

WORKDIR /root
CMD ["bash"]
