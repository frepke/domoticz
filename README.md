# domoticz

Usage

Here are some example snippets to help you get started creating a container.

docker

docker create \
  --name=domoticz \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Amsterdam \
  -e WEBROOT=domoticz `#optional` \
  -p 8080:8080 \
  -p 6144:6144 \
  -p 1443:443 \
  -v path to data:/config \
  --device path to device:path to device \
  --restart unless-stopped \
  frepke/domoticz
  
Passing Through USB Devices

To get full use of Domoticz, you probably have a USB device you want to pass through. To figure out which device to pass through, you have to connect the device and look in dmesg for the device node created. Issue the command 'dmesg | tail' after you connected your device and you should see something like below.

usb 1-1.2: new full-speed USB device number 7 using ehci-pci
ftdi_sio 1-1.2:1.0: FTDI USB Serial Device converter detected
usb 1-1.2: Detected FT232RL
usb 1-1.2: FTDI USB Serial Device converter now attached to ttyUSB0
As you can see above, the device node created is ttyUSB0. It does not say where, but it's almost always in /dev/. The correct tag for passing through this USB device is '--device /dev/ttyUSB0:/dev/ttyUSB0'

docker-compose

Compatible with docker-compose v2 schemas.

---
version: "2"
services:
  domoticz:
    image: frepke/domoticz
    container_name: domoticz
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Amsterdam
      - WEBROOT=domoticz #optional
    volumes:
      - path to data:/config
    ports:
      - 8080:8080
      - 6144:6144
      - 1443:443
    devices:
      - path to device:path to device
    restart: unless-stopped

SUNSPEC-MONITOR

Monitoring SolarEdge inverters over Modbus TCP

Configure SolarEdge MODBUS over TCP: https://www.solaredge.com/sites/default/files/sunspec-implementation-technical-note.pdf#%5B%7B%22num%22%3A66%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C34%2C642%2C0%5D

Sunspec-monitor: https://github.com/tjko/sunspec-monitor

From inside the Domoticz (shell access or script) container: /opt/sunspec-monitor/sunspec-status -m 0 -j -t 5 local.ip.inverter || echo error

Shell access whilst the container is running: docker exec -it domoticz /bin/bash
