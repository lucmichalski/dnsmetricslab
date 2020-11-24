# DNS Metrics Lab

## Enabled Containers
1. bind
2. query-cannon
3. bind-pcap
4. bind-c-dns (also generates another pcap and cdns file)

## Setup
This command sets sysctl variable on host. On some systems this may not be possible or required. If you can't run it attempt to move on with out running this.
```
sudo sysctl -w vm.max_map_count=262144
```


## Setup ELK

Start ELK Containers
```
docker-compose -f elk-docker-compose.yml up -d
```

## Login to ELK
http://localhost:5601/



## DNS Daemons Listeners
63 = Coredns (disabled)
53 = Bind

## Fire Cannon at 53
### query cannon - https://github.com/aredmond/query-cannon
Single URL
```
docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 127.0.0.1 para www.google.com 5 2'
```

Fire at list of URL's from docker-query-cannon/queries.txt
```
docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 127.0.0.1 urlpara /etc/queries.txt 5 2'

```

## DNS Tap Output
./tap/coredns.dnstap


## Query non standard Port
Query port 63
```
dig google.com @localhost -p 63
```

## Run
```
docker-compose -f dns-docker-compose.yml up -d
```

## Stop
```
docker-compose -f dns-docker-compose.yml down -d
```