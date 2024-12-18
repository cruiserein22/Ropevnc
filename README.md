# RopeVNC

A VNC server setup with noVNC web interface for remote desktop access.

## Requirements

- Linux system or SSH access to a Linux system
- Python 3
- pip3

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Ropevnc.git
cd Ropevnc
```

2. Make the startup script executable:
```bash
chmod +x start_vnc.sh
```

3. Run the script:
```bash
./start_vnc.sh
```

Note: You might need to use sudo for package installation:
```bash
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-terminal tigervnc-standalone-server tigervnc-common python3-pip
```

## Usage

1. After running the script, the VNC server will start on port 5901
2. noVNC web interface will be available on port 6901
3. Access the desktop through:
   - VNC client: `localhost:5901`
   - Web browser: `http://localhost:6901/vnc.html`
4. Default VNC password is: `password`

## File Structure

- `src/Models.py`: Main models file
- `src/common/`: Common installation and configuration files
- `start_vnc.sh`: Main startup script
- `start_vnc.bat`: Windows startup script (not primary platform)

## Stopping the Server

To stop the VNC server:
```bash
vncserver -kill :1
```

## License

[Your chosen license] 