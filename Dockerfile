FROM zeekurity/zeek:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y cmake make gcc g++ flex bison libpcap-dev libssl-dev python3-dev libpython3-dev swig zlib1g-dev git tcpreplay clang net-tools iproute2 softflowd curl wget vim-common tcpdump jq

COPY init_dummy.sh /init_dummy.sh
RUN chmod +x /init_dummy.sh
ENTRYPOINT ["/init_dummy.sh"]