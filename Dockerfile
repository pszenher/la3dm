ARG ROS_DISTRO=kinetic
FROM ros:${ROS_DISTRO}

ARG DEBIAN_FRONTEND=noninteractie
SHELL [ "/bin/bash", "-o", "pipefail" ]

RUN mkdir -p /catkin_ws/src
COPY . /catkin_ws/src

RUN apt update && \
    rosdep install -iy --from-src=/catkin_ws/src/la3dm

RUN /ros_entrypoint.sh catkin_make --directory catkin_ws && \
    sed -i "$(wc -l < /ros_entrypoint.sh)i\\source \"/catkin_ws/devel/setup.bash\"\\" /ros_entrypoint.sh
