FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

# System packages (build-essential provides cc/c++ for compiling treesitter parsers)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates curl git locales make sudo tmux unzip zsh \
  && locale-gen en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8

# Use the built-in ubuntu user (UID 1000), set shell to zsh + sudo
RUN chsh -s /bin/zsh ubuntu \
  && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu

USER ubuntu
WORKDIR /home/ubuntu

# Copy dotfiles + install everything
COPY --chown=ubuntu:ubuntu . .dotfiles/
RUN .dotfiles/install.sh

CMD ["zsh"]
