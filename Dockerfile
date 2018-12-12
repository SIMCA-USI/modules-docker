ARG  RELEASE=16.04

FROM ubuntu:${RELEASE}

ENV ROS_DISTRO kinetic

ENV TERM xterm-256color

RUN apt-get update && apt-get install -y -q sudo apt-utils lsb-release gnupg2 htop net-tools iputils-ping nano git

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN apt-get update && apt-get install -y -q ros-$ROS_DISTRO-ros-base

RUN rosdep init

RUN rosdep update

RUN sudo apt-get install -y -q python-rosinstall python-rosinstall-generator python-wstool build-essential python3-pip

RUN mkdir -p /root/files

COPY files/* /root/files 

RUN pip3 install -r /root/files/requierements.txt

COMMAND [source /opt/ros/$ROS_DISTRO/setup.bash]
