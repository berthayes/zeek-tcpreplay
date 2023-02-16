# zeek-tcpreplay
A custom Docker image that uses tcpreplay to feed arbitrary pcaps at arbitrary speed to Zeek via dummy0 NIC.  

Built on top of zeekcurity/zeek:5.0.6

1. Get this code. Note - `pcap` directory contains an 80MB sample file to get you started - this will take a minute or two to download.
```
git clone https://github.com/berthayes/zeek-tcpreplay && cd zeek-tcpreplay
```
2. Build the Docker image (~5 min - YMMV)
```
docker build -t zeek-tcpreplay .
```
3. Start that container!
```
bash runit.sh
```
4. Wait a minute or so for things to start up...
```
sleep 60 && echo "We should be good to go."
```
