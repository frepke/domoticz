# domoticz

SUNSPEC-MONITOR

Monitoring SolarEdge inverters over Modbus TCP

Configure SolarEdge MODBUS over TCP: https://www.solaredge.com/sites/default/files/sunspec-implementation-technical-note.pdf#%5B%7B%22num%22%3A66%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C34%2C642%2C0%5D

Sunspec-monitor: https://github.com/tjko/sunspec-monitor

From inside the Domoticz (shell access or script) container: /opt/sunspec-monitor/sunspec-status -m 0 -j -t 5 local.ip.inverter || echo error

Shell access whilst the container is running: docker exec -it domoticz /bin/bash
