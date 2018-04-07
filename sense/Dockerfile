FROM nvidia/cuda:9.0-cudnn7-devel
MAINTAINER "Abhinav K"

# TF dependencies - 1
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        python-pip \
        rsync \
        software-properties-common \
        unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# TF dependencies - 2
RUN pip --no-cache-dir install --upgrade pip \
    && pip --no-cache-dir install setuptools \
    && pip --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        redis \
        flask \
        flask-restful \
        shapely \
    && python -m ipykernel.kernelspec

# Install Realsense drivers
RUN sh -c 'echo "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo $(lsb_release -sc) main" > /etc/apt/sources.list.d/realsense-public.list' \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 6F3EFCDE \
    && apt-get update && apt-get install -y --no-install-recommends \
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ROS
# Based on http://wiki.ros.org/kinetic/Installation/Ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
        lsb-release \
    && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && apt-get update && apt-get install -y --no-install-recommends \
        ros-kinetic-desktop-full \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
    && mkdir -p /catkin_ws/src \
    && cd /catkin_ws \
    && echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
    && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make" \
    && rosdep init \
    && rosdep update \
    && apt-get install -y --no-install-recommends \
        ros-kinetic-vision-opencv \
        ros-kinetic-cv-bridge \
        ros-kinetic-compressed-depth-image-transport \
        ros-kinetic-image-transport-plugins \
        ros-kinetic-perception-pcl \
        ros-kinetic-perception \
        ros-kinetic-message-runtime \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# TBD: Install TensorFlow GPU version.
RUN pip --no-cache-dir install \
    https://pypi.python.org/packages/a1/ce/5bada74b1de0cfaafcc982291230ee987a769ace8ed9dedb36dbfe1bffc0/tensorflow_gpu-1.7.0-cp27-cp27mu-manylinux1_x86_64.whl#md5=c9af0f7d6de3e53ba0e66db39626f71c

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

# WORKDIR "/notebooks"
