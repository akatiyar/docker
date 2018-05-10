#!/bin/bash
set -e

# setup ros environment
echo "source /opt/ros/$ROS_DISTRO/setup.bash">> ~/.bashrc
echo "source /root/store/devel/setup.bash">> ~/.bashrc
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "/root/store/devel/setup.bash"
exec "$@"
