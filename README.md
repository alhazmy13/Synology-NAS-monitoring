# Synology NAS monitoring

![alt text](https://github.com/alhazmy13/Synology-NAS-monitoring/blob/master/dashboard.png)

The main points of this project are:

* Persistence is supported via mounting volumes to a Docker container.
* Grafana will store its data in SQLite files instead of a MySQL.
* Added snmp packages and Synology NAS MIBS.
* Enable 

## Enable SNMP
1. From Control panel in your Synology NAS go to Terminal & SNMP
2. Click on SNMP tab, and enable SNMPv1, SNMPv2 service
3. in Community input put ***public***
4. Save

## Run Docker image in your Synology

1. Install Docker from Synology package center
2. Create two empty folders in your Synology ***influxdb*** and ***grafana***, we need to use it later to mount it to our container.
3. Open Docker client from Synology > Image > Add > Add from url and paste Hub page url "https://hub.docker.com/r/alhazmy13/telegraf-influxdb-grafana"
4. Wait until it finishes downloading the image
5. Click on the image "alhazmy13/telegraf-influxdb-grafana" and then click on Launch
6. Network Tab keep it in bridge mode 
7. Check "Enable auto-restart."
8. Port settings, just change Local port for 3003 from Auto to 3003, and port 514 from Auto to 5144
9. In Volume settings, click Add folder and select the first folder that we created, "grafana" and on mount Path, paste ***/var/lib/grafana***
10. In Volume settings again, click Add Folder and select the second folder that we created "influxdb" and on mount Path paste ***/var/lib/influxdb***
12. [OPTIONAL] Environment Tab > Add new variable "TZ" with your local time zone **ignore this if you want to use the default UTC**
14. Apply, Next, Done and your container should be ready.

## Start Grafana

1. Open [http://YOUR_LOCAL_NAS_IP:3003](http://YOUR_LOCAL_NAS_IP:3003) and login with the default username ***root*** and password ***root***
2. You need to import the dashboard. To do this, go to [http://YOUR_LOCAL_NAS_IP:3003/dashboard/import](http://YOUR_LOCAL_NAS_IP:3003/dashboard/import) and put ***14590*** in "Import via grafana.com" input
3. Click on load and complete the process

## Enable Logging
1. Install Log center From Synology package center
2. Open Log center app
3. Click on Log Sending > check "Send log to syslog server"
3. Set Server = ***localhost***,  port = ***5144***, Protocol = ***UDP***, Format = ***BSD (RFC 3164)***
4. For testing, click on "Send test log" 
4. Apply

## Configure Firewall
If the firewall is enabled, then you need to add a new rule for port UDP/161, This is mandatory otherwise, some data will be missing from the dashboard https://github.com/alhazmy13/Synology-NAS-monitoring/issues/7 .

1.  Open Control panel
2.  Security -> Firewall
3.  Edit Rules -> Create New Rule
4.  In the ports section, select from a built-in applications and chose SNMP service
5.  In the IP section select Spesifc IP -> subnet -> Source: 172.12.0.0 / subnet: 255.255.0.0
6.  Action = Allow
7.  Disable and re-enable the firewall for it to take effect
