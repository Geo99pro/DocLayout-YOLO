# Change the version of cuda and cudnn according to user cuda and cudnn version
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

# Install libraries and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ffmpeg \
    libsm6 \
    libxext6 \
    git \
    curl \
    unzip \
    wget \
    tar \
    build-essential \
    libopenmpi-dev \
    pkg-config \
    cmake \
    libpoppler-cpp-dev \
    poppler-utils \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends python3.9 python3.9-distutils python3.9-dev python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade setuptools

# Update Python symlink to point to Python 3.9
RUN ln -sf /usr/bin/python3.9 /usr/bin/python \
    && ln -sf /usr/bin/python3.9 /usr/bin/python3
RUN pip install huggingface-hub

#if repository is local
COPY ./DocLayout-YOLO ${HOME}/DocLayout-YOLO
WORKDIR ${HOME}/DocLayout-YOLO
RUN pip install -e .

# if want to use pip install from https://pypi.org/project/doclayout-yolo/
#RUN pip install doclayout-yolo

WORKDIR ${HOME}

CMD [ "bash" ]