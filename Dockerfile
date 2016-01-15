FROM        debian

MAINTAINER  Kaija Chang "http://github.com/kaija"

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes libhwloc-plugins libhwloc5 libltdl7 libnuma1 libpciaccess0 libaio1 libtcl8.6 libunwind8 libxml2 sgml-base xml-core libssl1.0.0

# Install TrafficServer
ADD ./trafficserver_6.0.0-2_amd64.deb /var/cache/apt/archives/
RUN dpkg -i /var/cache/apt/archives/trafficserver_6.0.0-2_amd64.deb
RUN mkdir -p /var/run/trafficserver
ADD ./etc/trafficserver /etc/trafficserver

EXPOSE 8080

CMD ["traffic_server"]
