FROM        debian

MAINTAINER  Kaija Chang "http://github.com/kaija"

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl locales build-essential bzip2 libssl-dev libxml2-dev libpcre3-dev tcl-dev libboost-dev

# Configure locale
RUN export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install TrafficServer
RUN mkdir -p /downloads/trafficserver
RUN wget http://apache.stu.edu.tw/trafficserver/trafficserver-6.0.0.tar.bz2 -O /downloads/trafficserver.tar.bz2
RUN cd /downloads && tar xvf trafficserver.tar.bz2 -C /downloads/trafficserver --strip-components 1
RUN cd /downloads/trafficserver && ./configure --prefix=/opt/trafficserver
RUN cd /downloads/trafficserver && make
RUN cd /downloads/trafficserver && make install
#RUN rm -rf /opt/trafficserver/etc/trafficserver
ADD ./files/etc/trafficserver /etc/trafficserver
RUN mv /opt/trafficserver/etc/trafficserver /etc/trafficserver
RUN ln -sf /etc/trafficserver /opt/trafficserver/etc/trafficserver

EXPOSE 8080

CMD ["/opt/trafficserver/bin/traffic_server"]

