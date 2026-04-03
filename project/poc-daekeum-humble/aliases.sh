# ROS env
[ -f /opt/ros/humble/setup.bash ] && source /opt/ros/humble/setup.bash
[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash

# Aliases
alias camera='source /ros2_ws/install/setup.bash && ros2 launch realsense2_camera rs_launch.py depth_module.depth_profile:=1280x720x30 rgb_camera.color_profile:=1280x720x30 align_depth.enable:=true'
alias detic='source /ros2_ws/install/setup.bash && ros2 launch detic_pick detic_pick.launch.py'
alias apriltag='source /ros2_ws/install/setup.bash && ros2 run apriltag_pose_estimator pose_estimator_node --ros-args -r __node:=pose_estimator_panel --params-file /ros2_ws/install/poc_daekeum_bringup/share/poc_daekeum_bringup/config/pose_estimator_panel.yaml'
alias poc='source /ros2_ws/install/setup.bash && ros2 run poc_daekeum poc_daekeum'
alias bringup='source /ros2_ws/install/setup.bash && ros2 launch poc_daekeum_bringup bringup.launch.py'
alias build='cd /ros2_ws && colcon build --symlink-install && source install/setup.bash'
alias cmd_help='echo; echo "[poc_daekeum] Commands: camera, detic, apriltag, poc, bringup, build, cmd_help"'

case $- in
    *i*) cmd_help ;;
esac