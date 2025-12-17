# Ubuntu 관련 ------------------------------------------------------------
ARG UBUNTU_RELEASE=20.04

# CUDA 관련 ------------------------------------------------------------
ARG CUDA_VERSION=12.1.1
ARG CUDA_RELEASE=12.1
ARG CUDA_PURPOSE=devel
# ARG CUDNN_VERSION="cudnn-"
ARG CUDNN_VERSION=""

# CUDA Docker 이미지 다운로드 ------------------------------------------------------------
FROM nvcr.io/nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}${CUDA_PURPOSE}-ubuntu${UBUNTU_RELEASE}

# 비대화 설치 모드, NVIDIA 설정 ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
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
    python3-pip \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*

# C/C++ 컴파일 필수 도구 ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# GUI/그래픽 관련 라이브러리 (OpenCV 등) ------------------------------------------------------------
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
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
    pyyaml \
    imutils

# 환경 변수 설정 ------------------------------------------------------------
RUN echo 'export PATH=/usr/local/cuda-${CUDA_VERSION}/bin:$PATH' >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc 

# 워크스페이스 및 엔트리포인트 설정 ------------------------------------------------------------
WORKDIR /root/workspace
CMD ["bash"]