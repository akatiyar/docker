FROM nvidia/cuda:9.2-cudnn7-devel
MAINTAINER "Abhinav K"

## TF dependencies - 1
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

## TF dependencies - 2
RUN pip install --upgrade pip==9.0.3 \
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
    && python -m ipykernel.kernelspec

## Install Realsense drivers
RUN sh -c 'echo "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo $(lsb_release -sc) main" > /etc/apt/sources.list.d/realsense-public.list' \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 6F3EFCDE \
    && apt-get update && apt-get install -y --no-install-recommends \
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg \
        libusb-1.0.0-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## ROS Kinetic (https://hub.docker.com/_/ros/)
# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
ENV ROS_DISTRO kinetic
RUN apt-get update && apt-get install -y \
    ros-kinetic-ros-core=1.3.2-0* \
    ros-kinetic-ros-base=1.3.2-0* \
    ros-kinetic-perception=1.3.2-0* \
    ros-kinetic-rqt \
    ros-kinetic-rqt-common-plugins \
    ros-kinetic-rviz \
    && rm -rf /var/lib/apt/lists/*

## Install TensorFlow GPU version - custom-built.
COPY ./tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl

RUN pip --no-cache-dir install /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl \
    && rm /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl

COPY ./libtensorflow_cc.so /usr/local/lib/python2.7/dist-packages/tensorflow/

# Flask and Redis Dependencies
RUN pip --no-cache-dir install \
    redis \
    flask \
    flask-restful \
    flask-jwt-simple \
    passlib \
    flask-cors \
    shapely

# Create and configure top-level catkin workspace
RUN mkdir -p /root/store/src \
    && cd /root/store \
&& /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},video,display

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
