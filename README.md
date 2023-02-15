# zeek-tcpreplay
A custom Docker image uses tcpreplay to feed arbitrary pcaps to Zeek via dummy0 NIC.  

Built on top of zeekcurity/zeek:5.0.6

1. Get this code
```
git clone https://github.com/berthayes/zeek-tcpreplay && cd zeek-tcpreplay
```
1. Build the Docker image (~5 min - YMMV)
```
cd zeek-tcpreplay 
docker build -t zeek-tcpreplay .
```