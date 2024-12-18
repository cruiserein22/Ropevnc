@echo off
REM Start TightVNC Server (adjust path as needed)
start "VNC Server" "C:\Program Files\TightVNC\tvnserver.exe"

REM Start noVNC
cd %NO_VNC_HOME%\utils
python -m websockify --web ../ 6901 localhost:5901 