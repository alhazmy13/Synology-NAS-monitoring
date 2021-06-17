# Synology NAS monitoring

![alt text](https://github.com/alhazmy13/Synology-NAS-monitoring/blob/master/dashboard.png)

The main points of this project are:

* Persistence is supported via mounting volumes to a Docker container.
* Grafana will store its data in SQLite files instead of a MySQL.
* Added snmp packages and Synology NAS MIBS.
* Enable 

## Run Docker image in your Synology

1. Install Docker from Synology package center
2. Create two empty folders in your Synology "influxdb" and "grafana", we need to use it later to mount it to our container.
3. Open Docker client from Synslogy > Image > Add > Add from url and paste Hub page url "https://hub.docker.com/r/alhazmy13/telegraf-influxdb-grafana"
4. Wait until it finishes downloading the image
5. Click on the image "alhazmy13/telegraf-influxdb-grafana" and then click on Lunch 
6. Click on Advanced Settings and check "Enable auto-restart."
7. From the Volume tab, click Add folder and select the first folder that we created, "grafana" and on mount Path, paste "/var/lib/grafana"
8. From the Volume tab again, click Add Folder and select the second folder that we created "influxdb" and on mount Path paste "/var/lib/influxdb"
9. Network Tab keep it in bridge mode
10. Port settings, just change Local port for 3003 from Auto to 3003, and port 514 from Auto to 5144
11. Envirument Tab > Add new variable "TZ" with your local time zone **ignore this if you want to use the default UTC**
12. Apply, Next, Done and your container should be ready.

## Start Grafana

1. Open [http://YOUR_LOCAL_NAS_IP:3003](http://YOUR_LOCAL_NAS_IP:3003) and login with the default username "root" and password "root"
2. You need to import the dashboard. To do this, go to [http://YOUR_LOCAL_NAS_IP:3003/dashboard/import](http://YOUR_LOCAL_NAS_IP:3003/dashboard/import) and put "14590" in "Import via grafana.com" input
3. click on load and complete the process

## Enable Logging
1. Install Log center From Synslogy package center
2. Open Log center app
3. click on Log Sending > check "Send log to syslog server"
3. Set Server = "localhost",  port = "5144", Protocol = "UDP", Format = "BSD (RFC 3164)"
4. For testing, click on "Send test log" 
4. Apply
