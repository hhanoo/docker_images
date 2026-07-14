# ===== ROS env =====
[ -f /opt/ros/humble/setup.bash ]      && source /opt/ros/humble/setup.bash
[ -f /ros2_ws/install/setup.bash ]     && source /ros2_ws/install/setup.bash
[ -f /ros2_ws/docker/config.sh ]       && source /ros2_ws/docker/config.sh

# ===== Common helpers =====
source-ros-ws() {
    [ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash
}

source-config() {
    [ -f /ros2_ws/docker/config.sh ] && source /ros2_ws/docker/config.sh
}

# ===== Build =====
build() {
    cd /ros2_ws || return 1
    colcon build \
        --symlink-install \
        --cmake-args -DCMAKE_BUILD_TYPE=Release "$@"
    source-ros-ws
    source-config
}

# ===== Individual launchers =====
camera() {
    source-ros-ws
    ros2 launch realsense2_camera rs_launch.py \
        config_file:=/ros2_ws/install/poc_daekeum_bringup/share/poc_daekeum_bringup/config/realsense.yaml \
        "$@"
}

detic() {
    source-ros-ws
    ros2 launch detic_pick detic_pick.launch.py "$@"
}

apriltag() {
    source-ros-ws
    ros2 run apriltag_pose_estimator pose_estimator_node --ros-args \
        -r __node:=pose_estimator_panel \
        --params-file /ros2_ws/install/poc_daekeum_bringup/share/poc_daekeum_bringup/config/pose_estimator_panel.yaml \
        "$@"
}

poc() {
    source-ros-ws
    ros2 run poc_daekeum poc_daekeum "$@"
}

# ===== Integrated launcher =====
bringup() {
    source-ros-ws
    ros2 launch poc_daekeum_bringup bringup.launch.py "$@"
}

# ===== Help =====
cmd-help() {
    printf "\n[poc_daekeum] Commands:\n\n"

    printf "  Build:\n"
    printf "    %-12s - %s\n" "build"     "colcon build (Release) + source overlay"
    printf "\n"

    printf "  Individual launchers:\n"
    printf "    %-12s - %s\n" "camera"    "Intel RealSense (D415)"
    printf "    %-12s - %s\n" "detic"     "Detic object detection (CUDA)"
    printf "    %-12s - %s\n" "apriltag"  "AprilTag pose estimator"
    printf "    %-12s - %s\n" "poc"       "Qt GUI application (poc_daekeum)"
    printf "\n"

    printf "  Integrated launcher:\n"
    printf "    %-12s - %s\n" "bringup"   "camera + detic + apriltag + poc"
    printf "\n"

    printf "  Config / Help:\n"
    printf "    %-12s - %s\n" "source-config" "Reload /ros2_ws/docker/config.sh"
    printf "    %-12s - %s\n" "cmd-help"  "Show this help"
    echo
}

# ===== Show help on interactive shell =====
case $- in
    *i*) cmd-help ;;
esac
