# Domoticz 2024.4 (stable)

Domoticz is a Home Automation System that lets you monitor and configure various devices like: Lights, Switches, various sensors/meters like Temperature, Rain, Wind, UV, Electra, Gas, Water and much more. Notifications/Alerts can be sent to any mobile device.

[![](https://raw.githubusercontent.com/domoticz/domoticz/master/www/images/logo.png)](https://www.domoticz.com/)

![Domoticz](https://img.shields.io/badge/Domoticz-2024.4-orange)
![build](https://img.shields.io/badge/Build-15889_(stable)-orange)

![code-language](https://img.shields.io/github/languages/top/frepke/domoticz)
![code-size](https://img.shields.io/github/languages/code-size/frepke/domoticz)
![last-commit](https://img.shields.io/github/last-commit/frepke/domoticz/master)
[![ci](https://github.com/frepke/domoticz/actions/workflows/docker-image.yml/badge.svg)](https://github.com/frepke/domoticz/actions/workflows/docker-image.yml)

![AMD64](https://img.shields.io/badge/Architecture-AMD64-darkred)

![license](https://img.shields.io/github/license/Frepke/domoticz)

## Usage

Here are some example snippets to help you get started creating and running a container.

**docker**

```markdown
docker run -d \
  --name=domoticz \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Amsterdam \
  -p 8080:8080 \
  -p 6144:6144 \
  -p 1443:443 \
  -v path to data:/config \
  --device path to device:path to device \
  --restart unless-stopped \
  ghcr.io/frepke/domoticz:stable
```

**Passing Through USB Devices**

To get full use of Domoticz, you probably have a USB device you want to pass through. To figure out which device to pass through, you have to connect the device and look in dmesg for the device node created. Issue the command 'dmesg | tail' after you connected your device and you should see something like below.

```markdown
usb 1-1.2: new full-speed USB device number 7 using ehci-pci
ftdi_sio 1-1.2:1.0: FTDI USB Serial Device converter detected
usb 1-1.2: Detected FT232RL
usb 1-1.2: FTDI USB Serial Device converter now attached to ttyUSB0
As you can see above, the device node created is ttyUSB0. It does not say where, but it's almost always in /dev/. The correct tag for passing through this USB device is '--device /dev/ttyUSB0:/dev/ttyUSB0'
```

**docker-compose**

Compatible with docker-compose v3 schemas.

```markdown
---
version: "3"
services:
  domoticz:
    image: ghcr.io/frepke/domoticz:stable
    container_name: domoticz
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Amsterdam
    volumes:
      - path to data:/config
    ports:
      - 8080:8080
      - 6144:6144
      - 1443:443
    devices:
      - path to device:path to device
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate external:internal respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.

Parameter  | Function
------------- | -------------
-p 8080| GUI
-p 6144| Domoticz communication port.
-p 443| Domoticz communication port.
-e PUID=1000| for UserID - see below for explanation.
-e PGID=1000| for GroupID - see below for explanation.
-e TZ=Europe/Amsterdam| Specify a timezone to use EG Europe/Amsterdam.
-v /config| Where Domoticz stores config files and data.
--device| path to device for passing through USB devices.

## User / Group Identifiers

When using volumes (-v flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance PUID=1000 and PGID=1000, to find yours use id user as below:

  ```markdown
$ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application Setup

To configure Domoticz, go to the IP of your docker host on the port you configured (default 8080), and add your hardware in Setup > Hardware. The user manual is available at www.domoticz.com

## Support Info

- Shell access whilst the container is running: `docker exec -it domoticz /bin/bash`
- To monitor the logs of the container in realtime: `docker logs -f domoticz`
- container version number `docker inspect -f '{{ index .Config.Labels "build_version" }}' domoticz`
- image version number `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/domoticz`

## Sunspec-monitor

Monitoring SolarEdge inverters over Modbus TCP

***Configure SolarEdge MODBUS over TCP:***
<https://www.solaredge.com/sites/default/files/sunspec-implementation-technical-note.pdf> (look for the "MODBUS over TCP Support" section).

***Sunspec-monitor:*** <https://github.com/tjko/sunspec-monitor>

***From inside the Domoticz (shell or Domoticz script) container:***
`/opt/sunspec-monitor/sunspec-status -m 0 -j -t 5 *local.ip.inverter* || echo error`



<a href="https://www.buymeacoffee.com/frepke"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=frepke&button_colour=5F7FFF&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00"></a>
