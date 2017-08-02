FROM ubuntu:16.04
MAINTAINER "Abhinav K"

# Install PCL dependencies
# Based on https://larrylisky.com/2016/11/03/point-cloud-library-on-ubuntu-16-04-lts/
RUN apt-get update && apt-get install -yq \
    git build-essential linux-libc-dev \
    cmake cmake-gui \
    libusb-1.0-0-dev libusb-dev libudev-dev \
    mpi-default-dev openmpi-bin openmpi-common \
    libflann1.8 libflann-dev \
    libeigen3-dev \
    libboost-all-dev \
    libvtk5.10-qt4 libvtk5.10 libvtk5-dev \
    libqhull* libgtest-dev \
    freeglut3-dev pkg-config \
    libxmu-dev libxi-dev \
    mono-complete \
    qt-sdk openjdk-8-jdk openjdk-8-jre \
    && rm -rf /var/lib/apt/lists/*

# Based on https://github.com/OpenKinect/libfreenect2
# and https://hub.docker.com/r/nucleardreamer/libfreenect2/
# TODO: Include CUDA
## Uncomment libglfw3-dev if you want to install OpenGL
## Uncomment beignet-dev opencl-headers if you want to install OpenCL
## Uncomment libva-dev libjpeg-dev if you want to install Intel VAAPI
RUN apt-get update && apt-get install -yq \
    build-essential cmake pkg-config \
    libusb-1.0.0-dev \
    libturbojpeg libjpeg-turbo8-dev \
    libglfw3-dev \
#    beignet-dev opencl-headers \
    libva-dev libjpeg-dev \
    libopenni2-0 libopenni2-dev openni2-utils \
    udev \
    git \
    && rm -rf /var/lib/apt/lists/*


# Build freenect2 from source
# TODO: Checkout stable version
RUN git clone https://github.com/OpenKinect/libfreenect2.git \
    && cd libfreenect2 \
    && mkdir build \
    && cd build \
    && cmake .. -DBUILD_OPENNI2_DRIVER=ON -DCMAKE_INSTALL_PREFIX=/root/freenect2 \
    && make -j4 \
    && make -j4 install \
    && cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/ \
    && ldconfig /root/freenect2 \
    && ln -s /libfreenect2/build/bin/Protonect /usr/local/bin/kinect_test

# PCL - build from source and install
# TODO: Checkout stable version
RUN git clone https://github.com/PointCloudLibrary/pcl.git \
    && cd pcl \
    && mkdir release \
    && cd release \
    && cmake -DCMAKE_BUILD_TYPE=None -DBUILD_GPU=ON -DBUILD_apps=ON -DBUILD_examples=ON .. \
    && make -j4 \
    && make -j4 install

