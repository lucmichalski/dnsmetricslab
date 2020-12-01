# Niclabs dnszeppelin with Clickhouse

You can run an example using docker-compose inside the docker folder. This contain godnscaptureclickhouse, clickhouse and grafana. You will need to add the datasource manually using the hostname clickhouse, create the tables and upload the file docker/grafana/panel.json to grafana when creating a new panel.

References
https://github.com/niclabs/dnszeppelin-clickhouse
https://www.usenix.org/sites/default/files/conference/protected-files/srecon18americas_slides_espinoza_bustos.pdf


Related Fork Project
https://gitlab.com/mosajjal/dnsmonster
https://blog.n0p.me/2020/08/2020-08-15-analysing-big-pcap/


Startup dnszeppelin clickhouse grafana
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml up -d
```

Setup Clickhouse Tables
```
cat docker-dnszeppelin-clickhouse/tables.sql | docker run -i -a stdin --rm --net=host yandex/clickhouse-client --multiquery
```

Find inside the container and specify servername aefjr1
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run dnszeppelin '/bin/sh' '-c' 'find ./pcap/aefjr1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aefjr1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
```

aumel1
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run dnszeppelin '/bin/sh' '-c' 'find ./pcap/aumel1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aumel1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
```

bzip2 extract
```
# find  output/pcap/ -name *.bz2 -exec bzip2 -d "{}" \;
```

walk the pcaps - run container detached
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/aefjr1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aefjr1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/aumel1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aumel1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/ausyd1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName ausyd1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/brsao1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName brsao1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/cnbjs1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName cnbjs1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/cnsgh1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName cnsgh1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/cobog1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName cobog1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/cobog2/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName cobog2 -pcapFile "{}" \; -exec rm -rf "{}" \;' 
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/defra1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName defra1 -pcapFile "{}" \; -exec rm -rf "{}" \;' 
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/esmad1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName esmad1 -pcapFile "{}" \; -exec rm -rf "{}" \;' 
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/frpar1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName frpar1 -pcapFile "{}" \; -exec rm -rf "{}" \;' 
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/gblon1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName gblon1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/hkhkg1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName hkhkg1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/inbom1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName inbom1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/indel1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName indel1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/jptyo1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName jptyo1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/nlams1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName nlams1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/plwaw1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName plwaw1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/sesto1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName sesto1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/sgsin1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName sgsin1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/twtpe1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName twtpe1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/uschi1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName uschi1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/usdal1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName usdal1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/uslax1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName uslax1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/usnyc1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName usnyc1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/ussea1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName ussea1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/ussjc1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName ussjc1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/uswas1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName uswas1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run -d dnszeppelin '/bin/sh' '-c' 'find ./pcap/zajnb1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName zajnb1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
```