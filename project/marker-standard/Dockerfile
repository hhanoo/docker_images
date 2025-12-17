# Ubuntu 22.04 base -------------------------------------------------
# https://hub.docker.com/r/ubuntu/
FROM ubuntu:22.04

# 비대화 모드 & GUI/IPC용 런타임 디렉터리 준비 ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /tmp/runtime-root && chmod 700 /tmp/runtime-root
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# 기본 시스템 도구 및 패키지 관리자  ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    vim \
    locales \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# C/C++ 컴파일 필수 도구 ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# GUI 및 그래픽 라이브러리 ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    # OpenGL/2D 렌더링
    libgl1-mesa-dev \
    mesa-common-dev \
    libglu1-mesa-dev \
    \
    # X11 코어/윈도우 시스템
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxrandr-dev \
    libxss-dev \
    libsm-dev \
    libice-dev \
    \
    # Xlib-XCB 브릿지 + XCB 확장 개발 헤더 (Qt, OpenGL, ...)
    libx11-xcb-dev \
    libxcb1-dev \
    libxcb-render0-dev \
    libxcb-shm0-dev \
    libxcb-randr0-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-icccm4-dev \
    libxcb-xinerama0-dev \
    libxcb-xfixes0-dev \
    libxcb-util-dev \
    \
    # GLib 개발 헤더 (Thread/Main Loop/Data Structure)
    libglib2.0-dev \
    \
    # Font & Text Rendering
    libfontconfig1-dev \
    libfreetype6-dev \
    \
    && rm -rf /var/lib/apt/lists/*

# USB 통신 (RealSense 등) ------------------------------------------------------------  
RUN apt-get update && apt-get install -y --no-install-recommends \
    libusb-1.0-0 \
    udev \
    && rm -rf /var/lib/apt/lists/*

# Poco 라이브러리 ----------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpoco-dev \
    && rm -rf /var/lib/apt/lists/*

# pip 업그레이드 및 uv 설치 ------------------------------------------------------------
RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel uv

# Python dependencies 설치 (uv 사용) ------------------------------------------------------------
RUN uv pip install --system \
    dt-apriltags \
    numpy \
    opencv-python \
    pyrealsense2

# 로케일 설정 ------------------------------------------------------------
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure --frontend=noninteractive locales
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

# 타임존 설정 (Asia/Seoul) ------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    rm -rf /var/lib/apt/lists/*
ENV TZ=Asia/Seoul

# workspace setting ------------------------------------------------------------
WORKDIR /workspace
CMD ["bash"]