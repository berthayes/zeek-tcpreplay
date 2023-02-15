#!/bin/sh

# Let's all settle down here
echo "resting 30" && sleep 30

echo "Initializing dummy0 NIC.."
ip link add dummy0 type dummy
ifconfig dummy0 mtu 3000
ifconfig dummy0 up

echo "resting 10"
sleep 10
echo "Starting Zeek"
cd /usr/local/zeek/logs/ && /usr/local/zeek/bin/zeek -i dummy0 local "Site::local_nets += {192.168.1.0/24 }" LogAscii::use_json=T &


echo "Starting tcpreplay"
/usr/bin/tcpreplay -i dummy0 --loop=1000000 /pcaps/zeek_streamer.pcap &
tail -f /dev/null
exec "$@"