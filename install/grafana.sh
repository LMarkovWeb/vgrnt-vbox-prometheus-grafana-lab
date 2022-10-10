#!/bin/bash

wget https://dl.grafana.com/oss/release/grafana_9.1.7_amd64.deb
dpkg -i grafana_*_amd64.deb

systemctl start grafana
systemctl status grafana

