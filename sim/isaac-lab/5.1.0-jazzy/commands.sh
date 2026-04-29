# ROS env
[ -f /opt/ros/jazzy/setup.bash ] && source /opt/ros/jazzy/setup.bash
[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash

# Common helpers
source_ros_ws() {
    [ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash
}

# Commands
isaacsim() {
    source_ros_ws
    /isaac-sim/isaac-sim.sh --enable isaacsim.ros2.bridge "$@"
}

isaacsim_headless() {
    source_ros_ws
    /isaac-sim/runheadless.sh --enable isaacsim.ros2.bridge "$@"
}

isaaclab() {
    source_ros_ws
    # Run from /IsaacLab so relative script paths (scripts/tutorials/...) resolve.
    # Subshell keeps the caller's cwd unchanged.
    (cd /IsaacLab && ./isaaclab.sh "$@")
}

build() {
    cd /ros2_ws || return 1

    colcon build \
        --symlink-install \
        --cmake-args -DCMAKE_BUILD_TYPE=Release

    source_ros_ws
}

cmd_help() {
    printf "\n[isaac-lab] Commands:\n"
    printf "  %-20s - %s\n" "isaacsim"          "launch Isaac Sim GUI (ROS2 bridge enabled)"
    printf "  %-20s - %s\n" "isaacsim_headless" "launch Isaac Sim headless (ROS2 bridge enabled)"
    printf "  %-20s - %s\n" "isaaclab"          "run /IsaacLab/isaaclab.sh wrapper"
    printf "  %-20s - %s\n" "build"             "colcon build /ros2_ws"
    printf "  %-20s - %s\n" "cmd_help"          "show this help message"
    echo
}

# ===== Show help on interactive shell =====
case $- in
    *i*) cmd_help ;;
esac
