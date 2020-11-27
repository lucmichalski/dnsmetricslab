# Cloudflare DNS Firewall Statistics via Grafana

## Run the containers
```
[root@DESKTOP-PK9PDHG dnsmetricslab]# docker-compose -f cloudflare-grafana-docker-compose.yml up -d
Creating network "dnsmetricslab_default" with the default driver
Creating dnsmetricslab_cloudflare-grafana_1 ... done
Creating dnsmetricslab_mysql_1              ... done
```

## Visit Grafana

l/p: admin/admin
http://localhost:3000

## Enable Cloudflare plugin inside Grafana
You will need to generate/view your API key from Cloudflare. note: Cloudflare API Tokens do not work 

https://dash.cloudflare.com/profile/api-tokens

Also note that when I first did this I was only able to view zone reports and not the DNS firewall reports.  I logged off and back on to Grafana and I re-keyed my credentials into the cloudflare plugin then it all came good.
