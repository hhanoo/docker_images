# =========================================================================
# Base Image
# =========================================================================
# - Ubuntu Release
ARG UBUNTU_RELEASE=20.04

# - CUDA Release
ARG CUDA_VERSION=12.1.1
ARG CUDA_RELEASE=12.1
ARG CUDA_PURPOSE=devel
ARG CUDNN_VERSION=""

# - CUDA Docker Image Download
FROM nvcr.io/nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}${CUDA_PURPOSE}-ubuntu${UBUNTU_RELEASE}

# - NVIDIA Settings
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# =========================================================================
# Locale and Font
# =========================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# =========================================================================
# Essential Packages
# =========================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    software-properties-common \
    sudo \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# =========================================================================
# Python
# =========================================================================
# - Python 3
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*

# - PyQt5
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    python3-pyqt5.qtwebkit \
    && rm -rf /var/lib/apt/lists/*

# - GUI/USB libraries (OpenCV, RealSense)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libusb-1.0-0 \
    libxext6 \
    libxrender1 \
    udev \
    && rm -rf /var/lib/apt/lists/*

# - Vision packages
RUN pip3 install --no-cache-dir \
    Cython \
    imutils \
    matplotlib \
    numpy \
    opencv-python \
    pyrealsense2 \
    scikit-learn \
    scipy \
    setuptools

# - PyTorch packages
RUN pip3 install --no-cache-dir \
    torch==2.4.1 \
    torchaudio==2.4.1 \
    torchvision==0.19.1

# - Utility packages
RUN pip3 install --no-cache-dir \
    pymodbus \
    pyyaml

# =========================================================================
# C++ Build Dependencies
# =========================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# =========================================================================
# Workspace Setup
# =========================================================================
# - Workspace
WORKDIR /root/workspace

# - Commands
COPY commands.sh /etc/profile.d/commands.sh
RUN chmod 644 /etc/profile.d/commands.sh && \
    echo 'source /etc/profile.d/commands.sh' >> /etc/bash.bashrc

# - Entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# - Default command
CMD ["bash"]
