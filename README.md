# DNS Metrics Lab

## Setup
run these commands from inside dnsmetricslab folder
```
mkdir -p ./output/logs/bind
mkdir -p ./output/query-cannon
mkdir -p ./output/c-dns
mkdir -p ./output/logs/bind
mkdir -p ./output/pcap
mkdir -p ./output/tap
mkdir -p ./docker-bind/bind
chown 101 ./output/logs/bind
```


## DNS Daemons Listeners
63 = Coredns
73 = Bind


## DNS Tap Output
./tap/coredns.dnstap


## Query non standard Port
Query port 63
```
dig google.com @localhost -p 63
```

## Setup
Make sure that output/logs/bind is owned by user 101
```
chown 101 output/logs/bind
```

## Run
```
docker-compose up
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
[ec2-user@ip-10-202-1-186 dnsmetrics]$ sudo /usr/local/bin/docker-compose run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 172.22.0.3 para www.google.com 5 2'
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
$ sudo /usr/local/bin/docker-compose run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 172.22.0.3 urlpara /etc/queries.txt 5 2'
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
