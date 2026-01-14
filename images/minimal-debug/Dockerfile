FROM alpine:3.19

LABEL maintainer="tazhate"
LABEL description="Minimal debugging tools for Kubernetes (Alpine-based)"

RUN apk add --no-cache \
    bash \
    curl \
    wget \
    ca-certificates \
    busybox-extras \
    bind-tools \
    jq \
    vim \
    less \
    iputils \
    iproute2 \
    netcat-openbsd \
    tcpdump \
    mtr \
    openssl

WORKDIR /root
CMD ["bash"]
