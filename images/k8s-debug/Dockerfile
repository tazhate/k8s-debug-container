FROM debian:bookworm-slim

LABEL maintainer="tazhate"
LABEL description="Kubernetes management tools for debugging"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    wget \
    ca-certificates \
    jq \
    git \
    vim-tiny \
    less \
    fzf \
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

WORKDIR /root
CMD ["bash"]
