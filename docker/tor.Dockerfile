FROM debian:buster

RUN apt-get update \
    && apt-get install -y tor \
    && apt-get install -y git \
    && apt-get install -y build-essential \
    && git clone https://github.com/haad/proxychains.git \
    && cd proxychains \
    && ./configure && make && make install \
    && cp src/proxychains.conf /etc/ \
    && apt-get install -y curl

COPY docker/torrc /etc/tor/torrc

ENTRYPOINT service tor start && tail -f /dev/null