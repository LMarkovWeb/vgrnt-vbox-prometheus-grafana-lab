#!/bin/bash

echo "--------download-------"
curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -

echo "--------untar-------"
tar xvf node_exporter*.tar.gz

echo "--------change dir-------"
cd node_exporter-*

echo "--------move-------"
cp node_exporter /usr/local/bin

echo "-----create user------"
useradd --no-create-home --home-dir / --shell /bin/false node_exporter

echo "--------Create a Service File For Prometheus-------"
touch /etc/systemd/system/node_exporter.service

cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
Type=simple
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter

SyslogIdentifier=node_exporter
Restart=always

PrivateTmp=yes
ProtectHome=yes
NoNewPrivileges=yes

ProtectSystem=strict
ProtectControlGroups=true
ProtectKernelModules=true
ProtectKernelTunables=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start node_exporter
systemctl status node_exporter

echo "------------ Open http://192.168.22.42:9100/ ---------------"