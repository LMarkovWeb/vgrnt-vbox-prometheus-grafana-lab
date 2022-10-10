# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = "2192"
     vb.cpus = 2
  end

  config.vm.define "srv" do |conf|
    conf.vm.box = "peru/ubuntu-20.04-server-amd64"
    conf.vm.hostname = 'srv.local'
    conf.vm.network "private_network", ip: "192.168.22.42"
    conf.vm.provision "shell", path: "install/bootstrap.sh"
    conf.vm.provision "shell", path: "install/prometheus.sh"
    conf.vm.provision "shell", path: "install/node-exporter.sh"
    conf.vm.provision "shell", path: "install/alertmanager.sh"
    conf.vm.provision "shell", path: "install/grafana.sh"
  end
  
  config.vm.define "node1" do |conf|
    conf.vm.box = "peru/ubuntu-20.04-server-amd64"
    conf.vm.hostname = 'node1.local'
    conf.vm.network "private_network", ip: "192.168.22.43"
    conf.vm.provision "shell", path: "install/bootstrap.sh"
    conf.vm.provision "shell", path: "install/node-exporter.sh"
    conf.vm.provision "shell", path: "install/alertmanager.sh"
    conf.vm.provision "shell", path: "install/grafana.sh"
  end 
end