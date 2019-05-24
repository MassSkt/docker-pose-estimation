FROM nvidia/cuda:9.0-cudnn7-devel
ENV NB_USER masskt
ENV NB_UID 1000
RUN set -x && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    swig \
    locales \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    vim \
    libgtk2.0-dev \
    sudo && \
    locale-gen en_US.UTF-8 && \
    : "useradd" && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir /home/$NB_USER/.jupyter && \
    chown -R $NB_USER:users /home/$NB_USER/.jupyter && \
    echo "$NB_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$NB_USER && \
    : "python install" && \
    pip3 install --upgrade setuptools pip && \
    mkdir -p /usr/src/app && \
    chown $NB_USER:users -R /usr/src/app
WORKDIR /usr/src/app
COPY requirements.txt ./
COPY fonts/*.ttf ./
RUN set -x && \
    pip3 install cython && \
    pip3 install numpy && \
    pip3 install --no-cache-dir -r requirements.txt

USER $NB_USER

ENV LANG en_US.UTF-8 

ENTRYPOINT ["/bin/bash"]

