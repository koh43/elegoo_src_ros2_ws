#!/bin/bash
set -e

source /opt/ros/jazzy/setup.bash
source /elegoo_src_ros2_ws/install/local_setup.sh

# Run multiple launch files (example)
# ros2 launch elegoo_src_ros2 pub_serial.py &
ros2 launch elegoo_src_ros2 pub_cam.py &

wait