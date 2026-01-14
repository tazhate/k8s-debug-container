FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Network debugging tools for Kubernetes"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    tcpdump \
    nmap \
    netcat-openbsd \
    iperf3 \
    dnsutils \
    traceroute \
    mtr-tiny \
    httpie \
    jq \
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
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["bash"]
