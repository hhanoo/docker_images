# =========================================================================
# Base Image
# =========================================================================
# - Isaac Sim Release
#   https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim
ARG ISAAC_SIM_VERSION=4.5.0

# - Isaac Sim Docker Image Download
FROM nvcr.io/nvidia/isaac-sim:${ISAAC_SIM_VERSION}

# - NVIDIA Settings
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

# - Isaac Sim EULA / Privacy auto accept
ENV OMNI_KIT_ACCEPT_EULA=YES
ENV ACCEPT_EULA=Y
ENV PRIVACY_CONSENT=Y

# - Isaac Sim ROS2 bridge hint (system ROS install mode)
ENV isaac_sim_package_path=/isaac-sim

# - Allow Omniverse Kit to run as root (docker default user)
ENV OMNI_KIT_ALLOW_ROOT=1

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
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    lsb-release \
    software-properties-common \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/*

# =========================================================================
# ROS2
# =========================================================================
# - ROS2 Humble
ARG ROS_VERSION=humble
ENV ROS_DISTRO=${ROS_VERSION}
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
    http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
    > /etc/apt/sources.list.d/ros2.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-ros-base \
    ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*

# - ROS2 Control / Robot description
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-ros2-control \
    ros-${ROS_DISTRO}-ros2-controllers \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*

# - ROS2 Vision / Image transport
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-vision-msgs \
    ros-${ROS_DISTRO}-image-transport \
    ros-${ROS_DISTRO}-image-transport-plugins \
    ros-${ROS_DISTRO}-camera-info-manager \
    && rm -rf /var/lib/apt/lists/*

# - CycloneDDS RMW
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# =========================================================================
# Python
# =========================================================================
# - Python 3 and ROS2 Python dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-vcstool \
    python3-rosdep \
    ros-${ROS_DISTRO}-ament-package \
    && rm -rf /var/lib/apt/lists/*

# - Keep system python stable for ROS
RUN python3 -m pip install --no-cache-dir --upgrade \
    pip \
    "setuptools<80" \
    packaging \
    wheel

# - Common scientific stack
RUN python3 -m pip install --no-cache-dir \
    numpy \
    opencv-python \
    scipy \
    matplotlib

# =========================================================================
# Development Tools
# =========================================================================
RUN apt-get update && apt-get install -y --no-install-recommends \
    bear \
    clang-format \
    clangd \
    terminator \
    vim \
    && rm -rf /var/lib/apt/lists/*

# =========================================================================
# rosdep
# =========================================================================
RUN rosdep init && rosdep update

# =========================================================================
# Workspace Setup
# =========================================================================
# - Workspace
WORKDIR /ros2_ws

# - Commands
COPY ./commands.sh /etc/profile.d/commands.sh
RUN chmod 644 /etc/profile.d/commands.sh && \
    echo 'source /etc/profile.d/commands.sh' >> /etc/bash.bashrc

# - CycloneDDS configuration
COPY ./cyclonedds.xml /etc/cyclonedds.xml

# - Entrypoint
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# - Default command
CMD ["bash"]
