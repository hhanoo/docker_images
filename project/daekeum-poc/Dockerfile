# Ubuntu 관련 ------------------------------------------------------------
ARG UBUNTU_RELEASE=22.04

# CUDA 관련 ------------------------------------------------------------
ARG CUDA_VERSION=12.5.1
ARG CUDA_RELEASE=12.5
ARG CUDA_PURPOSE=devel
ARG CUDNN_VERSION="cudnn-"

# CUDA Docker 이미지 다운로드 ------------------------------------------------------------
FROM docker.io/nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}${CUDA_PURPOSE}-ubuntu${UBUNTU_RELEASE}

# 비대화 설치 모드, NVIDIA 설정 ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# 필수 패키지 설치 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    libmodbus-dev \
    libpoco-dev \
    libusb-1.0-0 \
    locales \
    python3-tk \
    python3-dev \
    python3-pip \
    software-properties-common \
    sudo \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# QT 프로그램 관련 설치 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    qtbase5-dev \
    qttools5-dev \
    qttools5-dev-tools \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5core5a \
    qml-module-qtquick-controls \
    qml-module-qtquick-controls2 \
    qml-module-qtgraphicaleffects \
    && rm -rf /var/lib/apt/lists/*

# Vision GUI Python 패키지 설치 ------------------------------------------------------------
RUN pip install --upgrade pip && pip install \
    pyrealsense2 \
    math3d==3.0.0 \
    pymodbus==2.1.0 \
    timm==1.0.9 \
    opencv-contrib-python \
    git+https://github.com/openai/CLIP.git

# torch 설치 ------------------------------------------------------------
RUN pip install --upgrade pip && pip install \
    torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121

# 로케일 설정 ------------------------------------------------------------
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:en

# 환경 변수 설정 ------------------------------------------------------------
RUN echo 'export PATH=/usr/local/cuda-${CUDA_VERSION}/bin:$PATH' >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc \
    && echo "/root/workspace/POC_Daekeum_unite_sdk/ketirobotsdk" > /etc/ld.so.conf.d/robotsdk.conf \
    && ldconfig

# 워크스페이스 및 엔트리포인트 설정 ------------------------------------------------------------
WORKDIR /root/workspace
ENTRYPOINT ["/bin/bash"]