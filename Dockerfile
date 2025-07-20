FROM ros:jazzy-ros-base

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    build-essential \
    ros-jazzy-cv-bridge \
    python3-opencv \
    && rm -rf /var/lib/apt/lists/*

# Install your required pip packages
RUN rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy your workspace
COPY src/ /elegoo_src_ros2_ws/src/

# Build the workspace
WORKDIR /elegoo_src_ros2_ws
RUN . /opt/ros/jazzy/setup.sh && colcon build --symlink-install

COPY scripts/setup.sh scripts/setup.sh
RUN chmod +x scripts/setup.sh

COPY espcam_calib_params.mat espcam_calib_params.mat

# Source the workspace on container start
CMD ["/bin/bash", "-c", "scripts/setup.sh"]