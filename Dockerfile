FROM debian:buster-slim

ARG APP_HASH
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$APP_HASH \
      org.label-schema.vcs-url="https://github.com/domoticz/domoticz" \
      org.label-schema.url="https://domoticz.com/" \
      org.label-schema.name="Domoticz" \
      org.label-schema.license="GPLv3" \
      org.label-schema.build-date=$BUILD_DATE

WORKDIR /opt/domoticz

RUN apt-get update -y && \
    apt-get install -y wget curl make gcc g++ gdb libssl-dev git libcurl4-gnutls-dev libusb-dev python3-dev zlib1g-dev libcereal-dev liblua5.3-dev uthash-dev perl cpanminus && \
    cpanm Device::Modbus Net::Server Role::Tiny Try::Tiny Device::Modbus::TCP && \
    mkdir -p /opt/domoticz && \
    wget -qO- http://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz | tar xz -C /opt/domoticz && \
    sed -i '/update2.html/d' /opt/domoticz/www/html5.appcache && \
    git clone https://github.com/tjko/sunspec-monitor.git /opt/sunspec-monitor

EXPOSE 8080/tcp 443/tcp 6144
VOLUME /config
ENTRYPOINT [ "/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log" ]
