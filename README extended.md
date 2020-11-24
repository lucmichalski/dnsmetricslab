# DNS Metrics Lab

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

## Setup Packetbeat
You will need to uncomment ELK containers if you would like this to run.

If running ELK then after containers launched for first time comment this line out of elk-docker-compose.yml
```
    command: setup -E setup.kibana.host=127.0.0.1:5601 # - this only needs to run the first time - LINE ~#7
```

NOTE: There is still an issue with changing permissions of the yml file.  This command does not work.
```
chmod go-w /usr/share/packetbeat/packetbeat.yml
```

And then do a down/up
```
docker-compose f elk-docker-compose.yml down
docker-compose f elk-docker-compose.yml up -d
```


## DNS Daemons Listeners
63 = Coredns (disabled)
53 = Bind

## Fire Cannon at 53
docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 127.0.0.1 para www.google.com 5 2'


## DNS Tap Output
./tap/coredns.dnstap


## Query non standard Port
Query port 63
```
dig google.com @127.0.0.1 -p 63
```

## Run
```
docker-compose -f dns-docker-compose.yml up -d
```


## DNS Cannon's

### query cannon - https://github.com/aredmond/query-cannon

Identify internal IP address of docker container you want to query

The IP 172.22.0.3 is the one found in the example below for the coredns container
```
[ec2-user@ip-10-202-1-186 dnsmetrics]$ docker ps
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS              PORTS                                   NAMES
ed02ac23ff8e        mattjtodd/dnstap                 "/app -j -l 0.0.0.0:…"   9 minutes ago       Up 8 minutes                                                dnsmetrics_coredns-dnstap_1
0cf83a1cb6a0        mattjtodd/dnstap                 "/app -j -u /var/run…"   9 minutes ago       Up 8 minutes                                                dnsmetrics_bind-dnstap_1
7d31a4200c86        c-dns:20201029                   "/run.sh -c /etc/com…"   9 minutes ago       Up 8 minutes                                                dnsmetrics_bind-c-dns_1
bf352df29a8b        sameersbn/bind:9.16.1-20200524   "/sbin/entrypoint.sh…"   9 minutes ago       Up 8 minutes        53/tcp, 10000/tcp, 0.0.0.0:73->53/udp   dnsmetrics_bind_1
0c4acade2dec        coredns/coredns                  "/coredns -conf /roo…"   9 minutes ago       Up 8 minutes        53/tcp, 0.0.0.0:63->53/udp              dnsmetrics_coredns_1
d3464a1aa572        corfr/tcpdump                    "/usr/sbin/tcpdump -…"   9 minutes ago       Up 8 minutes                                                dnsmetrics_bind-pcap_1

[ec2-user@ip-10-202-1-186 dnsmetrics]$ docker inspect 0c4acade2dec | grep IP
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
                    "IPAMConfig": null,
                    "IPAddress": "172.22.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
```

Run the cannon against a single URL
```
[ec2-user@ip-10-202-1-186 dnsmetrics]$ docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 127.0.0.1 para www.google.com 5 2'
WARNING: Some services (query-cannon) use the 'deploy' key, which will be ignored. Compose does not support 'deploy' configuration - use `docker stack deploy` to deploy to a swarm.
Making 10 query/ies. Across 2 process/es.
2020-11-04 05:31:18,413 INFO services.py:1164 -- View the Ray dashboard at http://127.0.0.1:8265
(pid=85) Making 5 query/ies.
(pid=86) Making 5 query/ies.
(pid=85) 38 bytes request: www.google.com from 172.22.0.3: time=48.092 ms
(pid=85) 38 bytes request: www.google.com from 172.22.0.3: time=0.242 ms
(pid=85) 38 bytes request: www.google.com from 172.22.0.3: time=0.268 ms
(pid=85) 38 bytes request: www.google.com from 172.22.0.3: time=0.236 ms
(pid=85) 38 bytes request: www.google.com from 172.22.0.3: time=0.521 ms
(pid=86) 38 bytes request: www.google.com from 172.22.0.3: time=35.107 ms
(pid=86) 38 bytes request: www.google.com from 172.22.0.3: time=0.281 ms
(pid=86) 38 bytes request: www.google.com from 172.22.0.3: time=0.714 ms
(pid=86) 38 bytes request: www.google.com from 172.22.0.3: time=0.721 ms
(pid=86) 38 bytes request: www.google.com from 172.22.0.3: time=0.232 ms
```

Run the cannon against a list or URL's
```
$  docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 172.22.0.3 urlpara /etc/queries.txt 5 2'
``` 

### kxdpgun
I had trouble getting this to work in a docker container so i have let it go for now.  This was the error using fedora;
```
[root@5a525391c09e /]# kxdpgun -i /docker-knot-utils/queries.txt -p 63 8.8.8.8
execve: No such file or directory
execve: No such file or directory
can't get remote MAC of `8.8.8.8` by ARP query: not exists
```

This was the error in centos
```
[root@ip-10-202-1-186 /]# kxdpgun -i /docker-knot-utils/queries.txt -p 63 8.8.8.8
libbpf: Error in bpf_object__probe_name():Operation not permitted(1). Couldn't load basic 'r0 = 0' BPF program.
libbpf: Error in bpf_object__probe_global_data():Operation not permitted(1). Couldn't create simple array map.
libbpf: failed to create map (name: 'qidconf_map'): Operation not permitted(-1)
libbpf: failed to load object '7fa7fe9aa040-698'
failed to initialize XDP socket#0: program not loaded

total queries: 0 (0 pps)
```

## ELK Presenter
### References
https://www.elastic.co/blog/analyzing-network-packets-with-wireshark-elasticsearch-and-kibana


### Convert pcap to elasticsearch json manually

Suck in ./output/pcap/20201105-050340_300_eth0.raw.pcap
Output to ./output/es/test.json

```
docker-compose -f dns-docker-compose.yml run --entrypoint 'tshark' tshark -r /pcap/20201105-050340_300_eth0.raw.pcap -T ek > output/tshark/packets.json
```

### Input pcap into elasticsearch
Logstash is configured to look in the ./output/tshark folder and pickup any json files


### Elasticsearch Index Pattern
NEED TO FIGURE OUT HOW TO DO THIS

```
curl -X PUT "localhost:9200/_template/packets?pretty" -H 'Content-Type: application/json' -d'
{
  "template": "packets-*",
  "mappings": {
    "pcap_file": {
      "dynamic": "false",
      "properties": {
        "timestamp": {
          "type": "date"
        },
        "layers": {
          "properties": {
            "frame": {
              "properties": {
                "frame_frame_len": {
                  "type": "text"
                },
                "frame_frame_protocols": {
                  "type": "keyword"
                }
              }
            },
            "ip": {
              "properties": {
                "ip_ip_src": {
                  "type": "ip"
                },
                "ip_ip_dst": {
                  "type": "ip"
                }
              }
            },
            "udp": {
              "properties": {
                "udp_udp_srcport": {
                  "type": "integer"
                },
                "udp_udp_dstport": {
                  "type": "integer"
                }
              }
            }
          }
        }
      }
    }
  }
}
'
```
