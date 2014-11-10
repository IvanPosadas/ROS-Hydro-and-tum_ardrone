#!/bin/sh

#instalacion de ROS Hydro para ubuntu 12.04
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update 
sudo apt-get install ros-hydro-desktop-full -y

sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall -y

#creacion y configuracion de Catkin workpace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace

cd ~/catkin_ws/
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

#instalacion y configuracion ardrone autonomy

sudo apt-get install libudev-dev -y
sudo apt-get install libblas-dev -y
sudo apt-get install liblapack-dev -y
sudo apt-get install daemontools -y
sudo apt-get install libiw-dev -y


cd ~/catkin_ws/src
git clone https://github.com/AutonomyLab/ardrone_autonomy.git -b hydro-devel
cd~/catkin_ws/
catkin_make 
echo "export ROS_PACKAGE_PATH= $ROS_PACKAGE_PATH:\`pwd\`/src/ardrone_autonomy" >> ~/.bashrc
source ~/.bashrc

#instalacion y configuracion tum_ardrone
cd ~/catkin_ws/src
git clone https://github.com/tum-vision/tum_ardrone.git
cd~/catkin_ws/
catkin_make 
echo "export ROS_PACKAGE_PATH= $ROS_PACKAGE_PATH:\`pwd\`/src/tum_ardrone" >> ~/.bashrc
source ~/.bashrc
rosdep install tum_ardrone


#ejecutando tum ardrone
roslaunch tum_ardrone ardrone_driver.launch &
roslaunch tum_ardrone tum_ardrone.launch
