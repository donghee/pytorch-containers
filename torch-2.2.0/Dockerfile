# https://hub.docker.com/r/nvidia/cuda/tags
FROM nvidia/cuda:12.1.0-devel-ubuntu20.04
LABEL maintainer="Your Name <yourname@mail.com>"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    sudo \ 
    openssh-client \
    git \
    openssl \
    locales \
    software-properties-common \
    dirmngr \
    gpg-agent \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone
 
# Configure locale
RUN export LANGUAGE=ko_KR.UTF-8; export LANG=ko_KR.UTF-8; export LC_ALL=ko_KR.UTF-8; locale-gen ko_KR.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN echo "LANG=ko_KR.UTF-8" > /etc/default/locale
RUN echo "LANGUAGE=ko_KR.UTF-8" >> /etc/default/locale
RUN echo "LC_ALL=ko_KR.UTF-8" >> /etc/default/locale

ENV LANG ko_KR.UTF-8 
ENV LANGUAGE ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

# FIXME: provide fix for these root-need
RUN apt-get update && apt-get install --no-install-recommends -y \
    apt-rdepends \
    && rm -rf /var/lib/apt/lists/*

# pyenv to use python 3.8
ENV PYTHON_VERSION 3.8
RUN apt-get update && apt-get install --no-install-recommends -y python3-pip build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev -y \
    && rm -rf /var/lib/apt/lists/*

# libjpeg8, ffmpeg 
RUN apt-get update && apt-get install --no-install-recommends -y libjpeg8-dev zlib1g-dev ffmpeg llvm \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /root
ENV PYENV_ROOT "$HOME/.pyenv"
ENV PATH "$PYENV_ROOT/bin:$PATH"

# Install pyenv
RUN set -ex \
    && curl https://pyenv.run | bash \
    && pyenv update \
    && pyenv install $PYTHON_VERSION \
    && pyenv global $PYTHON_VERSION \
    && pyenv rehash

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"'  >> "$HOME/.bashrc"
RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"'  >> "$HOME/.bashrc"
RUN echo 'eval "$(pyenv init -)"'  >> "$HOME/.bashrc"
RUN echo 'eval "$(pyenv virtualenv-init -)"'  >> "$HOME/.bashrc"

COPY ./entrypoint.sh /

# Install torch 2.2.0+cu121
# https://download.pytorch.org/whl/torch_stable.html
RUN eval "$(pyenv init -)" && pyenv global $PYTHON_VERSION && python3 -m pip install numpy==1.24.4 torch==2.2.0+cu121 -f https://download.pytorch.org/whl/torch_stable.html

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]
