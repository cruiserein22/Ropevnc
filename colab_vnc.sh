#!/bin/bash

# Install required packages
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

# Start noVNC with ngrok tunnel
cd $NO_VNC_HOME/utils
./novnc_proxy --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &

# Install and setup ngrok for public access
if [ ! -f "/usr/local/bin/ngrok" ]; then
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok-stable-linux-amd64.zip
    mv ngrok /usr/local/bin
    rm ngrok-stable-linux-amd64.zip
fi

# Start ngrok tunnel (you'll need to add your authtoken)
# Add your ngrok authtoken here:
# ngrok authtoken YOUR_AUTH_TOKEN
ngrok http $NO_VNC_PORT 