# zeek-tcpreplay
This Docker image is based on `zeekcurity/zeek:latest` with the addition of tcpreplay and a dummy0 NIC.

Source, etc. at [http://github.com/berthayes/zeek-tcpreplay](https://github.com/berthayes/zeek-tcpreplay)

* tcpreplay is used to read a pcap file and replay it over time.  E.g., if it reads a pcap file that took 3 hours to capture, tcpreplay will take 3 hours to replay those packets.

* The packets are replayed to a "fake" NIC, dummy0 where they're sniffed and processed by Zeek.  Replaying through a fake network interface ensures that even packets captured during malware events can be replayed without risk to your (or your neighbor's) LAN.

* On startup, this image will automatically  look for the file `/pcaps/zeek_streamer.pcap` and use tcpreplay to replay it in a loop 1000000 times.

* You can use any pcap file for automatic reading at startup as long as it's named `zeek_streamer.pcap` and is in a `./pcaps` directory.  This local `./pcaps` directory gets mounted to the root-level `/pcaps` directory inside the running container.

* Other arbitrary pcap files can be read after startup (see below).

* Logs are written a newline delimited JSON to /usr/local/zeek/logs/

* There is no log rotation in the current version, and it's designed to replay an arbitrarily large PCAP file 1000000 times, so don't leave it running too long ;)

## Examples
### To start reading a pcap automatically at start

* First, ensure that you have a `./pcaps` directory inside your working directory and ensure that it contains a pcap file named  `zeek_streamer.pcap` 

```
docker run -d --name zeek-tcpreplay \
-v `pwd`/pcaps/:/pcaps --cap-add=NET_ADMIN \
bertisondocker/zeek-tcpreplay:1.0.0
```

### To read a pcap with a different name
* Start as above.  If sample pcap is named `cincilla_vx.pcap`
```
docker exec -d zeek-tcpreplay /usr/bin/tcpreplay -i dummy0 /pcaps/cincilla_vx.pcap
```

### To sanity check and make sure logs are being created
```
docker exec -it zeek-tcpreplay tail -f /usr/local/zeek/logs/conn.log
```
Note that although this image will generate logs, but it doesn't ship them anywhere. Any number of log agents can be installed once it's up and running.
