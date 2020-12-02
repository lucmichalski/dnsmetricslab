# Generate some data and visualise it in Kibana

1. Start ELK 
```
docker-compose -f elk-docker-compose.yml up -d
```

First time you run it you need to have a line uncommented for packetbeat - this created the dashboards in Kabana elk-docker-compose.yml
```
    command: setup -E setup.kibana.host=kibana:5601 # - this only needs to run the first time
```

```
[root@DESKTOP-PK9PDHG dnsmetricslab]# docker-compose -f elk-docker-compose.yml run packetbeat
Creating dnsmetricslab_packetbeat_run ... done
Overwriting ILM policy is disabled. Set `setup.ilm.overwrite: true` for enabling.

Index setup finished.
Loading dashboards (Kibana must be running and reachable)
Loaded dashboards
```

Now comment out that line -  elk-docker-compose.yml
```
    command: setup -E setup.kibana.host=kibana:5601 # - this only needs to run the first time
```


4. Injest pcap directly
```
find ./output/pcap -name *bz2 -exec bzip2 -d "{}" \; && find ./output/pcap -name *.pcap -exec docker-compose -f elk-docker-compose.yml run packetbeat -I "{}" \; -exec rm -rf "{}" \;
```

5. visit kibana http://localhost:5601

6. Create Index Pattern for packetbeat-7.9.3-* 

7. Visualise Data - Note inside packetbeat.yml we are filtering back the fields which are being processed so default DNS packetbeat dashboard not currently showing anything.  Please refer to kibana -> discover
