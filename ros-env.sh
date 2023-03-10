#!//usr/bin/bash


# Program for Robi, other robots please adjust
M_IP_ALFA="192.168.10.1" #IP ALFA
M_IP_ABI="192.168.10.2" #IP ABI
M_IP_ROBI="192.168.10.34" #IP ROBI

# Get the robot's IP
IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"

# Try reaching for Alfa
if ping -c 1 $M_IP_ALFA > /dev/null
then
  echo Alfa is the master #succed
  M_IP=$M_IP_ALFA
  master="ALFA"
# Try reaching for Abi
elif ping -c 1 $M_IP_ABI > /dev/null
then
  echo Abi is the master #succed
  M_IP=$M_IP_ABI
  master="ABI"
# Try reaching for Robi
elif ping -c 1 $M_IP_ROBI > /dev/null
then
  echo Robi is the master #succed
  M_IP=$M_IP_ROBI
  master="ROBI"
else
  echo No internet connection! #failed
  M_IP="localhost"
  IP="127.0.0.1"
fi

echo "ROS_MASTER_URI: [$M_IP]"
echo "ROS_IP: [$IP]"

#export ROS environment variables
export ROS_MASTER_URI="http://${M_IP}:11311"
export ROS_IP="${IP}"
export ROS_HOSTNAME="${ROS_IP}"

