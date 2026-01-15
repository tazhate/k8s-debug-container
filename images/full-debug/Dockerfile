FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Full debugging toolkit for Kubernetes - all tools included"

ENV DEBIAN_FRONTEND=noninteractive

# Install all system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Base
    bash \
    curl \
    wget \
    ca-certificates \
    jq \
    git \
    vim-tiny \
    less \
    fzf \
    gnupg \
    # Network tools
    tcpdump \
    nmap \
    netcat-openbsd \
    iperf3 \
    dnsutils \
    traceroute \
    mtr-tiny \
    httpie \
    openssl \
    socat \
    tshark \
    iproute2 \
    iputils-ping \
    net-tools \
    telnet \
    host \
    whois \
    ngrep \
    iftop \
    bmon \
    arp-scan \
    arping \
    fping \
    hping3 \
    # Database clients
    postgresql-client \
    default-mysql-client \
    redis-tools \
    sqlite3 \
    # Storage tools
    fio \
    iotop \
    sysstat \
    hdparm \
    smartmontools \
    lsof \
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
    # Performance tools (ltrace and cpuid not available on arm64)
    htop \
    strace \
    linux-perf \
    bpfcc-tools \
    procps \
    psmisc \
    dstat \
    atop \
    nmon \
    numactl \
    stress-ng \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

# Install mongosh
RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" > /etc/apt/sources.list.d/mongodb-org-7.0.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends mongodb-mongosh \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -fsSL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install k9s
RUN K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r '.tag_name') \
    && curl -fsSL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_$(dpkg --print-architecture).tar.gz" | tar xzf - -C /usr/local/bin k9s

# Install stern
RUN STERN_VERSION=$(curl -s https://api.github.com/repos/stern/stern/releases/latest | jq -r '.tag_name') \
    && curl -fsSL "https://github.com/stern/stern/releases/download/${STERN_VERSION}/stern_${STERN_VERSION#v}_linux_$(dpkg --print-architecture).tar.gz" | tar xzf - -C /usr/local/bin stern

# Install kubectx and kubens
RUN KUBECTX_VERSION=$(curl -s https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq -r '.tag_name') \
    && curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_$(uname -m | sed 's/aarch64/arm64/' | sed 's/x86_64/x86_64/').tar.gz" | tar xzf - -C /usr/local/bin kubectx \
    && curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens_${KUBECTX_VERSION}_linux_$(uname -m | sed 's/aarch64/arm64/' | sed 's/x86_64/x86_64/').tar.gz" | tar xzf - -C /usr/local/bin kubens

# Install kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash \
    && mv kustomize /usr/local/bin/

# Install yq
RUN YQ_VERSION=$(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.tag_name') \
    && curl -fsSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_$(dpkg --print-architecture)" -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# Install bat
RUN BAT_VERSION=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r '.tag_name') \
    && curl -fsSL "https://github.com/sharkdp/bat/releases/download/${BAT_VERSION}/bat-${BAT_VERSION}-$(uname -m)-unknown-linux-gnu.tar.gz" | tar xzf - --strip-components=1 -C /usr/local/bin "bat-${BAT_VERSION}-$(uname -m)-unknown-linux-gnu/bat"

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
