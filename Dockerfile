FROM ubuntu
RUN apt update
RUN apt install -y \
  bash \
  htop \ 
  iotop \
  net-tools \
  tcpdump \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

