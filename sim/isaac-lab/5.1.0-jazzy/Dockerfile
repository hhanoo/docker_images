# =========================================================================
# Base Image
# =========================================================================
# - Isaac Sim 5.1.0 + ROS2 Jazzy (CycloneDDS, ROS2 bridge ready)
ARG BASE_IMAGE=hhanoo/sim:isaac-sim-5.1.0-jazzy
FROM ${BASE_IMAGE}

# =========================================================================
# Isaac Lab
# =========================================================================
# - Pinned to v2.3.2 (compatible with Isaac Sim 5.1.0)
#   https://github.com/isaac-sim/IsaacLab/releases
ARG ISAAC_LAB_VERSION=v2.3.2
ENV ISAAC_LAB_PATH=/IsaacLab

# - Clone Isaac Lab
RUN git clone --branch ${ISAAC_LAB_VERSION} --depth 1 \
        https://github.com/isaac-sim/IsaacLab.git ${ISAAC_LAB_PATH}

# - Symlink Isaac Sim into IsaacLab (required by isaaclab.sh)
RUN ln -s /isaac-sim ${ISAAC_LAB_PATH}/_isaac_sim

# - Pre-install flatdict (its setup.py uses pkg_resources which fails inside
#   pip's build isolation env, breaking the core isaaclab package install)
RUN /isaac-sim/python.sh -m pip install --no-build-isolation flatdict==4.0.1

# - Install Isaac Lab + RL frameworks (rsl_rl, rl_games, sb3, skrl)
#   TERM=xterm: isaaclab.sh uses tput/tabs commands that need a real terminfo
WORKDIR ${ISAAC_LAB_PATH}
RUN TERM=xterm ./isaaclab.sh --install

# =========================================================================
# Workspace Setup
# =========================================================================
# - Workspace
WORKDIR /ros2_ws

# - Commands (extends base with isaaclab helper)
COPY ./commands.sh /etc/profile.d/commands.sh
RUN chmod 644 /etc/profile.d/commands.sh

# - Default command (entrypoint inherited from base)
CMD ["bash"]
