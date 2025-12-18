# ROS 2 Humble Desktop base -------------------------------------------------
# https://hub.docker.com/_/ros/tags
FROM ros:humble-ros-base-jammy

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-desktop=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*

# Non-interactive mode ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# Set timezone ------------------------------------------------------------
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install essentials ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    python3-vcstool \
    git \
    curl \
    wget \
    nano \
    build-essential \
    terminator \
    && rm -rf /var/lib/apt/lists/*

# GUI/OpenGL Dependencies (for RViz, rqt, OpenCV display) ------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    libgl1-mesa-dev \
    mesa-common-dev \
    mesa-utils \
    libglu1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libx11-xcb-dev \
    libxcb1-dev \
    libxcb-render0-dev \
    libxcb-shm0-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libglib2.0-dev \
    && rm -rf /var/lib/apt/lists/*

# USB Communication ------------------------------------------------------------  
RUN apt-get update && apt-get install -y --no-install-recommends \
    libusb-1.0-0 \
    udev \
    && rm -rf /var/lib/apt/lists/*

# Optional Dependencies ----------------------------------------------------------

# Set locale ------------------------------------------------------------
RUN apt-get update && apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

# Setup workspace ------------------------------------------------------------
WORKDIR /ros2_ws

# Default command ------------------------------------------------------------
CMD ["bash"]