#!/bin/bash

echo "--------create folders-------"
mkdir /var/lib/prometheus
mkdir -p /etc/prometheus/rules /etc/prometheus/rules.d /etc/prometheus/files_sd

echo "--------download-------"
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

echo "--------untar-------"
tar xvf prometheus*.tar.gz

echo "--------change dir-------"
cd prometheus*/

echo "--------move-------"
mv prometheus promtool /usr/local/bin/

echo "--------version-------"
prometheus --version
promtool --version

echo "--------move-------"
mv prometheus.yml /etc/prometheus/prometheus.yml 
mv consoles/ console_libraries/ /etc/prometheus/

echo "--------Create a System User and Group-------"

groupadd --system prometheus
useradd -s /sbin/nologin --system -g prometheus prometheus

chown -R prometheus:prometheus /etc/prometheus
chmod -R 775 /etc/prometheus/
chown -R prometheus:prometheus /var/lib/prometheus/

echo "--------Create a Service File For Prometheus-------"

touch /etc/systemd/system/prometheus.service

cat <<EOF > /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Restart=on-failure
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/
ExecReload=/bin/kill -HUP $MAINPID
ProtectHome=true
ProtectSystem=full

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl start prometheus

echo "-------Prometheus status-------"
systemctl status prometheus

echo "------------ Open http://192.168.22.42:9090/ ---------------"