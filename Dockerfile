FROM ubuntu:jammy

RUN echo "Installing basic packages" && \
    apt update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
      ca-certificates \
      gnupg \
      tzdata \
      bash \
      zsh \
      curl \
      grep \
      git \
      tmux \
      neovim \
      exa

RUN echo "Installing PNPM" && \
    PNPM_VERSION=$(curl -s "https://api.github.com/repos/pnpm/pnpm/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+') && \
    curl -fsSL "https://github.com/pnpm/pnpm/releases/download/v${PNPM_VERSION}/pnpm-linuxstatic-x64" -o /bin/pnpm && \
    chmod +x /bin/pnpm

COPY ./home-dev /root

RUN echo "Setting up ZSH" && \ 
    git clone https://github.com/ohmyzsh/ohmyzsh.git /root/.oh-my-zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.zsh-plugins/zsh-syntax-highlighting

RUN echo "Setting nvm" && \
    git clone https://github.com/nvm-sh/nvm.git /root/.nvm && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install --lts

RUN echo "Installing Docker" && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update && \
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
