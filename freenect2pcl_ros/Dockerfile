FROM akatiyar/freenect2pcl
MAINTAINER "Abhinav Katiyar <katiyar.abhinav@gmail.com>"

# Based on http://wiki.ros.org/kinetic/Installation/Ubuntu
RUN apt-get update \
    && apt-get install -yq lsb-release \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && apt-get install -yq python-pip \
    && pip install setuptools \
    && apt-get update \
    && apt-get install -yq ros-kinetic-desktop-full \
    && apt-get update && apt-get install -yq \
        python-rosinstall python-rosinstall-generator \
        python-wstool build-essential \
    && mkdir -p /catkin_ws/src \
    && cd /catkin_ws \
    && echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
    && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make" \
    && rosdep init \
    && rosdep update \
    && apt-get install -yq  --reinstall ros-kinetic-vision-opencv \
        ros-kinetic-cv-bridge ros-kinetic-compressed-depth-image-transport \
        ros-kinetic-image-transport-plugins ros-kinetic-perception-pcl \
        ros-kinetic-perception ros-kinetic-message-runtime \
    && rm -rf /var/lib/apt/lists/*
