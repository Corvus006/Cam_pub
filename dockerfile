# Basis: Offizielles ROS2 Jazzy Image
FROM ros:jazzy

# Installiere Git und die benötigte RMW-Implementation
RUN apt-get update && apt-get install -y \
    git \
    ros-jazzy-v4l2-camera \
    ros-jazzy-compressed-image-transport \
    ros-jazzy-theora-image-transport \
    ros-jazzy-image-transport-plugins \
    ros-jazzy-rmw-cyclonedds-cpp && \
    rm -rf /var/lib/apt/lists/*

# Setze Umgebungsvariablen als Strings
ENV IMAGE_WIDTH=1280
ENV IMAGE_HEIGHT=720
ENV NODE_NAME=jif_camera
ENV VIDEO_DEVICE=/dev/video0

# Starte den Node mit den Parametern
CMD bash -c "source /opt/ros/jazzy/setup.bash && \
             ros2 run v4l2_camera v4l2_camera_node \
             --ros-args --remap __node:=${NODE_NAME} \
             -p image_size:=[${IMAGE_WIDTH},${IMAGE_HEIGHT}] \
              -p video_device:=${VIDEO_DEVICE} "
