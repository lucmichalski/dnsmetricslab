# Generate some data and visualise it in Kibana

1. Startup 
```
docker-compose -f dns-docker-compose.yml up -d
```

2. Run Cannon
```
docker-compose -f dns-docker-compose.yml run --entrypoint '/bin/bash -c' query-cannon 'cd /query-cannon/.env/bin/ && ./qcan fire -v 127.0.0.1 urlpara /etc/queries.txt 50 200'
```

3. Stop
```
docker-compose -f dns-docker-compose.yml down -d
```

4. Locate pcap to convert
```
[root@DESKTOP-PK9PDHG dnsmetricslab]# ls output/c-dns -sl
total 60588
 1060 -rwxrwxrwx 1 root root  1084165 Nov 17 10:05 20201116-230507_300_docker0-eth0-lo.raw.bind.pcap
    8 -rwxrwxrwx 1 root root     6062 Nov 17 10:05 20201116-230509_300_docker0-eth0-lo.bind.cdns
    4 -rwxrwxrwx 1 root root     1298 Nov 24 16:43 20201124-054325_300_docker0-eth0-lo.bind.cdns
 4092 -rwxrwxrwx 1 root root  4188332 Nov 24 16:43 20201124-054325_300_docker0-eth0-lo.raw.bind.pcap
    4 -rwxrwxrwx 1 root root     1544 Nov 24 23:10 20201124-113148_300_docker0-eth0-lo.bind.cdns
15928 -rwxrwxrwx 1 root root 16306752 Nov 24 23:01 20201124-113148_300_docker0-eth0-lo.raw.bind.pcap
    0 -rwxrwxrwx 1 root root      110 Nov 24 23:10 20201124-120107_300_docker0-eth0-lo.raw.bind.pcap
  280 -rwxrwxrwx 1 root root   285971 Nov 24 23:16 20201124-121119_300_docker0-eth0-lo.bind.cdns
32992 -rwxrwxrwx 1 root root 33779794 Nov 24 23:16 20201124-121119_300_docker0-eth0-lo.raw.bind.pcap
  204 -rwxrwxrwx 1 root root   206217 Nov 24 23:17 20201124-121619_300_docker0-eth0-lo.bind.cdns
 6016 -rwxrwxrwx 1 root root  6158835 Nov 24 23:17 20201124-121619_300_docker0-eth0-lo.raw.bind.pcap
```

4. Convert from pcap to json (very slow)
```
docker-compose -f dns-docker-compose.yml run --entrypoint 'tshark' tshark -r /pcap/20201124-121119_300_docker0-eth0-lo.raw.bind.pcap -T ek > output/tshark/packets.json
```

5. bring up ELK and observe (very slow)
```
docker-compose -f elk-docker-compose.yml up -d
```

6. visit kibana http://localhost:5601
(DNS overview dashboard = http://127.0.0.1:5601/app/dashboards#/view/65120940-1454-11e9-9de0-f98d1808db8e-ecs?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(description:'Overview%20of%20DNS%20request%20and%20response%20metrics.',filters:!(),fullScreenMode:!f,options:(darkTheme:!f,hidePanelTitles:!f,useMargins:!t),query:(language:kuery,query:''),timeRestore:!f,title:'%5BPacketbeat%5D%20DNS%20Overview%20ECS',viewMode:view))