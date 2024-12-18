#!/bin/bash

# Install required packages (you may need sudo for these)
apt-get update
apt-get install -y xfce4 xfce4-terminal tigervnc-standalone-server tigervnc-common python3-pip

# Set environment variables
export NO_VNC_HOME="$(pwd)/noVNC"
export VNC_PORT="5901"
export NO_VNC_PORT="6901"

# Install noVNC if not already installed
if [ ! -d "$NO_VNC_HOME" ]; then
    bash src/common/install/no_vnc_1.5.0.sh
fi

# Install websockify
pip3 install websockify

# Set VNC password
mkdir -p ~/.vnc
echo "password" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Kill any existing VNC servers
vncserver -kill :1 2>/dev/null || true

# Start VNC server
vncserver :1 -geometry 1280x800 -depth 24 &
sleep 2

# Start window manager
export DISPLAY=:1
bash src/common/xfce/wm_startup.sh &
sleep 2

# Start noVNC
cd $NO_VNC_HOME/utils
./novnc_proxy --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT