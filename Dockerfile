FROM debian:bullseye-slim

LABEL maintainer="frepke"

ENV DEBIAN_FRONTEND noninteractive

LABEL org.label-schema.build-date=$BUILD_DATE

WORKDIR /opt/domoticz

RUN apt-get update && apt-get install -y \
    wget curl make nano gcc g++ gdb libssl-dev git libcurl4-gnutls-dev libusb-dev libsqlite3-dev python3-dev zlib1g-dev libcereal-dev liblua5.3-dev uthash-dev perl cpanminus && \
    cpanm Device::Modbus Net::Server Role::Tiny Try::Tiny Device::Modbus::TCP && \
    mkdir -p /opt/domoticz && \
    wget -qO- https://releases.domoticz.com/releases/release/domoticz_linux_x86_64.tgz | tar xz -C /opt/domoticz && \
    git clone https://github.com/tjko/sunspec-monitor.git /opt/sunspec-monitor
    
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/domoticz/domoticz" \
      org.label-schema.url="https://domoticz.com/" \
      org.label-schema.name="Domoticz" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="GPLv3" \
      org.label-schema.build-date=$BUILD_DATE

EXPOSE 8080 443 6144

VOLUME /config
VOLUME /opt/domoticz/backups

ENTRYPOINT [ "/opt/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log" ]
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1

