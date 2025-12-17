# Ubuntu 관련 ------------------------------------------------------------
ARG UBUNTU_RELEASE=22.04

# CUDA 관련 ------------------------------------------------------------
ARG CUDA_VERSION=12.1.1
ARG CUDA_RELEASE=12.1
ARG CUDA_PURPOSE=devel
# ARG CUDNN_VERSION="cudnn-"
ARG CUDNN_VERSION=""

# CUDA Docker 이미지 다운로드 ------------------------------------------------------------
FROM nvcr.io/nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}${CUDA_PURPOSE}-ubuntu${UBUNTU_RELEASE}

# 비대화 설치 모드 ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive

# NVIDIA GPU 설정 ------------------------------------------------------------
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# GUI 디스플레이 설정 ------------------------------------------------------------
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# 기본 시스템 도구 및 패키지 관리자  ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    software-properties-common \
    sudo \
    curl \
    wget \
    git \
    vim \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Python 환경 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    python3 \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# C/C++ 컴파일 필수 도구 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    build-essential \
    cmake \
    pkg-config \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    && rm -rf /var/lib/apt/lists/*

# GUI/그래픽 관련 라이브러리 (OpenCV 등) ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    libhdf5-dev \
    libhdf5-serial-dev \
    libhdf5-103 \
    && rm -rf /var/lib/apt/lists/*

# Qt GUI 라이브러리 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    libgl1 \
    libglib2.0-0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libxcb1 \
    libxcb-shm0 \
    libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xfixes0 \
    libxext6 \
    libxrender1 \
    libxi6 \
    libfontconfig1 \
    libfreetype6 \
    xvfb \
    x11-utils \
    && rm -rf /var/lib/apt/lists/*

# USB 통신 (RealSense 등) ------------------------------------------------------------  
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    libusb-1.0-0 \
    udev \
    && rm -rf /var/lib/apt/lists/*

# 로케일 설정 ------------------------------------------------------------
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:en_US

# pip 업그레이드 ------------------------------------------------------------
RUN pip3 install --no-cache-dir --upgrade pip setuptools wheel

# Python 패키지 설치 ------------------------------------------------------------
RUN pip3 install --no-cache-dir \
    setuptools \
    Cython \
    numpy \
    scipy \
    scikit-learn \
    matplotlib \
    opencv-python \
    pyrealsense2 \
    torch==2.4.1 \
    torchvision==0.19.1 \
    torchaudio==2.4.1 \
    pymodbus \
    imutils \
    timm \
    kornia \
    einops \
    tqdm \
    huggingface-hub 

# 환경 변수 설정 ------------------------------------------------------------
RUN echo 'export PATH=/usr/local/cuda-${CUDA_VERSION}/bin:$PATH' >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc 

# BiRefNet 모델 모듈 ------------------------------------------------------------
COPY ./BiRefNet/ /root/BiRefNet/

# 워크스페이스 설정 ------------------------------------------------------------
WORKDIR /root/SFSC_Conveyor_Robot_System

# 포트 노출 (필요한 경우) ------------------------------------------------------------
EXPOSE 8090

# 실행 스크립트 생성 ------------------------------------------------------------
RUN echo '#!/bin/bash\n\
    echo "============================================================"\n\
    echo "SFSC Conveyor & Robot System Docker Container (Ubuntu 22.04)"\n\
    echo "============================================================"\n\
    cd /root/SFSC_Conveyor_Robot_System\n\
    exec /bin/bash --login\n\
    ' > /root/start.sh && chmod +x /root/start.sh

# 기본 명령어 설정 ------------------------------------------------------------
CMD ["/root/start.sh"]