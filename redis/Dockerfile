FROM redis

MAINTAINER "Abhinav K"

RUN apt-get update && apt-get install -yq git make gcc libevent-dev \
    && rm -rf /var/lib/apt/lists/*
RUN cd /root && git clone git://github.com/nicolasff/webdis.git \
    && cd webdis && make

