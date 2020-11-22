#!/bin/sh

/opt/etc/init.d/S81zmp stop
killall zmp-linux-mipsle
rm -rf /opt/bin/zmp-linux-mipsle
rm -rf /opt/bin/zmp.sh
rm -rf /opt/etc/init.d/S81zmp
rm -rf /opt/etc/zmp
sed -i '/zmp.sh/d' /opt/etc/crontab

opkg update
opkg install cron curl ca-certificates
curl -k -f -o /opt/bin/zmp-linux-mipsle https://raw.githubusercontent.com/Kyrie1965/zmp_entware/main/zmp-linux-mipsle
curl -k -f -o /opt/bin/zmp.sh https://raw.githubusercontent.com/Kyrie1965/zmp_entware/main/zmp_curl.sh
curl -k -f -o /opt/etc/init.d/S81zmp https://raw.githubusercontent.com/Kyrie1965/zmp_entware/main/S81zmp
chmod +x /opt/bin/zmp-linux-mipsle
chmod +x /opt/bin/zmp.sh
chmod +x /opt/etc/init.d/S81zmp

lanip=$(ndmq -p 'show interface Bridge0' -P address)
sed -i "s/192.168.0.1/${lanip}/g" /opt/etc/init.d/S81zmp
chmod 0600 /opt/etc/crontab
echo "0 6 * * * root /opt/bin/zmp.sh" >> /opt/etc/crontab
/opt/etc/init.d/S10cron start
/opt/bin/zmp.sh
