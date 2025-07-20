FROM ros:jazzy-ros-base

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# Copy your workspace
COPY src/ /ros2_ws/src/

WORKDIR /ros2_ws

# Build the workspace
RUN . /opt/ros/humble/setup.sh && colcon build

# Source the workspace on container start
CMD ["/bin/bash", "-c", "source /ros2_ws/install/setup.bash && ros2 run <your_package> <your_node>"]