FROM nvidia/cuda:9.2-cudnn7-devel
MAINTAINER "Abhinav K"

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO kinetic
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},video,display

## Dependencies
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
        dirmngr \
        gnupg2 \
        lsb-release \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip==9.0.3 \
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
        flask-jwt-simple \
        passlib \
        flask-cors \
        shapely \
        requests \
        boto3 \
        'pycuda>=2017.1.1' \
    && python -m ipykernel.kernelspec

## Install Realsense drivers and ROS Kinetic (https://hub.docker.com/_/ros/)
RUN sh -c 'echo "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo $(lsb_release -sc) main" > /etc/apt/sources.list.d/realsense-public.list' \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 6F3EFCDE \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116 \
    && echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-get update && apt-get install -y --no-install-recommends \
        librealsense2-dkms \
        librealsense2-utils \
        librealsense2-dev \
        librealsense2-dbg \
        libusb-1.0.0-dev \
        python-rosdep \
        python-rosinstall \
        python-vcstools \
    && rosdep init \
    && rosdep update \
    && apt-get update && apt-get install -y \
        ros-kinetic-ros-core=1.3.2-0* \
        ros-kinetic-ros-base=1.3.2-0* \
        ros-kinetic-perception=1.3.2-0* \
        ros-kinetic-rqt \
        ros-kinetic-rqt-common-plugins \
        ros-kinetic-rviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Install TensorFlow GPU version - custom-built.
COPY ./tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl
RUN pip --no-cache-dir install /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl \
    && rm /tmp/tensorflow-1.8.0-cp27-cp27mu-linux_x86_64.whl

COPY ./libtensorflow_cc.so /usr/local/lib/python2.7/dist-packages/tensorflow/

COPY ./nv-tensorrt-repo-ubuntu1604-cuda9.2-ga-trt4.0.1.6-20180612_1-1_amd64.deb /tmp/nv-tensorrt-repo-ubuntu1604-cuda9.2-ga-trt4.0.1.6-20180612_1-1_amd64.deb
RUN dpkg -i /tmp/nv-tensorrt-repo-ubuntu1604-cuda9.2-ga-trt4.0.1.6-20180612_1-1_amd64.deb \
    && rm /tmp/nv-tensorrt-repo-ubuntu1604-cuda9.2-ga-trt4.0.1.6-20180612_1-1_amd64.deb

RUN apt-get update && apt-get install -y \
    tensorrt \
    python-libnvinfer-doc \
    uff-converter-tf \
    libnvinfer4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

# Create and configure top-level catkin workspace
RUN mkdir -p /root/store/src \
    && cd /root/store \
&& /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"


# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
