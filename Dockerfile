# Pull base image
FROM resin/rpi-raspbian:wheezy
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Define working directory
WORKDIR /opt/btsync

# Add config file
ADD btsync.conf /opt/btsync/etc/

# Install BitTorrent Sync
ADD https://download-cdn.getsyncapp.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz /opt/btsync/
RUN \
  mkdir -p /opt/btsync/bin && \
  mkdir -p /opt/btsync/etc && \
  cd /opt/btsync && \
  tar -xvzf BitTorrent-Sync_arm.tar.gz && \
  rm -f BitTorrent-Sync_arm.tar.gz && \
  mv btsync bin/ && \
  ln -s /lib/arm-linux-gnueabihf/ld-linux.so.3 /lib/ld-linux.so.3

# BitTorrent storage path
VOLUME ["/bt-storage"]

# BitTorrent data path
VOLUME ["/data"]

# BitTorrent Sync web port 8888/tcp
# BitTorrent Sync listening port 5555/udp
EXPOSE 8888
EXPOSE 5555

# Start BitTorrent Sync
CMD ["/opt/btsync/bin/btsync", "--nodaemon", "--config", "/opt/btsync/etc/btsync.conf"]