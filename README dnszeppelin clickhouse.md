# Niclabs dnszeppelin with Clickhouse

You can run an example using docker-compose inside the docker folder. This contain godnscaptureclickhouse, clickhouse and grafana. You will need to add the datasource manually using the hostname clickhouse, create the tables and upload the file docker/grafana/panel.json to grafana when creating a new panel.

References
https://github.com/niclabs/dnszeppelin-clickhouse
https://www.usenix.org/sites/default/files/conference/protected-files/srecon18americas_slides_espinoza_bustos.pdf


Related Fork Project
https://gitlab.com/mosajjal/dnsmonster
https://blog.n0p.me/2020/08/2020-08-15-analysing-big-pcap/


Setup Clickhouse Tables
```
cat docker-dnszeppelin-clickhouse/tables.sql | docker run -i -a stdin --rm --net=host yandex/clickhouse-client --multiquery
```

Startup dnszeppelin clickhouse grafana
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml up -d
```


Find inside the container and specify servername aefjr1
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run dnszeppelin '/bin/sh' '-c' 'find ./pcap/aefjr1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aefjr1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
```

aumel1
```
docker-compose -f dnszeppelin-clickhouse-docker-compose.yml run dnszeppelin '/bin/sh' '-c' 'find ./pcap/aumel1/ -name *.pcap -exec /usr/local/bin/go-wrapper run -clickhouseAddress clickhouse:9000 -serverName aumel1 -pcapFile "{}" \; -exec rm -rf "{}" \;'
```
